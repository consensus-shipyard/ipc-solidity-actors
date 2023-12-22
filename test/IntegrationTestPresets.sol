// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/errors/IPCErrors.sol";
import {EMPTY_BYTES, METHOD_SEND} from "../src/constants/Constants.sol";
import {CrossMsg, StorableMsg} from "../src/structs/CrossNet.sol";
import {FvmAddress} from "../src/structs/FvmAddress.sol";
import {SubnetID, Subnet, IPCAddress, Validator} from "../src/structs/Subnet.sol";
import {SubnetIDHelper} from "../src/lib/SubnetIDHelper.sol";
import {FvmAddressHelper} from "../src/lib/FvmAddressHelper.sol";
import {CrossMsgHelper} from "../src/lib/CrossMsgHelper.sol";
import {GatewayDiamond, FEATURE_MULTILEVEL_CROSSMSG} from "../src/GatewayDiamond.sol";
import {GatewayGetterFacet} from "../src/gateway/GatewayGetterFacet.sol";
import {GatewayManagerFacet} from "../src/gateway/GatewayManagerFacet.sol";
import {XnetMessagingFacet} from "../src/gateway/router/XnetMessagingFacet.sol";
import {DiamondCutFacet} from "../src/diamond/DiamondCutFacet.sol";
import {GatewayMessengerFacet} from "../src/gateway/GatewayMessengerFacet.sol";
import {DiamondLoupeFacet} from "../src/diamond/DiamondLoupeFacet.sol";
import {DiamondCutFacet} from "../src/diamond/DiamondCutFacet.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {IntegrationTestBase} from "./IntegrationTestBase.sol";

contract L1GatewayActorDiamond is IntegrationTestBase {
    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);

        gwGetter = GatewayGetterFacet(address(gatewayDiamond));
        gwManager = GatewayManagerFacet(address(gatewayDiamond));
        gwXnetMessagingFacet = XnetMessagingFacet(address(gatewayDiamond));
        gwMessenger = GatewayMessengerFacet(address(gatewayDiamond));
        gwLouper = DiamondLoupeFacet(address(gatewayDiamond));
        gwCutter = DiamondCutFacet(address(gatewayDiamond));
    }

    function defaultGatewayParams() internal pure override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](1);
        path[0] = CHILD_NETWORK_ADDRESS;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: DEFAULT_CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT
        });

        return params;
    }
}

contract L2GatewayActorDiamond is IntegrationTestBase {
    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);

        gwGetter = GatewayGetterFacet(address(gatewayDiamond));
        gwManager = GatewayManagerFacet(address(gatewayDiamond));
        gwXnetMessagingFacet = XnetMessagingFacet(address(gatewayDiamond));
        gwMessenger = GatewayMessengerFacet(address(gatewayDiamond));
        gwLouper = DiamondLoupeFacet(address(gatewayDiamond));
        gwCutter = DiamondCutFacet(address(gatewayDiamond));
    }

    function defaultGatewayParams() internal pure override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](2);
        path[0] = CHILD_NETWORK_ADDRESS;
        path[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: DEFAULT_CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT
        });

        return params;
    }
}

contract L3GatewayActorDiamond is IntegrationTestBase {
    address constant CHILD_NETWORK_ADDRESS_3 = address(31);

    function setUp() public virtual override {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = defaultGatewayParams();
        gatewayDiamond = createGatewayDiamond(gwConstructorParams);

        gwGetter = GatewayGetterFacet(address(gatewayDiamond));
        gwManager = GatewayManagerFacet(address(gatewayDiamond));
        gwXnetMessagingFacet = XnetMessagingFacet(address(gatewayDiamond));
        gwMessenger = GatewayMessengerFacet(address(gatewayDiamond));
        gwLouper = DiamondLoupeFacet(address(gatewayDiamond));
        gwCutter = DiamondCutFacet(address(gatewayDiamond));
    }

    function defaultGatewayParams() internal pure override returns (GatewayDiamond.ConstructorParams memory) {
        address[] memory path = new address[](3);
        path[0] = CHILD_NETWORK_ADDRESS;
        path[1] = CHILD_NETWORK_ADDRESS_2;
        path[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory params = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: DEFAULT_CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: DEFAULT_ACTIVE_VALIDATORS_LIMIT
        });

        return params;
    }
}
