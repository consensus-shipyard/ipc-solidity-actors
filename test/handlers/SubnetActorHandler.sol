// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/console.sol";
import "forge-std/StdUtils.sol";
import "forge-std/StdCheats.sol";
import {CommonBase} from "forge-std/Base.sol";

import {IERC165} from "../../src/interfaces/IERC165.sol";
import {IDiamond} from "../../src/interfaces/IDiamond.sol";
import {IDiamondCut} from "../../src/interfaces/IDiamondCut.sol";
import {IDiamondLoupe} from "../../src/interfaces/IDiamondLoupe.sol";
import {DiamondCutFacet} from "../../src/diamond/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../../src/diamond/DiamondLoupeFacet.sol";
import {SubnetGetterFacet} from "../../src/subnetregistry/SubnetGetterFacet.sol";
import {SubnetActorDiamond} from "../../src/SubnetActorDiamond.sol";
import {SubnetActorManagerFacet} from "../../src/subnet/SubnetActorManagerFacet.sol";
import {SubnetActorGetterFacet} from "../../src/subnet/SubnetActorGetterFacet.sol";
import {SubnetActorManagerFacetMock} from "../mocks/SubnetActor.sol";

import {ConsensusType} from "../../src/enums/ConsensusType.sol";
import {SubnetID} from "../../src/structs/Subnet.sol";
import {SubnetIDHelper} from "../../src/lib/SubnetIDHelper.sol";

import {TestUtils} from "../TestUtils.sol";

import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";

contract SubnetActorHandler is CommonBase, StdCheats, StdUtils {
    using EnumerableSet for EnumerableSet.AddressSet;

    address private constant DEFAULT_IPC_GATEWAY_ADDR = address(1024);
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    int8 private constant DEFAULT_POWER_SCALE = 18;
    uint64 private constant ROOTNET_CHAINID = 123;
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    uint16 private constant DEFAULT_ACTIVE_VALIDATORS = 50;
    uint256 private constant CROSS_MSG_FEE = 10 gwei;

    SubnetActorManagerFacet saManager;
    SubnetActorGetterFacet saGetter;

    constructor(SubnetActorDiamond _subnetActor) {
        saManager = SubnetActorManagerFacet(address(_subnetActor));
        saGetter = SubnetActorGetterFacet(address(_subnetActor));
    }

    function test() public {}
}
