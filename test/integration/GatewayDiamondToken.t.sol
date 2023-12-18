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

contract GatewayActorDiamondTest is Test, IntegrationTestBase {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;
    using FvmAddressHelper for FvmAddress;

    IERC20 private token;

    function setUp() public override {
        super.setUp();

        token = new ERC20PresetFixedSupply("TestToken", "TEST", 1_000_000, address(this));
    }

    function test_revertConstruction() public {
        address caller = vm.addr(1);
        vm.deal(caller, 100);

        (SubnetID memory subnetId, , , , , ) = getSubnet(address(saManager));
        vm.expectRevert(SupplySourceHelper.UnexpectedSupplySource.selector);
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 100);
    }

    function testFail_InexistentToken() public {
        // Reverts because the token doesn't exist at that address.
        address addr = vm.addr(999);
        createTokenSubnet(addr);
    }

    function test_fundWithToken() public {
        createTokenSubnet(address(token));

        address caller = vm.addr(1);
        vm.deal(caller, 100);

        // account has native balance but no tokens, reverts.
        (SubnetID memory subnetId, , , , , ) = getSubnet(address(saManager));
        vm.prank(caller);
        vm.expectRevert(
            abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, address(gatewayDiamond), 0, 1)
        );
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 1);

        // ghive the caller some funds
        token.transfer(caller, 100);

        vm.startPrank(caller);
        token.approve(address(gatewayDiamond), 100);

        // now succeeds.
        vm.expectEmit(true, false, false, false, address(gatewayDiamond));
        // TODO check value, address, etc.
        CrossMsg memory dummy;
        emit LibGateway.NewTopDownMessage(address(saDiamond), dummy);
        gwManager.fundWithToken(subnetId, FvmAddressHelper.from(caller), 1);

        (, , uint256 nonce, , uint256 circSupply, ) = getSubnet(address(saManager));
        assertEq(circSupply, 1);
        assertEq(nonce, 1);
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

        (address validatorAddress, bytes memory publicKey) = TestUtils.deriveValidatorAddress(100);
        join(validatorAddress, publicKey);
    }
}