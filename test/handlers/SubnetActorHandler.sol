// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/console.sol";
import "forge-std/StdUtils.sol";
import "forge-std/StdCheats.sol";
import {CommonBase} from "forge-std/Base.sol";

import {SubnetActorDiamond} from "../../src/SubnetActorDiamond.sol";
import {SubnetActorManagerFacet} from "../../src/subnet/SubnetActorManagerFacet.sol";
import {SubnetActorGetterFacet} from "../../src/subnet/SubnetActorGetterFacet.sol";
import {SubnetActorManagerFacetMock} from "../mocks/SubnetActor.sol";

import {ConsensusType} from "../../src/enums/ConsensusType.sol";
import {SubnetID} from "../../src/structs/Subnet.sol";
import {SubnetIDHelper} from "../../src/lib/SubnetIDHelper.sol";

import {TestUtils} from "../TestUtils.sol";

import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";

uint256 constant ETH_SUPPLY = 129_590_000 ether;

contract SubnetActorHandler is CommonBase, StdCheats, StdUtils {
    using EnumerableSet for EnumerableSet.AddressSet;

    SubnetActorManagerFacetMock private managerFacet;
    SubnetActorGetterFacet private getterFacet;

    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;

    // Ghost variables.
    EnumerableSet.AddressSet private ghost_validators;
    uint256 public ghost_stakedSum;
    uint256 public ghost_unstakedSum;
    mapping(address => uint256) public ghost_validators_staked;
    mapping(address => uint256) public ghost_validators_unstaked;

    constructor(SubnetActorDiamond _subnetActor) {
        managerFacet = SubnetActorManagerFacetMock(address(_subnetActor));
        getterFacet = SubnetActorGetterFacet(address(_subnetActor));

        deal(address(this), ETH_SUPPLY);
    }

    /// getRandomValidator returns a validator address
    function getRandomValidator(address addr) internal view returns (address) {
        if (ghost_validators.contains(addr)) {
            return addr;
        }
        uint256 length = ghost_validators.length();
        uint256 seed = uint8(uint160(addr));
        if (length == 0 || seed % 4 == 0) {
            return msg.sender;
        } else {
            return ghost_validators.values()[seed % length];
        }
    }

    function getRandomValidatorFromSet() public view returns (address) {
        uint256 seed = ghost_stakedSum;
        uint256 length = ghost_validators.length();
        if (length == 0) {
            return address(0);
        }
        return ghost_validators.values()[seed % length];
    }

    function joinedValidatorsNumber() public view returns (uint256) {
        return ghost_validators.values().length;
    }

    // init adds an initial validator into the subnet.
    function init() external {
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        (address validator, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        _pay(validator, amount);
        vm.prank(validator);
        managerFacet.join{value: amount}(publicKey);

        ghost_validators.add(validator);
        ghost_stakedSum += amount;
        ghost_validators_staked[validator] += amount;
    }

    function join(uint8 id, uint256 amount) public {
        if (id == 0) {
            return;
        }
        amount = bound(amount, 0, 2 * DEFAULT_MIN_VALIDATOR_STAKE);

        (address validator, bytes memory publicKey) = TestUtils.deriveValidatorAddress(id);

        _pay(validator, amount);
        vm.prank(validator);
        managerFacet.join{value: amount}(publicKey);
        managerFacet.confirmNextChange();

        ghost_stakedSum += amount;
        ghost_validators_staked[validator] += amount;
        ghost_validators.add(validator);
    }

    function stake(address seed, uint256 amount) public {
        amount = bound(amount, 0, 2 * DEFAULT_MIN_VALIDATOR_STAKE);
        address validator = getRandomValidator(seed);
        _pay(validator, amount);

        vm.prank(validator);
        managerFacet.stake{value: amount}();
        managerFacet.confirmNextChange();

        ghost_stakedSum += amount;
        ghost_validators_staked[validator] += amount;
    }

    function unstake(address seed, uint256 amount) public {
        amount = bound(amount, 0, 2 * DEFAULT_MIN_VALIDATOR_STAKE);
        address validator = getRandomValidator(seed);

        vm.prank(validator);
        managerFacet.unstake(amount);
        managerFacet.confirmNextChange();

        ghost_unstakedSum += amount;
        ghost_validators_unstaked[validator] += amount;
    }

    function leave(address seed) public {
        address validator = getRandomValidator(seed);

        uint256 amount = getterFacet.getTotalValidatorCollateral(validator);

        vm.prank(validator);
        managerFacet.leave();
        managerFacet.confirmNextChange();

        ghost_validators.remove(validator);
        ghost_validators_unstaked[validator] = amount;
        ghost_unstakedSum += amount;
    }

    function _pay(address to, uint256 amount) internal {
        (bool s, ) = to.call{value: amount}("");
        require(s, "pay() failed");
    }

    receive() external payable {}
}
