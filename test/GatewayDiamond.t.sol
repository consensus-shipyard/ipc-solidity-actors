// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/StdInvariant.sol";
import "../src/Gateway.sol";
import "../src/SubnetActor.sol";
import "../src/lib/SubnetIDHelper.sol";
import "../src/lib/CheckpointHelper.sol";
import "../src/lib/CrossMsgHelper.sol";
import "../src/structs/FvmAddress.sol";
import "../src/GatewayDiamond.sol";
import { IDiamond } from "../src//interfaces/IDiamond.sol";
import { IDiamondCut } from "../src//interfaces/IDiamondCut.sol";
import {RouterFacet} from "../src/facets/RouterFacet.sol";
import {SubnetManagerFacet} from "../src/facets/SubnetManagerFacet.sol";
import {InfoFacet} from "../src/facets/InfoFacet.sol";

contract GatewayDiamondDeploymentTest is StdInvariant, Test {
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;

    uint64 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant MAX_NONCE = type(uint64).max;
    address constant BLS_ACCOUNT_ADDREESS = address(0xfF000000000000000000000000000000bEefbEEf);
    bytes32 private constant DEFAULT_NETWORK_NAME = bytes32("test");
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    string private constant DEFAULT_NET_ADDR = "netAddr";
    bytes private constant GENESIS = EMPTY_BYTES;
    uint256 constant CROSS_MSG_FEE = 10 gwei;
    address constant CHILD_NETWORK_ADDRESS = address(10);
    address constant CHILD_NETWORK_ADDRESS_2 = address(11);
    uint64 constant EPOCH_ONE = 1 * DEFAULT_CHECKPOINT_PERIOD;
    uint256 constant INITIAL_VALIDATOR_FUNDS = 1 ether;

    GatewayDiamond gatewayDiamond;
    GatewayDiamond gw2;
    SubnetActor sa;
    SubnetManagerFacet gwManager;
    InfoFacet gwInfo;
    RouterFacet gwRouter;

    uint64 private constant ROOTNET_CHAINID = 123;
    address public constant ROOTNET_ADDRESS = address(1);

    address TOPDOWN_VALIDATOR_1 = address(12);

    error NotSystemActor();
    error NotSignableAccount();
    error NotEnoughFee();
    error NotEnoughFunds();
    error NotEnoughFundsToRelease();
    error CannotReleaseZero();
    error NotEnoughBalance();
    error NotInitialized();
    error NotValidator();
    error NotEnoughSubnetCircSupply();
    error NotEmptySubnetCircSupply();
    error NotRegisteredSubnet();
    error AlreadyRegisteredSubnet();
    error AlreadyInitialized();
    error AlreadyCommittedCheckpoint();
    error InconsistentPrevCheckpoint();
    error InvalidPostboxOwner();
    error InvalidCheckpointEpoch();
    error InvalidCheckpointSource();
    error InvalidCrossMsgNonce();
    error InvalidCrossMsgDestinationSubnet();
    error InvalidCrossMsgDestinationAddress();
    error InvalidCrossMsgsSortOrder();
    error InvalidCrossMsgFromSubnetId();
    error InvalidCrossMsgFromRawAddress();
    error CannotSendCrossMsgToItself();
    error SubnetNotActive();
    error PostboxNotExist();
    error ValidatorAlreadyVoted();
    error MessagesNotSorted();
    error ValidatorsAndWeightsLengthMismatch();
    error ValidatorWeightIsZero();
    error NotEnoughFundsForMembership();
    error EpochNotVotable();
    error EpochAlreadyExecuted();

    function setUp() public {
        address[] memory path = new address[](1);
        path[0] = ROOTNET_ADDRESS;

        address[] memory path2 = new address[](2);
        path2[0] = CHILD_NETWORK_ADDRESS;
        path2[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });

        gwRouter = new RouterFacet();
        gwManager = new SubnetManagerFacet();
        gwInfo = new InfoFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](3);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(gwRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: generateSelectors("RouterFacet")
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(gwManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: generateSelectors("SubnetManagerFacet")
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(gwInfo),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: generateSelectors("InfoFacet")
            })
        );

        gatewayDiamond = new GatewayDiamond(diamondCut, constructorParams);

        gwRouter = RouterFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwInfo = InfoFacet(address(gatewayDiamond));

        addValidator(TOPDOWN_VALIDATOR_1, 100);

        SubnetActor.ConstructParams memory subnetConstructorParams = SubnetActor.ConstructParams({
            parentId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            name: DEFAULT_NETWORK_NAME,
            ipcGatewayAddr: address(gatewayDiamond),
            consensus: ConsensusType.Mir,
            minActivationCollateral: MIN_COLLATERAL_AMOUNT,
            minValidators: DEFAULT_MIN_VALIDATORS,
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesis: GENESIS
        });
        sa = new SubnetActor(subnetConstructorParams);

        targetContract(address(gatewayDiamond));
    }

    function testGatewayDiamondAddStake_Works_SingleStaking(uint256 stakeAmount, uint256 registerAmount) public {
        gwInfo = InfoFacet(address(gatewayDiamond));
        require(gwInfo.crossMsgFee() == CROSS_MSG_FEE);
        require(gwInfo.getNetworkName().equals(SubnetID({root: ROOTNET_CHAINID, route: new address[](0)})));

        address subnetAddress = vm.addr(100);
        vm.assume(registerAmount >= MIN_COLLATERAL_AMOUNT && registerAmount < type(uint64).max);
        vm.assume(stakeAmount > 0 && stakeAmount < type(uint256).max - registerAmount);

        uint256 totalAmount = stakeAmount + registerAmount;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, totalAmount);

        registerSubnet(registerAmount, subnetAddress);
        addStake(stakeAmount, subnetAddress);

        (, uint256 totalStaked, , , , ) = getSubnet(subnetAddress);

        require(totalStaked == totalAmount);
    }

    function setupValidators() internal returns (address[] memory) {
        address validator1 = vm.addr(100);
        address validator2 = vm.addr(200);
        address validator3 = vm.addr(300);
        address[] memory validators = new address[](3);
        uint256[] memory weights = new uint256[](3);

        vm.deal(validator1, 1);
        vm.deal(validator2, 1);
        vm.deal(validator3, 1);

        validators[0] = validator1;
        validators[1] = validator2;
        validators[2] = validator3;

        weights[0] = 100;
        weights[1] = 100;
        weights[2] = 100;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);

        return validators;
    }

    function addValidator(address validator) internal {
        addValidator(validator, 100);
    }

    function addValidator(address validator, uint256 weight) internal {
        address[] memory validators = new address[](1);
        validators[0] = validator;
        uint256[] memory weights = new uint256[](1);
        weights[0] = weight;

        vm.deal(validator, 1);
        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);
    }

    function callback() public view {
        console.log("callback called");
    }

    function fund(address funderAddress, uint256 fundAmount) internal {
        uint256 fundAmountWithSubtractedFee = fundAmount - gwInfo.crossMsgFee();

        (SubnetID memory subnetId, , uint256 nonceBefore, , uint256 circSupplyBefore, ) = getSubnet(address(sa));

        uint256 expectedTopDownMsgsLenght = gwInfo.getSubnetTopDownMsgsLength(subnetId) + 1;
        uint256 expectedNonce = nonceBefore + 1;
        uint256 expectedCircSupply = circSupplyBefore + fundAmountWithSubtractedFee;

        require(gwInfo.crossMsgFee() > 0, "crossMsgFee is 0");

        vm.expectCall(address(sa), gwInfo.crossMsgFee(), abi.encodeWithSelector(sa.reward.selector), 1);

        gwManager.fund{value: fundAmount}(subnetId);

        (, , uint256 nonce, , uint256 circSupply, ) = getSubnet(address(sa));

        require(gwInfo.getSubnetTopDownMsgsLength(subnetId) == expectedTopDownMsgsLenght);

        require(nonce == expectedNonce);
        require(circSupply == expectedCircSupply);

        for (uint256 msgIndex = 0; msgIndex < expectedTopDownMsgsLenght; msgIndex++) {
            CrossMsg memory topDownMsg = gwInfo.getSubnetTopDownMsg(subnetId, msgIndex);

            require(topDownMsg.message.nonce == msgIndex);
            require(topDownMsg.message.value == fundAmountWithSubtractedFee);
            require(
                keccak256(abi.encode(topDownMsg.message.to)) ==
                keccak256(abi.encode(IPCAddress({subnetId: subnetId, rawAddress: funderAddress})))
            );
            require(
                keccak256(abi.encode(topDownMsg.message.from)) ==
                keccak256(abi.encode(IPCAddress({subnetId: subnetId.getParentSubnet(), rawAddress: funderAddress})))
            );
        }
    }

    function _join(address validatorAddress) internal {
        vm.prank(validatorAddress);
        vm.deal(validatorAddress, MIN_COLLATERAL_AMOUNT + 1);
        sa.join{value: MIN_COLLATERAL_AMOUNT}(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));

        require(sa.status() == Status.Active);
    }

    function release(uint256 releaseAmount, uint256 crossMsgFee, uint64 epoch) internal {
        uint256 feeBefore = gwInfo.bottomUpCheckpointsFee(epoch);

        uint256 expectedNonce = gwInfo.bottomUpNonce() + 1;
        uint256 expectedCheckpointDataFee = feeBefore + crossMsgFee;

        gwManager.release{value: releaseAmount}();

        uint256 fee = gwInfo.bottomUpCheckpointsFee(epoch);
        console.log("fee %d", fee);
        console.log("expectedCheckpointDataFee: %d", expectedCheckpointDataFee);

        require(fee == expectedCheckpointDataFee, "cpDataAfter.fee == expectedCheckpointDataFee");
        require(gwInfo.bottomUpNonce() == expectedNonce, "gwInfo.bottomUpNonce() == expectedNonce");
    }

    function createCheckpoint(
        address subnetAddress,
        uint64 blockNumber
    ) internal view returns (BottomUpCheckpoint memory) {
        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: blockNumber,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        return checkpoint;
    }

    function addStake(uint256 stakeAmount, address subnetAddress) internal {
        uint256 balanceBefore = subnetAddress.balance;
        (, uint256 stakedBefore, , , , ) = getSubnet(subnetAddress);

        gwManager.addStake{value: stakeAmount}();

        uint256 balanceAfter = subnetAddress.balance;
        (, uint256 stakedAfter, , , , ) = getSubnet(subnetAddress);

        require(balanceAfter == balanceBefore - stakeAmount);
        require(stakedAfter == stakedBefore + stakeAmount);
    }

    function registerSubnetGW(uint256 collateral, address subnetAddress, GatewayDiamond gw) internal {
        gwRouter = RouterFacet(address(gw));
        gwManager = SubnetManagerFacet(address(gw));
        gwInfo = InfoFacet(address(gw));

        gwManager.register{value: collateral}();

        (SubnetID memory id, uint256 stake, uint256 topDownNonce, , uint256 circSupply, Status status) = getSubnetGW(
            subnetAddress,
            gw
        );

        SubnetID memory parentNetwork = gwInfo.getNetworkName();

        console.log(stake);
        console.log(topDownNonce);
        console.log(circSupply);
        console.logUint(uint(status));


        require(
            id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash(),
            "id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash()"
        );
        require(stake == collateral, "stake == collateral");
        require(topDownNonce == 0, "nonce == 0");
        require(circSupply == 0, "circSupply == 0");
        require(status == Status.Active, "status == Status.Active");
    }

    function registerSubnet(uint256 collateral, address subnetAddress) internal {
        registerSubnetGW(collateral, subnetAddress, gatewayDiamond);
    }

    function getSubnetGW(
        address subnetAddress,
        GatewayDiamond gw
    ) internal returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        gwRouter = RouterFacet(address(gw));
        gwManager = SubnetManagerFacet(address(gw));
        gwInfo = InfoFacet(address(gw));

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);

        (
        Status status,
        uint64 topDownNonce,
        uint256 appliedBottomUpNonce,
        uint256 stake,
        ,
        uint256 circSupply,
        SubnetID memory id,

        ) = gwInfo.subnets(subnetId.toHash());

        return (id, stake, topDownNonce, appliedBottomUpNonce, circSupply, status);
    }

    function getSubnet(
        address subnetAddress
    ) internal returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        return getSubnetGW(subnetAddress, gatewayDiamond);
    }

    function generateSelectors(string memory facetName)
    internal
    returns (bytes4[] memory facetSelectors)
    {
        string[] memory inputs = new string[](3);
        inputs[0] = "python3";
        inputs[1] = "scripts/python/get_selectors.py";
        inputs[2] = facetName;

        bytes memory res = vm.ffi(inputs);
        facetSelectors = abi.decode(res, (bytes4[]));
    }
}
