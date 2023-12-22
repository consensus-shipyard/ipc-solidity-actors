// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {GatewayGetterFacet} from "../../src/gateway/GatewayGetterFacet.sol";
import "../../src/gateway/GatewayGetterFacet.sol";
import {StdAssertions} from "forge-std/StdAssertions.sol";
import {IntegrationTestBase, TestGatewayActor} from "../IntegrationTestBase.sol";

abstract contract GatewayActorBasicProperties is StdAssertions, TestGatewayActor {
    /// forge-config: default.invariant.runs = 1
    /// forge-config: default.invariant.depth = 1
    function invariant_ERC20_consistent_subnet_number() public virtual {
        assertEq(gwGetter.totalSubnets(), gwGetter.listSubnets().length, "the number of subnet is different");
    }
}
