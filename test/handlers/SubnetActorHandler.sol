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

uint256 constant ETH_SUPPLY = 120_500_000 ether;

contract SubnetActorHandler is CommonBase, StdCheats, StdUtils {
    using EnumerableSet for EnumerableSet.AddressSet;

    SubnetActorManagerFacetMock private managerFacet;
    SubnetActorGetterFacet private getterFacet;

    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint64 private _configurationNumber = 1;

    // Ghost variables.
    EnumerableSet.AddressSet private ghost_validators;
    uint256 public ghost_stakedSum;
    uint256 public ghost_unstakedSum;
    mapping(address => uint256) public ghost_staked;

    constructor(SubnetActorDiamond _subnetActor) {
        managerFacet = SubnetActorManagerFacetMock(address(_subnetActor));
        getterFacet = SubnetActorGetterFacet(address(_subnetActor));

        deal(address(this), ETH_SUPPLY);
    }

    /// getRandomValidator returns a validator address
    function getRandomValidator(uint8 seed) internal view returns (address) {
        uint256 lenght = ghost_validators.length();
        if (lenght == 0 || seed % 4 == 0) {
            return msg.sender;
        } else {
            return ghost_validators.values()[seed % lenght];
        }
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
        _configurationNumber = 0;

        ghost_validators.add(validator);
        ghost_stakedSum += amount;
        ghost_staked[validator] += amount;
    }

    function join(uint8 id) public {
        if (id == 0) {
            return;
        }
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        (address validator, bytes memory publicKey) = TestUtils.deriveValidatorAddress(id);
        console.log(validator);

        _pay(validator, amount);
        vm.prank(validator);
        managerFacet.join{value: amount}(publicKey);

        // Because joining requires two operations: deposit and setMetadata
        _configurationNumber += 2;
        managerFacet.confirmChange(_configurationNumber);

        ghost_stakedSum += amount;
        ghost_staked[validator] += amount;

        // join can be called by the same validator twice.
        // Because of that we do not need to add the validator into ghost_validators, but we must change staked sum.
        if (ghost_validators.contains(validator)) {
            return;
        }

        ghost_validators.add(validator);
    }

    function leave(uint8 seed) public {
        address validator = getRandomValidator(seed);
        vm.prank(validator);

        managerFacet.leave();
        ghost_validators.remove(validator);

        ghost_unstakedSum += ghost_staked[validator];
        ghost_staked[validator] = 0;
    }

    function stake(uint8 seed, uint256 amount) public {
        amount = bound(amount, 0, 10 * DEFAULT_MIN_VALIDATOR_STAKE);
        address validator = getRandomValidator(seed);
        _pay(validator, amount);

        vm.prank(validator);
        managerFacet.stake{value: amount}();

        ghost_stakedSum += amount;
        ghost_staked[validator] += amount;
    }

    function unstake(uint8 seed, uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        address validator = getRandomValidator(seed);

        vm.prank(validator);
        managerFacet.unstake(amount);

        ghost_unstakedSum += amount;
        ghost_staked[validator] -= amount;
    }

    function claim(uint8 seed) public {
        address validator = getRandomValidator(seed);
        vm.prank(validator);
        managerFacet.leave();
    }

    function _pay(address to, uint256 amount) internal {
        (bool s, ) = to.call{value: amount}("");
        require(s, "pay() failed");
    }

    receive() external payable {}
}
