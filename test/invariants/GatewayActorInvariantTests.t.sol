// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/console.sol";
import {SubnetID} from "../../src/structs/Subnet.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {IntegrationTestBase} from "../IntegrationTestBase.sol";
import {GatewayActorBasicProperties} from "./GatewayActorProperties.sol";
import {GatewayDiamond} from "../../src/GatewayDiamond.sol";
import {L1GatewayActorDiamond, L2GatewayActorDiamond, L3GatewayActorDiamond} from "../IntegrationTestPresets.sol";
import {GatewayGetterFacet} from "../../src/gateway/GatewayGetterFacet.sol";
import {CheckpointingFacet} from "../../src/gateway/router/CheckpointingFacet.sol";
import {XnetMessagingFacet} from "../../src/gateway/router/XnetMessagingFacet.sol";
import {TopDownFinalityFacet} from "../../src/gateway/router/TopDownFinalityFacet.sol";
import {BottomUpRouterFacet} from "../../src/gateway/router/BottomUpRouterFacet.sol";
import {GatewayManagerFacet} from "../../src/gateway/GatewayManagerFacet.sol";
import {GatewayActorHandler} from "./handlers/GatewayActorHandler.sol";

contract GatewayActorInvariantTests is StdInvariant, L1GatewayActorDiamond, GatewayActorBasicProperties {
    GatewayActorHandler private gatewayActorHandler;

    function setUp() public override {
        IntegrationTestBase.setUp();
        gatewayActorHandler = new GatewayActorHandler(gatewayDiamond);
        targetContract(address(gatewayActorHandler));

        // assert specific properties of the infrastructure.
        assertEq(gwGetter.getNetworkName().route.length, 1);
    }
}

contract L2GatewayActorInvariantTests is L2GatewayActorDiamond, GatewayActorBasicProperties {
    GatewayActorHandler private gatewayActorHandler;

    function setUp() public override {
        L2GatewayActorDiamond.setUp();
        gatewayActorHandler = new GatewayActorHandler(gatewayDiamond);
        targetContract(address(gatewayActorHandler));

        // assert specific properties of the infrastructure.
        assertEq(gwGetter.getNetworkName().route.length, 2);
    }
}

contract L3GatewayActorInvariantTests is L3GatewayActorDiamond, GatewayActorBasicProperties {
    GatewayActorHandler private gatewayActorHandler;

    function setUp() public override {
        L3GatewayActorDiamond.setUp();
        gatewayActorHandler = new GatewayActorHandler(gatewayDiamond);
        targetContract(address(gatewayActorHandler));

        // assert specific properties of the infrastructure.
        assertEq(gwGetter.getNetworkName().route.length, 3);
    }
}
