// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/Test.sol";

import "../../src/errors/IPCErrors.sol";
import {NumberContractFacetSeven, NumberContractFacetEight} from "../helpers/NumberContract.sol";
import {EMPTY_BYTES, METHOD_SEND, EMPTY_HASH} from "../../src/constants/Constants.sol";
import {Status} from "../../src/enums/Status.sol";
import {IERC165} from "../../src/interfaces/IERC165.sol";
import {IDiamond} from "../../src/interfaces/IDiamond.sol";
import {IDiamondLoupe} from "../../src/interfaces/IDiamondLoupe.sol";
import {IDiamondCut} from "../../src/interfaces/IDiamondCut.sol";
import {CheckpointInfo} from "../../src/structs/Checkpoint.sol";
import {CrossMsg, BottomUpCheckpoint, StorableMsg, ParentFinality} from "../../src/structs/Checkpoint.sol";
import {FvmAddress} from "../../src/structs/FvmAddress.sol";
import {SubnetID, Subnet, SupplySource, SupplyKind, IPCAddress, Membership, Validator, StakingChange, StakingChangeRequest, StakingOperation} from "../../src/structs/Subnet.sol";
import {SubnetIDHelper} from "../../src/lib/SubnetIDHelper.sol";
import {FvmAddressHelper} from "../../src/lib/FvmAddressHelper.sol";
import {CrossMsgHelper} from "../../src/lib/CrossMsgHelper.sol";
import {SupplySourceHelper} from "../../src/lib/SupplySourceHelper.sol";
import {StorableMsgHelper} from "../../src/lib/StorableMsgHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {GatewayDiamond, FunctionNotFound} from "../../src/GatewayDiamond.sol";
import {SubnetActorDiamond} from "../../src/SubnetActorDiamond.sol";
import {GatewayGetterFacet} from "../../src/gateway/GatewayGetterFacet.sol";
import {GatewayManagerFacet} from "../../src/gateway/GatewayManagerFacet.sol";
import {GatewayRouterFacet} from "../../src/gateway/GatewayRouterFacet.sol";
import {DiamondCutFacet} from "../../src/diamond/DiamondCutFacet.sol";
import {LibDiamond} from "../../src/lib/LibDiamond.sol";
import {MerkleTreeHelper} from "../helpers/MerkleTreeHelper.sol";
import {TestUtils} from "../helpers/TestUtils.sol";
import {IntegrationTestBase} from "../IntegrationTestBase.sol";

import {SubnetActorDiamond} from "../../src/SubnetActorDiamond.sol";
import {GatewayGetterFacet} from "../../src/gateway/GatewayGetterFacet.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {GatewayManagerFacet} from "../../src/gateway/GatewayManagerFacet.sol";
import {GatewayRouterFacet} from "../../src/gateway/GatewayRouterFacet.sol";
import {SubnetActorManagerFacet} from "../../src/subnet/SubnetActorManagerFacet.sol";
import {SubnetActorGetterFacet} from "../../src/subnet/SubnetActorGetterFacet.sol";
import {DiamondLoupeFacet} from "../../src/diamond/DiamondLoupeFacet.sol";
import {DiamondCutFacet} from "../../src/diamond/DiamondCutFacet.sol";
import {LibDiamond} from "../../src/lib/LibDiamond.sol";

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract GatewayActorDiamondTest is Test, IntegrationTestBase {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;
    using FvmAddressHelper for FvmAddress;

    function setUp() public override {
        super.setUp();
    }

    function test_revertConstruction() public {
        (address validatorAddress, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        join(validatorAddress, publicKey);

        address caller = vm.addr(1);
        vm.deal(caller, 100);

        (SubnetID memory subnetId, , , , , ) = getSubnet(address(saManager));
        vm.expectRevert(SupplySourceHelper.UnexpectedSupplySource.selector);
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 100);
    }

    function testFail_InexistentToken() public {
        // Reverts because the token doesn't exist at that address.
        address token = vm.addr(999);
        createTokenSubnet(token);
    }

    function test_fundWithToken() public {
        address token = vm.addr(999);
        vm.mockCall(token, abi.encodeWithSelector(IERC20.balanceOf.selector), abi.encode(0));
        createTokenSubnet(token);

        (address validatorAddress, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        join(validatorAddress, publicKey);

        address caller = vm.addr(1);
        vm.deal(caller, 100);

        vm.startPrank(caller);

        // account has native balance but no tokens, reverts.
        (SubnetID memory subnetId, , , , , ) = getSubnet(address(saManager));
        vm.expectRevert(bytes(""));
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 1);

        vm.clearMockedCalls();
        vm.mockCall(
            token,
            abi.encodeWithSelector(IERC20.allowance.selector, address(caller), address(gatewayDiamond)),
            abi.encode(1)
        );
        vm.mockCall(
            token,
            abi.encodeWithSelector(IERC20.transferFrom.selector, address(caller), address(gatewayDiamond), 1),
            abi.encode()
        );
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 1);
    }

    function createTokenSubnet(address tokenAddress) internal {
        // Create a subnet actor in the root network, with an ERC20 supply source with the specified token address.
        SubnetActorDiamond.ConstructorParams memory saConstructorParams = defaultSubnetActorParamsWithGateway(
            address(gatewayDiamond)
        );
        saConstructorParams.supplySource = SupplySource({kind: SupplyKind.ERC20, tokenAddress: tokenAddress});

        // Override the state variables with the new subnet.
        saDiamond = createSubnetActor(saConstructorParams);
        saManager = SubnetActorManagerFacet(address(saDiamond));
        saGetter = SubnetActorGetterFacet(address(saDiamond));
        saLouper = DiamondLoupeFacet(address(saDiamond));
        saCutFacet = DiamondCutFacet(address(saDiamond));

        addValidator(TOPDOWN_VALIDATOR_1, 100);
    }
}
