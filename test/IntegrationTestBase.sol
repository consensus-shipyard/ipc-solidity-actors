// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/StdInvariant.sol";

import "../src/errors/IPCErrors.sol";
import {NumberContractFacetSeven, NumberContractFacetEight} from "./NumberContract.sol";
import {EMPTY_BYTES, METHOD_SEND, EMPTY_HASH} from "../src/constants/Constants.sol";
import {ConsensusType} from "../src/enums/ConsensusType.sol";
import {Status} from "../src/enums/Status.sol";
import {IERC165} from "../src/interfaces/IERC165.sol";
import {IDiamond} from "../src/interfaces/IDiamond.sol";
import {IDiamondLoupe} from "../src/interfaces/IDiamondLoupe.sol";
import {IDiamondCut} from "../src/interfaces/IDiamondCut.sol";
import {ISubnetActor} from "../src/interfaces/ISubnetActor.sol";
import {CheckpointInfo} from "../src/structs/Checkpoint.sol";
import {CrossMsg, BottomUpCheckpoint, StorableMsg, ParentFinality} from "../src/structs/Checkpoint.sol";
import {FvmAddress} from "../src/structs/FvmAddress.sol";
import {SubnetID, Subnet, IPCAddress, Membership, Validator, StakingChange, StakingChangeRequest, StakingOperation} from "../src/structs/Subnet.sol";
import {SubnetIDHelper} from "../src/lib/SubnetIDHelper.sol";
import {FvmAddressHelper} from "../src/lib/FvmAddressHelper.sol";
import {CrossMsgHelper} from "../src/lib/CrossMsgHelper.sol";
import {StorableMsgHelper} from "../src/lib/StorableMsgHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {GatewayDiamond, FunctionNotFound} from "../src/GatewayDiamond.sol";
import {SubnetActorDiamond} from "../src/SubnetActorDiamond.sol";
import {GatewayGetterFacet} from "../src/gateway/GatewayGetterFacet.sol";
import {GatewayMessengerFacet} from "../src/gateway/GatewayMessengerFacet.sol";
import {GatewayManagerFacet} from "../src/gateway/GatewayManagerFacet.sol";
import {GatewayRouterFacet} from "../src/gateway/GatewayRouterFacet.sol";
import {SubnetActorManagerFacet} from "../src/subnet/SubnetActorManagerFacet.sol";
import {SubnetActorGetterFacet} from "../src/subnet/SubnetActorGetterFacet.sol";
import {DiamondLoupeFacet} from "../src/diamond/DiamondLoupeFacet.sol";
import {DiamondCutFacet} from "../src/diamond/DiamondCutFacet.sol";
import {LibDiamond} from "../src/lib/LibDiamond.sol";
import {MerkleTreeHelper} from "./MerkleTreeHelper.sol";

import {TestUtils} from "./TestUtils.sol";

contract IntegrationTestBase is Test {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;
    using FvmAddressHelper for FvmAddress;

    uint64 constant MAX_NONCE = type(uint64).max;
    address constant BLS_ACCOUNT_ADDREESS = address(0xfF000000000000000000000000000000bEefbEEf);
    uint64 constant DEFAULT_MIN_VALIDATORS = 1;
    uint8 constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    uint64 constant DEFAULT_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    string constant DEFAULT_NET_ADDR = "netAddr";
    bytes constant GENESIS = EMPTY_BYTES;
    uint256 constant CROSS_MSG_FEE = 10 gwei;
    uint256 constant DEFAULT_RELAYER_REWARD = 10 gwei;
    address constant CHILD_NETWORK_ADDRESS = address(10);
    address constant CHILD_NETWORK_ADDRESS_2 = address(11);
    uint64 constant EPOCH_ONE = 1 * DEFAULT_CHECKPOINT_PERIOD;
    uint256 constant INITIAL_VALIDATOR_FUNDS = 1 ether;

    uint64 constant ROOTNET_CHAINID = 123;
    address constant ROOTNET_ADDRESS = address(1);

    address constant TOPDOWN_VALIDATOR_1 = address(12);

    bytes4[] gwRouterSelectors;
    bytes4[] gwManagerSelectors;
    bytes4[] gwGetterSelectors;
    bytes4[] gwMessengerSelectors;
    bytes4[] cutFacetSelectors;
    bytes4[] louperSelectors;

    GatewayDiamond gatewayDiamond;
    GatewayManagerFacet gwManager;
    GatewayGetterFacet gwGetter;
    GatewayRouterFacet gwRouter;
    GatewayMessengerFacet gwMessenger;
    DiamondCutFacet gwCutFacet;
    DiamondLoupeFacet gwLouper;

    GatewayDiamond gatewayDiamond2;
    GatewayManagerFacet gwManager2;
    GatewayGetterFacet gwGetter2;
    GatewayRouterFacet gwRouter2;
    GatewayMessengerFacet gwMessenger2;

    bytes4[] saGetterSelectors;
    bytes4[] saManagerSelectors;
    SubnetActorDiamond saDiamond;
    SubnetActorManagerFacet saManager;
    SubnetActorGetterFacet saGetter;

    function setUp() public virtual {
        saGetterSelectors = TestUtils.generateSelectors(vm, "SubnetActorGetterFacet");
        saManagerSelectors = TestUtils.generateSelectors(vm, "SubnetActorManagerFacet");

        gwRouterSelectors = TestUtils.generateSelectors(vm, "GatewayRouterFacet");
        gwGetterSelectors = TestUtils.generateSelectors(vm, "GatewayGetterFacet");
        gwManagerSelectors = TestUtils.generateSelectors(vm, "GatewayManagerFacet");
        gwMessengerSelectors = TestUtils.generateSelectors(vm, "GatewayMessengerFacet");
        cutFacetSelectors = TestUtils.generateSelectors(vm, "DiamondCutFacet");
        louperSelectors = TestUtils.generateSelectors(vm, "DiamondLoupeFacet");

        address[] memory path = new address[](1);
        path[0] = ROOTNET_ADDRESS;

        address[] memory path2 = new address[](2);
        path2[0] = CHILD_NETWORK_ADDRESS;
        path2[1] = CHILD_NETWORK_ADDRESS_2;

        // create a gateway actor.

        GatewayDiamond.ConstructorParams memory gwConstructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            minCollateral: DEFAULT_COLLATERAL_AMOUNT,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesisValidators: new Validator[](0),
            activeValidatorsLimit: 100
        });

        gwRouter = new GatewayRouterFacet();
        gwManager = new GatewayManagerFacet();
        gwGetter = new GatewayGetterFacet();
        gwMessenger = new GatewayMessengerFacet();
        gwLouper = new DiamondLoupeFacet();
        gwCutFacet = new DiamondCutFacet();

        IDiamond.FacetCut[] memory gwDiamondCut = new IDiamond.FacetCut[](6);

        gwDiamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(gwRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwRouterSelectors
            })
        );

        gwDiamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(gwManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwManagerSelectors
            })
        );

        gwDiamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(gwGetter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwGetterSelectors
            })
        );

        gwDiamondCut[3] = (
            IDiamond.FacetCut({
                facetAddress: address(gwMessenger),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwMessengerSelectors
            })
        );

        gwDiamondCut[4] = (
            IDiamond.FacetCut({
                facetAddress: address(gwLouper),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: louperSelectors
            })
        );

        gwDiamondCut[5] = (
            IDiamond.FacetCut({
                facetAddress: address(gwCutFacet),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: cutFacetSelectors
            })
        );

        gatewayDiamond = new GatewayDiamond(gwDiamondCut, gwConstructorParams);
        gwGetter = GatewayGetterFacet(address(gatewayDiamond));
        gwManager = GatewayManagerFacet(address(gatewayDiamond));
        gwRouter = GatewayRouterFacet(address(gatewayDiamond));
        gwMessenger = GatewayMessengerFacet(address(gatewayDiamond));
        gwLouper = DiamondLoupeFacet(address(gatewayDiamond));
        gwCutFacet = DiamondCutFacet(address(gatewayDiamond));

        gwConstructorParams.networkName = SubnetID({root: ROOTNET_CHAINID, route: path2});

        gatewayDiamond2 = new GatewayDiamond(gwDiamondCut, gwConstructorParams);
        gwGetter2 = GatewayGetterFacet(address(gatewayDiamond2));
        gwManager2 = GatewayManagerFacet(address(gatewayDiamond2));
        gwRouter2 = GatewayRouterFacet(address(gatewayDiamond2));
        gwMessenger2 = GatewayMessengerFacet(address(gatewayDiamond2));

        // create a subnet actor.

        SubnetActorDiamond.ConstructorParams memory saConstructorParams = SubnetActorDiamond.ConstructorParams({
            parentId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            ipcGatewayAddr: address(gatewayDiamond),
            consensus: ConsensusType.Fendermint,
            minActivationCollateral: DEFAULT_COLLATERAL_AMOUNT,
            minValidators: DEFAULT_MIN_VALIDATORS,
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            activeValidatorsLimit: 100,
            powerScale: 12,
            minCrossMsgFee: CROSS_MSG_FEE,
            permissioned: false
        });

        saManager = new SubnetActorManagerFacet();
        saGetter = new SubnetActorGetterFacet();

        IDiamond.FacetCut[] memory saDiamondCut = new IDiamond.FacetCut[](2);

        saDiamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(saGetter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: saGetterSelectors
            })
        );

        saDiamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(saManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: saManagerSelectors
            })
        );

        saDiamond = new SubnetActorDiamond(saDiamondCut, saConstructorParams);
        saManager = SubnetActorManagerFacet(address(saDiamond));
        saGetter = SubnetActorGetterFacet(address(saDiamond));

        addValidator(TOPDOWN_VALIDATOR_1, 100);
    }

    function createDiamond(GatewayDiamond.ConstructorParams memory params) public returns (GatewayDiamond) {
        GatewayRouterFacet router = new GatewayRouterFacet();
        GatewayManagerFacet manager = new GatewayManagerFacet();
        GatewayGetterFacet getter = new GatewayGetterFacet();
        GatewayMessengerFacet messenger = new GatewayMessengerFacet();
        DiamondCutFacet cutter = new DiamondCutFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](5);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(router),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwRouterSelectors
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(manager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwManagerSelectors
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(getter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwGetterSelectors
            })
        );

        diamondCut[3] = (
            IDiamond.FacetCut({
                facetAddress: address(messenger),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: gwMessengerSelectors
            })
        );

        diamondCut[4] = (
            IDiamond.FacetCut({
                facetAddress: address(cutter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: cutFacetSelectors
            })
        );

        gatewayDiamond = new GatewayDiamond(diamondCut, params);

        return gatewayDiamond;
    }

    function totalWeight(uint256[] memory weights) public pure returns (uint256 sum) {
        for (uint64 i = 0; i < 3; i++) {
            sum += weights[i];
        }
        return sum;
    }

    function setupValidators() public returns (FvmAddress[] memory validators, address[] memory addresses) {
        validators = new FvmAddress[](3);
        validators[0] = FvmAddressHelper.from(vm.addr(100));
        validators[1] = FvmAddressHelper.from(vm.addr(200));
        validators[2] = FvmAddressHelper.from(vm.addr(300));

        addresses = new address[](3);
        addresses[0] = vm.addr(100);
        addresses[1] = vm.addr(200);
        addresses[2] = vm.addr(300);

        uint256[] memory weights = new uint256[](3);

        vm.deal(vm.addr(100), 1);
        vm.deal(vm.addr(200), 1);
        vm.deal(vm.addr(300), 1);

        weights[0] = 100;
        weights[1] = 100;
        weights[2] = 100;

        // uint64 n = gwGetter.getLastConfigurationNumber() + 1;
        ParentFinality memory finality = ParentFinality({height: block.number, blockHash: bytes32(0)});

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwRouter.commitParentFinality(finality);
    }

    function setupWhiteListMethod(address caller, address src) public returns (bytes32) {
        registerSubnet(DEFAULT_COLLATERAL_AMOUNT, src);

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({
                    subnetId: gwGetter.getNetworkName().createSubnetId(caller),
                    rawAddress: FvmAddressHelper.from(caller)
                }),
                to: IPCAddress({
                    subnetId: gwGetter.getNetworkName().createSubnetId(src),
                    rawAddress: FvmAddressHelper.from(src)
                }),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0),
                fee: CROSS_MSG_FEE
            }),
            wrapped: false
        });
        CrossMsg[] memory msgs = new CrossMsg[](1);
        msgs[0] = crossMsg;

        // we add a validator with 10 times as much weight as the default validator.
        // This way we have 10/11 votes and we reach majority, setting the message in postbox
        // addValidator(caller, 1000);

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwRouter.applyCrossMessages(msgs);

        return crossMsg.toHash();
    }

    function addValidator(address validator) public {
        addValidator(validator, 100);
    }

    function addValidator(address validator, uint256 weight) public {
        FvmAddress[] memory validators = new FvmAddress[](1);
        validators[0] = FvmAddressHelper.from(validator);
        uint256[] memory weights = new uint256[](1);
        weights[0] = weight;

        vm.deal(validator, 1);
        ParentFinality memory finality = ParentFinality({height: block.number, blockHash: bytes32(0)});
        // uint64 n = gwGetter.getLastConfigurationNumber() + 1;

        vm.startPrank(FilAddress.SYSTEM_ACTOR);
        gwRouter.commitParentFinality(finality);
        vm.stopPrank();
    }

    function reward(uint256 amount) public view {
        console.log("reward method called with %d", amount);
    }

    function fund(address funderAddress, uint256 fundAmount) public {
        // funding subnets is free, we do not need cross msg fee
        (SubnetID memory subnetId, , uint256 nonceBefore, , uint256 circSupplyBefore, ) = getSubnet(address(saManager));
        console.log(circSupplyBefore);

        uint256 expectedTopDownMsgsLength = gwGetter.getSubnetTopDownMsgsLength(subnetId) + 1;
        uint256 expectedNonce = nonceBefore + 1;
        uint256 expectedCircSupply = circSupplyBefore + fundAmount;

        require(gwGetter.crossMsgFee() > 0, "crossMsgFee is 0");

        gwManager.fund{value: fundAmount}(subnetId, FvmAddressHelper.from(funderAddress));

        (, , uint256 nonce, , uint256 circSupply, ) = getSubnet(address(saManager));

        require(gwGetter.getSubnetTopDownMsgsLength(subnetId) == expectedTopDownMsgsLength, "unexpected lengths");

        require(nonce == expectedNonce, "unexpected nonce");
        require(circSupply == expectedCircSupply, "unexpected circSupply");
    }

    function join(address validatorAddress, bytes memory pubkey) public {
        vm.prank(validatorAddress);
        vm.deal(validatorAddress, DEFAULT_COLLATERAL_AMOUNT + 1);
        saManager.join{value: DEFAULT_COLLATERAL_AMOUNT}(pubkey);
    }

    function confirmChange(address validator, uint256 privKey) public {
        address[] memory validators = new address[](1);
        validators[0] = validator;

        uint256[] memory privKeys = new uint256[](1);
        privKeys[0] = privKey;

        confirmChange(validators, privKeys);
    }

    function confirmChange(address[] memory validators, uint256[] memory privKey) public {
        uint256 n = validators.length;

        bytes[] memory signatures = new bytes[](n);

        CrossMsg[] memory msgs = new CrossMsg[](0);

        (uint64 nextConfigNum, ) = saGetter.getConfigurationNumbers();
        uint64 h = saGetter.lastBottomUpCheckpointHeight() + saGetter.bottomUpCheckPeriod();

        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            subnetID: saGetter.getParent().createSubnetId(address(saDiamond)),
            blockHeight: h,
            blockHash: keccak256(abi.encode(h)),
            nextConfigurationNumber: nextConfigNum - 1,
            crossMessagesHash: keccak256(abi.encode(msgs))
        });

        vm.deal(address(saDiamond), 100 ether);

        bytes32 hash = keccak256(abi.encode(checkpoint));

        for (uint256 i = 0; i < n; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(privKey[i], hash);
            signatures[i] = abi.encodePacked(r, s, v);
        }

        for (uint256 i = 0; i < n; i++) {
            vm.prank(validators[i]);
            saManager.submitCheckpoint(checkpoint, msgs, validators, signatures);
        }
    }

    function release(uint256 releaseAmount, uint256 fee) public {
        uint256 expectedNonce = gwGetter.bottomUpNonce() + 1;
        gwManager.release{value: releaseAmount}(FvmAddressHelper.from(msg.sender), fee);
        require(gwGetter.bottomUpNonce() == expectedNonce, "gwGetter.bottomUpNonce() == expectedNonce");
    }

    function addStake(uint256 stakeAmount, address subnetAddress) public {
        uint256 balanceBefore = subnetAddress.balance;

        (, uint256 stakedBefore, , , , ) = getSubnet(subnetAddress);

        gwManager.addStake{value: stakeAmount}();

        uint256 balanceAfter = subnetAddress.balance;
        (, uint256 stakedAfter, , , , ) = getSubnet(subnetAddress);

        require(balanceAfter == balanceBefore - stakeAmount, "unexpected balance");
        require(stakedAfter == stakedBefore + stakeAmount, "unexpected stake");
    }

    function registerSubnetGW(uint256 collateral, address subnetAddress, GatewayDiamond gw) public {
        GatewayManagerFacet manager = GatewayManagerFacet(address(gw));

        manager.register{value: collateral}(0);

        (SubnetID memory id, uint256 stake, uint256 topDownNonce, , uint256 circSupply, Status status) = getSubnetGW(
            subnetAddress,
            gw
        );

        SubnetID memory parentNetwork = gwGetter.getNetworkName();

        require(
            id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash(),
            "id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash()"
        );
        require(stake == collateral, "unexpected stake");
        require(topDownNonce == 0, "unexpected nonce");
        require(circSupply == 0, "unexpected circSupply");
        require(status == Status.Active, "unexpected status");
    }

    function registerSubnet(uint256 collateral, address subnetAddress) public {
        registerSubnetGW(collateral, subnetAddress, gatewayDiamond);
    }

    function getSubnetGW(
        address subnetAddress,
        GatewayDiamond gw
    ) public returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        gwRouter = GatewayRouterFacet(address(gw));
        gwManager = GatewayManagerFacet(address(gw));
        gwGetter = GatewayGetterFacet(address(gw));

        SubnetID memory subnetId = gwGetter.getNetworkName().createSubnetId(subnetAddress);

        Subnet memory subnet = gwGetter.subnets(subnetId.toHash());

        return (
            subnet.id,
            subnet.stake,
            subnet.topDownNonce,
            subnet.appliedBottomUpNonce,
            subnet.circSupply,
            subnet.status
        );
    }

    function getSubnet(
        address subnetAddress
    ) public returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        return getSubnetGW(subnetAddress, gatewayDiamond);
    }
}
