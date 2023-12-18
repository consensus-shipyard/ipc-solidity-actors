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
import {CrossMsg, BottomUpMsgBatch, BottomUpCheckpoint, StorableMsg, ParentFinality} from "../../src/structs/CrossNet.sol";
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
import {LibGateway} from "../../src/lib/LibGateway.sol";
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
import {ERC20PresetFixedSupply} from "../helpers/ERC20PresetFixedSupply.sol";
import {IERC20Errors} from "openzeppelin-contracts/interfaces/draft-IERC6093.sol";

contract GatewayDiamondTokenTest is Test, IntegrationTestBase {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;
    using FvmAddressHelper for FvmAddress;

    IERC20 private token;

    function setUp() public override {
        super.setUp();

        token = new ERC20PresetFixedSupply("TestToken", "TEST", 1_000_000, address(this));
    }

    function test_fundWithToken_NativeSupply_Reverts() public {
        (address validatorAddress, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        join(validatorAddress, publicKey);

        address caller = vm.addr(1);
        vm.deal(caller, 100);

        (SubnetID memory subnetId, , , , , ) = getSubnet(address(saManager));

        vm.prank(caller);
        vm.expectRevert(SupplySourceHelper.UnexpectedSupplySource.selector);
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 100);
    }

    function test_fund_TokenSupply_Reverts() public {
        address caller = vm.addr(1);
        vm.deal(caller, 100);

        Subnet memory subnet = createTokenSubnet(address(token));

        vm.prank(caller);
        vm.expectRevert(SupplySourceHelper.UnexpectedSupplySource.selector);
        gwManager.fund{value: 100}(subnet.id, FvmAddressHelper.from(caller));
    }

    function testFail_InexistentToken() public {
        // Reverts because the token doesn't exist at that address.
        address addr = vm.addr(999);
        createTokenSubnet(addr);
    }

    function test_fundWithToken_FailsInsufficientBalance() public {
        Subnet memory subnet = createTokenSubnet(address(token));

        // account has native balance but no tokens, reverts.
        address caller = vm.addr(1);
        vm.deal(caller, 100);
        vm.prank(caller);
        vm.expectRevert(
            abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, address(gatewayDiamond), 0, 1)
        );
        gwManager.fundWithToken(subnet.id, FvmAddressHelper.from(caller), 1);
    }

    function test_fundWithToken_Succeeds() public {
        Subnet memory subnet = createTokenSubnet(address(token));

        address caller = vm.addr(1);
        vm.deal(caller, 100);
        token.transfer(caller, 100);
        vm.startPrank(caller);

        // caller approves the gateway to spend funds on their behalf.
        token.approve(address(gatewayDiamond), 100);

        // funding now succeeds.
        vm.expectEmit(true, false, false, false, address(gatewayDiamond));
        // TODO check value, address, etc.
        CrossMsg memory dummy;
        emit LibGateway.NewTopDownMessage(address(saDiamond), dummy);
        gwManager.fundWithToken(subnet.id, FvmAddressHelper.from(caller), 1);

        (, Subnet memory subnetAfter) = gwGetter.getSubnet(subnet.id);
        assertEq(subnetAfter.circSupply, 1);
        assertEq(subnetAfter.topDownNonce, 1);
    }

    function test_withdrawal() public {
        // TODO:
        // 1. Test successful withdrawal.
        // 2. Test withdrawal attempt beyond subnet's circulating supply.
    }

    function test_generalMessagePassing() public {
        // TODO:
        // 1. Test ERC20 that child-to-parent GMP where child is ERC20 results in transfer + call.
    }

    function test_propagation() public {
        // TODO:
        // 1. Test that propagation is rejected when sender is ERC20.
        // 2. Test that propagation is rejected when receiver is ERC20.
        // 3. Test that propagation is rejected when an intermediary subnet is ERC20.
    }

    function createTokenSubnet(address tokenAddress) internal returns (Subnet memory) {
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

        (address validatorAddress, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        join(validatorAddress, publicKey);

        SubnetID memory subnetId = gwGetter.getNetworkName().createSubnetId(address(saDiamond));

        (bool exists, Subnet memory subnet) = gwGetter.getSubnet(subnetId);
        assert(exists);
        return subnet;
    }
}
