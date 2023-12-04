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

contract SubnetActorHandler is CommonBase, StdCheats, StdUtils {
    using EnumerableSet for EnumerableSet.AddressSet;

    SubnetActorManagerFacet managerFacet;
    SubnetActorGetterFacet getterFacet;

    constructor(SubnetActorDiamond _subnetActor) {
        managerFacet = SubnetActorManagerFacet(address(_subnetActor));
        getterFacet = SubnetActorGetterFacet(address(_subnetActor));
    }

    function test() public {}
}
