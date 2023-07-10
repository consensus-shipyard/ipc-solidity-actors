// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {EMPTY_BYTES, METHOD_SEND} from "../src/constants/Constants.sol";

import "../src/SubnetActorDiamond.sol";
import "../src/enums/Status.sol";
import "../src/structs/Subnet.sol";
import "../src/structs/FvmAddress.sol";
import "../src/lib/SubnetIDHelper.sol";
import "../src/lib/CheckpointHelper.sol";
import {IDiamond} from "../src/interfaces/IDiamond.sol";
import {IDiamondCut} from "../src/interfaces/IDiamondCut.sol";
import {SubnetActorFacet} from "../src/facets/SubnetActorFacet.sol";
import {SubnetID} from "../src/structs/Subnet.sol";
import {RouterFacet} from "../src/facets/RouterFacet.sol";
import {SubnetManagerFacet} from "../src/facets/SubnetManagerFacet.sol";
import {InfoFacet} from "../src/facets/InfoFacet.sol";
import {StorableMsg} from "../src/structs/Checkpoint.sol";
import "../src/SubnetActor.sol";

contract SubnetActorDiamondTest is Test {
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;

    bytes4[] saSelectors;
    bytes4[] routerSelectors;
    bytes4[] managerSelectors;
    bytes4[] infoSelectors;

    SubnetActorDiamond saDiamond;
    SubnetActorFacet sa;

    GatewayDiamond gatewayDiamond;
    SubnetManagerFacet gwManager;
    InfoFacet gwInfo;
    RouterFacet gwRouter;

    address private constant DEFAULT_IPC_GATEWAY_ADDR = address(1024);
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    bytes32 private constant DEFAULT_NETWORK_NAME = bytes32("test");
    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    string private constant DEFAULT_NET_ADDR = "netAddr";
    bytes private constant GENESIS = EMPTY_BYTES;
    uint256 constant CROSS_MSG_FEE = 10 gwei;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    uint64 private constant ROOTNET_CHAINID = 123;
    address GATEWAY_ADDRESS;

    error NotGateway();
    error NotAccount();
    error CollateralIsZero();
    error CallerHasNoStake();
    error SubnetAlreadyKilled();
    error NotAllValidatorsHaveLeft();
    error NotValidator();
    error SubnetNotActive();
    error WrongCheckpointSource();
    error CheckpointNotChained();
    error NoRewardsSentForDistribution();
    error NoValidatorsInSubnet();
    error NotEnoughBalanceForRewards();
    error EpochAlreadyExecuted();
    error EpochNotVotable();
    error ValidatorAlreadyVoted();
    error MessagesNotSorted();
    error NoRewardToWithdraw();
    error GatewayCannotBeZero();

    function generateSelectors(string memory facetName) internal returns (bytes4[] memory facetSelectors) {
        string[] memory inputs = new string[](3);
        inputs[0] = "python3";
        inputs[1] = "scripts/python/get_selectors.py";
        inputs[2] = facetName;

        bytes memory res = vm.ffi(inputs);
        facetSelectors = abi.decode(res, (bytes4[]));
    }

    function createGWDiamond(GatewayDiamond.ConstructorParams memory params) public returns (GatewayDiamond) {
        gwRouter = new RouterFacet();
        gwManager = new SubnetManagerFacet();
        gwInfo = new InfoFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](3);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(gwRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: routerSelectors
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(gwManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: managerSelectors
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(gwInfo),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: infoSelectors
            })
        );

        gatewayDiamond = new GatewayDiamond(diamondCut, params);

        return gatewayDiamond;
    }

    function createSADiamond(SubnetActorDiamond.ConstructorParams memory params) public returns (SubnetActorDiamond) {
        sa = new SubnetActorFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](1);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(sa),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: saSelectors
            })
        );

        saDiamond = new SubnetActorDiamond(diamondCut, params);
        return saDiamond;
    }

    constructor() {
        saSelectors = generateSelectors("SubnetActorFacet");
        routerSelectors = generateSelectors("RouterFacet");
        infoSelectors = generateSelectors("InfoFacet");
        managerSelectors = generateSelectors("SubnetManagerFacet");
    }

    function setUp() public {
        GatewayDiamond.ConstructorParams memory gwConstructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });

        gatewayDiamond = createGWDiamond(gwConstructorParams);

        GATEWAY_ADDRESS = address(gatewayDiamond);

        _assertDeploySubnetActor(
            DEFAULT_NETWORK_NAME,
            GATEWAY_ADDRESS,
            ConsensusType.Mir,
            DEFAULT_MIN_VALIDATOR_STAKE,
            DEFAULT_MIN_VALIDATORS,
            DEFAULT_CHECKPOINT_PERIOD,
            GENESIS,
            DEFAULT_MAJORITY_PERCENTAGE
        );
    }

    function testSubnetActorDiamond_Deployment_Works(
        bytes32 _networkName,
        address _ipcGatewayAddr,
        uint256 _minActivationCollateral,
        uint64 _minValidators,
        uint64 _checkPeriod,
        bytes calldata _genesis,
        uint8 _majorityPercentage
    ) public {
        vm.assume(_minActivationCollateral > DEFAULT_MIN_VALIDATOR_STAKE);
        vm.assume(_checkPeriod > DEFAULT_CHECKPOINT_PERIOD);
        vm.assume(_majorityPercentage <= 100);
        vm.assume(_ipcGatewayAddr != address(0));

        _assertDeploySubnetActor(
            _networkName,
            _ipcGatewayAddr,
            ConsensusType.Mir,
            _minActivationCollateral,
            _minValidators,
            _checkPeriod,
            _genesis,
            _majorityPercentage
        );

        SubnetID memory parent = sa.getParent();
        require(parent.isRoot(), "parent.isRoot()");
    }

    function testSubnetActorDiamond_Deployments_Fail_GatewayCannotBeZero() public {
        vm.expectRevert(GatewayCannotBeZero.selector);

        saDiamond = createSADiamond(
            SubnetActorDiamond.ConstructorParams({
                parentId: SubnetID(ROOTNET_CHAINID, new address[](0)),
                name: DEFAULT_NETWORK_NAME,
                ipcGatewayAddr: address(0),
                consensus: ConsensusType.Mir,
                minActivationCollateral: DEFAULT_MIN_VALIDATOR_STAKE,
                minValidators: DEFAULT_MIN_VALIDATORS,
                bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
                topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
                majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
                genesis: EMPTY_BYTES
            })
        );
    }

    function testSubnetActorDiamond_Receive_Fail_NotGateway() public {
        vm.expectRevert(NotGateway.selector);
        (bool success, ) = payable(address(sa)).call{value: 1}("");
        require(success);
    }

    function testSubnetActorDiamond_Receive_Works() public {
        vm.prank(GATEWAY_ADDRESS);
        vm.deal(GATEWAY_ADDRESS, 1);
        (bool success, ) = payable(address(sa)).call{value: 1}("");
        require(success);
    }

    function testSubnetActorDiamond_Join_Fail_NoMinColalteral() public {
        address validator = vm.addr(100);

        vm.deal(validator, 1 gwei);
        vm.prank(validator);
        vm.expectRevert(CollateralIsZero.selector);

        sa.join(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));
    }

    function testSubnetActorDiamond_Join_Fail_NotAccount() public {
        address contractAddress = address(sa);
        vm.deal(contractAddress, 1 gwei);
        vm.prank(contractAddress);
        vm.expectRevert(NotAccount.selector);

        sa.join(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));
    }

    function testSubnetActorDiamond_Join_Fail_AlreadyKilled() public {
        address validator = vm.addr(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertLeave(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertKill(validator);

        vm.expectRevert(SubnetAlreadyKilled.selector);
        vm.prank(validator);
        vm.deal(validator, DEFAULT_MIN_VALIDATOR_STAKE + 1);

        sa.join{value: DEFAULT_MIN_VALIDATOR_STAKE}(
            DEFAULT_NET_ADDR,
            FvmAddress({addrType: 1, payload: new bytes(20)})
        );
    }

    function testSubnetActorDiamond_Join_Works_CallAddStake() public {
        address validator = vm.addr(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.expectCall(
            GATEWAY_ADDRESS,
            DEFAULT_MIN_VALIDATOR_STAKE,
            abi.encodeWithSelector(gwManager.addStake.selector),
            1
        );

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        require(sa.validatorCount() == 1);
        require(sa.validatorAt(0) == validator);
    }

    function testSubnetActorDiamond_Join_Works_CallRegister() public {
        address validator = vm.addr(1235);

        vm.expectCall(
            GATEWAY_ADDRESS,
            DEFAULT_MIN_VALIDATOR_STAKE,
            abi.encodeWithSelector(gwManager.register.selector),
            1
        );

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
    }

    function testSubnetActorDiamond_Join_Works_LessThanMinStake() public {
        address validator = vm.addr(1235);
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE / 2;
        vm.deal(validator, amount + 1);
        vm.prank(validator);
        vm.expectCall(GATEWAY_ADDRESS, amount, abi.encodeWithSelector(gwManager.register.selector), 0);
        vm.expectCall(GATEWAY_ADDRESS, amount, abi.encodeWithSelector(gwManager.addStake.selector), 0);
        sa.join{value: amount}(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));

        require(sa.validatorCount() == 0);
    }

    function testSubnetActorDiamond_Join_Works_MultipleNewValidators() public {
        _assertJoin(vm.addr(1234), DEFAULT_MIN_VALIDATOR_STAKE);
        _assertJoin(vm.addr(1235), DEFAULT_MIN_VALIDATOR_STAKE);

        require(sa.validatorCount() == 2);
    }

    function testSubnetActorDiamond_Join_Works_NoNewValidator_CollateralNotEnough() public {
        address validator = vm.addr(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE - 1);

        require(sa.validatorCount() == 0);
        require(sa.status() == Status.Instantiated);
    }

    function testSubnetActorDiamond_Join_Works_ReactivateSubnet() public {
        _assertJoin(vm.addr(1234), DEFAULT_MIN_VALIDATOR_STAKE);
        _assertLeave(vm.addr(1234), DEFAULT_MIN_VALIDATOR_STAKE);

        require(sa.totalStake() == 0);
        require(sa.validatorCount() == 0);
        require(sa.status() == Status.Inactive);

        _assertJoin(vm.addr(1235), DEFAULT_MIN_VALIDATOR_STAKE);

        require(sa.validatorCount() == 1);
        require(sa.status() == Status.Active);
    }

    function testSubnetActorDiamond_Leave_Works_NoValidatorsLeft() public payable {
        address validator = address(1235);
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        _assertJoin(validator, amount);

        _assertLeave(validator, amount);

        require(sa.totalStake() == 0);
        require(sa.validatorCount() == 0);
        require(sa.status() == Status.Inactive);
    }

    function testSubnetActorDiamond_Leave_Works_StillActive() public payable {
        address validator1 = address(1234);
        address validator2 = address(1235);
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        _assertJoin(validator1, amount);
        _assertJoin(validator2, amount);

        _assertLeave(validator1, amount);

        require(sa.totalStake() == amount);
        require(sa.validatorCount() == 1);
        require(sa.status() == Status.Active);
    }

    function testSubnetActorDiamond_Leave_Fail_NotAccount() public payable {
        address contractAddress = address(sa);
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        vm.prank(contractAddress);
        vm.deal(contractAddress, amount);
        vm.expectRevert(NotAccount.selector);

        sa.leave();
    }

    function testSubnetActorDiamond_Leave_Fail_AlreadyKilled() public payable {
        address validator = address(1235);
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        _assertJoin(validator, amount);

        _assertLeave(validator, amount);
        _assertKill(validator);

        vm.prank(validator);
        vm.deal(validator, amount);
        vm.expectRevert(SubnetAlreadyKilled.selector);

        sa.leave();
    }

    function testSubnetActorDiamond_Leave_Fail_NoStake() public payable {
        address caller = address(1235);

        vm.prank(caller);
        vm.deal(caller, 1 ether);

        vm.expectRevert(NotValidator.selector);

        sa.leave();
    }

    function testSubnetActorDiamond_Kill_Works() public payable {
        address validator = address(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertLeave(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        _assertKill(validator);

        require(GATEWAY_ADDRESS.balance == 0);
        require(gwInfo.totalSubnets() == 0);
    }

    function testSubnetActorDiamond_Kill_Fails_NotAccount() public payable {
        address contractAddress = address(sa);

        vm.prank(contractAddress);
        vm.expectRevert(NotAccount.selector);
        sa.kill();
    }

    function testSubnetActorDiamond_Kill_Fails_NotAllValidatorsLeft() public payable {
        address validator1 = address(1235);
        address validator2 = address(1236);

        _assertJoin(validator1, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        _assertLeave(validator1, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.prank(validator1);
        vm.expectRevert(NotAllValidatorsHaveLeft.selector);
        sa.kill();
    }

    function testSubnetActorDiamond_Kill_Fails_AlreadyTerminating() public {
        address validator = vm.addr(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertLeave(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        _assertKill(validator);

        vm.prank(validator);
        vm.expectRevert(SubnetAlreadyKilled.selector);

        sa.kill();
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_Executed() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator3 = vm.addr(102);
        _assertJoin(validator3, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint);
        _assertVote(validator2, checkpoint);

        vm.expectCall(
            GATEWAY_ADDRESS,
            abi.encodeWithSelector(IGateway(GATEWAY_ADDRESS).commitChildCheck.selector, checkpoint)
        );

        _assertVote(validator3, checkpoint);

        (SubnetID memory source, uint64 epoch, uint256 fee, bytes32 prevHash, bytes memory proof) = sa
            .committedCheckpoints(checkpoint.epoch);

        require(sa.prevExecutedCheckpointHash() == checkpoint.toHash());
        require(sa.lastVotingExecutedEpoch() == checkpoint.epoch);
        require(source.toHash() == checkpoint.source.toHash());
        require(epoch == checkpoint.epoch);
        require(fee == checkpoint.fee);
        require(prevHash == checkpoint.prevHash);
        require(proof.length == 0);
    }

    function testSubnetActorDiamond_SubnetCheckpoint_Works_ExecutedFromQueue() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator3 = vm.addr(102);
        _assertJoin(validator3, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint1 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint2 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint3 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint4 = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint1);
        _assertVote(validator2, checkpoint1);
        _assertVote(validator3, checkpoint1);

        require(sa.lastVotingExecutedEpoch() == checkpoint1.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint1.toHash());

        // next epochs
        checkpoint2.epoch = checkpoint1.epoch + DEFAULT_CHECKPOINT_PERIOD;
        checkpoint3.epoch = checkpoint2.epoch + DEFAULT_CHECKPOINT_PERIOD;
        checkpoint4.epoch = checkpoint3.epoch + DEFAULT_CHECKPOINT_PERIOD;
        checkpoint2.crossMsgs[0].message.nonce = checkpoint1.crossMsgs[0].message.nonce + 1;
        checkpoint3.crossMsgs[0].message.nonce = checkpoint2.crossMsgs[0].message.nonce + 1;
        checkpoint4.crossMsgs[0].message.nonce = checkpoint3.crossMsgs[0].message.nonce + 1;
        checkpoint2.prevHash = checkpoint1.toHash();
        checkpoint3.prevHash = checkpoint2.toHash();
        checkpoint4.prevHash = checkpoint3.toHash();

        // add checkpoint 3 to the queue
        _assertVote(validator, checkpoint3);
        _assertVote(validator2, checkpoint3);
        _assertVote(validator3, checkpoint3);

        // ensures no execution is triggered
        require(sa.lastVotingExecutedEpoch() == checkpoint1.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint1.toHash());

        // trigger execution of checkpoint 2
        _assertVote(validator, checkpoint2);
        _assertVote(validator2, checkpoint2);
        _assertVote(validator3, checkpoint2);

        require(sa.lastVotingExecutedEpoch() == checkpoint2.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint2.toHash());

        // vote for checkpoint 4 and trigger execution of checkpoint 3 from the queue
        _assertVote(validator, checkpoint4);

        (SubnetID memory source, uint64 epoch, uint256 fee, bytes32 prevHash, bytes memory proof) = sa
            .committedCheckpoints(checkpoint3.epoch);

        require(sa.lastVotingExecutedEpoch() == checkpoint3.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint3.toHash());
        require(source.toHash() == checkpoint3.source.toHash());
        require(epoch == checkpoint3.epoch);
        require(fee == checkpoint3.fee);
        require(prevHash == checkpoint3.prevHash);
        require(proof.length == 0);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_RoundAbort() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint1 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint2 = _createBottomUpCheckpoint();

        checkpoint2.fee = 1;

        _assertVote(validator, checkpoint1);

        vm.prank(validator2);

        // should reset votes
        sa.submitCheckpoint(checkpoint2);

        require(sa.hasValidatorVotedForSubmission(checkpoint1.epoch, validator) == false);
        require(sa.hasValidatorVotedForSubmission(checkpoint2.epoch, validator2) == false);
        require(sa.lastVotingExecutedEpoch() == 0);

        (, uint256 first, uint256 last) = sa.executableQueue();

        require(first == 0);
        require(last == 0);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_MessagesNotSorted() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(address(sa));
        CrossMsg[] memory crossMsgs = new CrossMsg[](2);
        crossMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({
                    subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                    rawAddress: address(this)
                }),
                to: IPCAddress({
                    subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                    rawAddress: address(this)
                }),
                value: CROSS_MSG_FEE + 1,
                nonce: 1,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: false
        });
        crossMsgs[1] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({
                    subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                    rawAddress: address(this)
                }),
                to: IPCAddress({
                    subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                    rawAddress: address(this)
                }),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: false
        });
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            fee: 0,
            crossMsgs: crossMsgs,
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        vm.expectRevert(MessagesNotSorted.selector);
        vm.prank(validator);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_CheckpointNotChained() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator3 = vm.addr(102);
        _assertJoin(validator3, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint1 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint2 = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint1);
        _assertVote(validator2, checkpoint1);
        _assertVote(validator3, checkpoint1);

        require(sa.lastVotingExecutedEpoch() == checkpoint1.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint1.toHash());

        // set next epoch
        checkpoint2.epoch = checkpoint1.epoch + DEFAULT_CHECKPOINT_PERIOD;

        _assertVote(validator, checkpoint2);
        _assertVote(validator2, checkpoint2);

        // not committed
        vm.expectCall(
            GATEWAY_ADDRESS,
            abi.encodeWithSelector(IGateway(GATEWAY_ADDRESS).commitChildCheck.selector, checkpoint2),
            0
        );
        vm.prank(validator3);

        // should reset votes
        sa.submitCheckpoint(checkpoint2);

        require(sa.hasValidatorVotedForSubmission(checkpoint2.epoch, validator) == false);
        require(sa.hasValidatorVotedForSubmission(checkpoint2.epoch, validator2) == false);
        require(sa.hasValidatorVotedForSubmission(checkpoint2.epoch, validator3) == false);
        require(sa.lastVotingExecutedEpoch() == checkpoint1.epoch);
        require(sa.prevExecutedCheckpointHash() == checkpoint1.toHash());

        (, uint256 first, uint256 last) = sa.executableQueue();

        require(first == 0);
        require(last == 0);
    }

    function callback() public view {
        console.log("callback called");
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_MostVotedWeightEqualToThreshold_Abort() public {
        uint8 majorityPercentage = 50;

        _assertDeploySubnetActor(
            DEFAULT_NETWORK_NAME,
            GATEWAY_ADDRESS,
            ConsensusType.Mir,
            DEFAULT_MIN_VALIDATOR_STAKE,
            DEFAULT_MIN_VALIDATORS,
            DEFAULT_CHECKPOINT_PERIOD,
            GENESIS,
            majorityPercentage
        );

        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint1 = _createBottomUpCheckpoint();
        BottomUpCheckpoint memory checkpoint2 = _createBottomUpCheckpoint();

        checkpoint2.crossMsgs[0].message.value = 1;

        _assertVote(validator, checkpoint1);

        vm.prank(validator2);

        // should reset votes
        sa.submitCheckpoint(checkpoint2);

        require(sa.hasValidatorVotedForSubmission(checkpoint1.epoch, validator) == false);
        require(sa.hasValidatorVotedForSubmission(checkpoint2.epoch, validator2) == false);
        require(sa.lastVotingExecutedEpoch() == 0);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_VoteForCheckpoint() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        address validator2 = vm.addr(101);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint);

        require(sa.hasValidatorVotedForSubmission(checkpoint.epoch, validator) == true);
        require(sa.hasValidatorVotedForSubmission(checkpoint.epoch, validator2) == false);
        require(sa.lastVotingExecutedEpoch() == 0);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_NotAccount() public {
        address validator = address(1235);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.prank(validator);
        vm.expectRevert(NotAccount.selector);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_SubnetNotActive() public {
        address validator = address(1235);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertLeave(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.prank(validator);
        vm.expectRevert(SubnetNotActive.selector);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_InvalidValidator() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        address notValidator = vm.addr(200);
        vm.prank(notValidator);
        vm.deal(notValidator, 1);
        vm.expectRevert(NotValidator.selector);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_WrongSource() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        checkpoint.source = SubnetID(0, new address[](0));

        vm.prank(validator);
        vm.expectRevert(WrongCheckpointSource.selector);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_EpochAlreadyExecuted() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint);

        checkpoint.epoch = 1;

        vm.prank(validator);
        vm.expectRevert(EpochAlreadyExecuted.selector);
        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_EpochNotVotable() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        checkpoint.epoch = 11;

        vm.prank(validator);
        vm.expectRevert(EpochNotVotable.selector);

        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Fails_ValidatorAlreadyVoted() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        address validator2 = vm.addr(200);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        _assertVote(validator, checkpoint);

        vm.expectRevert(ValidatorAlreadyVoted.selector);
        vm.prank(validator);

        sa.submitCheckpoint(checkpoint);
    }

    function testSubnetActorDiamond_Reward_Works_SingleValidator() public {
        address validator = vm.addr(100);

        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.startPrank(GATEWAY_ADDRESS);
        vm.deal(GATEWAY_ADDRESS, 1 ether);

        sa.reward(1 ether);

        require(sa.accumulatedRewards(validator) == 1 ether);
        // sa.reward{value: 1}();

        // require(validator.balance == balanceBefore + 1);
    }

    function testSubnetActorDiamond_Reward_Works_MultipleValidators() public {
        address validator1 = vm.addr(100);
        address validator2 = vm.addr(101);

        _assertJoin(validator1, DEFAULT_MIN_VALIDATOR_STAKE);
        _assertJoin(validator2, DEFAULT_MIN_VALIDATOR_STAKE);

        uint256 validator1BalanceBefore = sa.accumulatedRewards(validator1);
        uint256 validator2BalanceBefore = sa.accumulatedRewards(validator2);

        vm.startPrank(GATEWAY_ADDRESS);
        vm.deal(GATEWAY_ADDRESS, 1 ether);

        sa.reward(110);

        require(sa.accumulatedRewards(validator1) - validator1BalanceBefore == 55);
        require(sa.accumulatedRewards(validator2) - validator2BalanceBefore == 55);
    }

    function testSubnetActorDiamond_Reward_Fails_NoValidatorsInSubnet() public {
        vm.startPrank(GATEWAY_ADDRESS);
        vm.deal(GATEWAY_ADDRESS, 1 ether);
        vm.expectRevert(NoValidatorsInSubnet.selector);

        sa.reward(1 ether);
    }

    function testSubnetActorDiamond_Reward_Fails_NotGateway() public {
        address notGatewayAddr = vm.addr(101);

        vm.startPrank(notGatewayAddr);
        vm.deal(notGatewayAddr, 1 ether);
        vm.expectRevert(NotGateway.selector);

        sa.reward(1 ether);
    }

    function testSubnetActorDiamond_Reward_Fails_NotEnoughBalanceForRewards() public {
        _assertJoin(vm.addr(100), DEFAULT_MIN_VALIDATOR_STAKE);
        _assertJoin(vm.addr(101), DEFAULT_MIN_VALIDATOR_STAKE);

        vm.startPrank(GATEWAY_ADDRESS);
        vm.deal(GATEWAY_ADDRESS, 1 ether);
        vm.expectRevert(NotEnoughBalanceForRewards.selector);

        sa.reward(1);
    }

    function testSubnetActorDiamond_Withdraw_Fails_NotAccount() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.prank(address(this));
        vm.expectRevert(NotAccount.selector);

        sa.withdraw();
    }

    function testSubnetActorDiamond_Withdraw_Fails_NoRewardToWithdraw() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.prank(validator);
        vm.expectRevert(NoRewardToWithdraw.selector);

        sa.withdraw();
    }

    function testSubnetActorDiamond_Withdraw_Works() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        vm.deal(GATEWAY_ADDRESS, 1 ether + 1);
        vm.prank(GATEWAY_ADDRESS);
        sa.reward(1 ether);

        uint256 balanceBefore = validator.balance;
        vm.prank(validator);
        sa.withdraw();

        require(validator.balance == balanceBefore + 1 ether);
        require(sa.accumulatedRewards(validator) == 0);
    }

    function _assertJoin(address validator, uint256 amount) internal {
        vm.startPrank(validator);
        vm.deal(validator, amount + 1);

        uint256 balanceBefore = validator.balance;
        uint256 stakeBefore = sa.stake(validator);
        uint256 totalStakeBefore = sa.totalStake();

        sa.join{value: amount}(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));

        require(sa.stake(validator) == stakeBefore + amount);
        require(sa.totalStake() == totalStakeBefore + amount);
        require(validator.balance == balanceBefore - amount);

        vm.stopPrank();
    }

    function _assertLeave(address validator, uint256 amount) internal {
        uint256 validatorBalanceBefore = validator.balance;
        uint256 validatorsCountBefore = sa.validatorCount();
        uint256 totalStakeBefore = sa.totalStake();

        vm.prank(validator);
        vm.expectCall(GATEWAY_ADDRESS, abi.encodeWithSelector(gwManager.releaseStake.selector, amount));
        vm.expectCall(validator, amount, EMPTY_BYTES);

        sa.leave();

        require(sa.stake(validator) == 0);
        require(sa.totalStake() == totalStakeBefore - amount);
        require(sa.validatorCount() == validatorsCountBefore - 1);
        require(validator.balance == validatorBalanceBefore + amount);
    }

    function _assertKill(address validator) internal {
        vm.startPrank(validator);
        vm.deal(validator, 1 ether);
        vm.expectCall(GATEWAY_ADDRESS, abi.encodeWithSelector(gwManager.kill.selector));

        sa.kill();

        require(sa.totalStake() == 0);
        require(sa.validatorCount() == 0);
        require(sa.status() == Status.Killed);

        vm.stopPrank();
    }

    function _assertVote(address validator, BottomUpCheckpoint memory checkpoint) internal {
        vm.prank(validator);
        sa.submitCheckpoint(checkpoint);

        require(sa.hasValidatorVotedForSubmission(checkpoint.epoch, validator) == true, "validator not voted");
    }

    function _assertDeploySubnetActor(
        bytes32 _name,
        address _ipcGatewayAddr,
        ConsensusType _consensus,
        uint256 _minActivationCollateral,
        uint64 _minValidators,
        uint64 _checkPeriod,
        bytes memory _genesis,
        uint8 _majorityPercentage
    ) public {
        SubnetID memory _parentId = gwInfo.getNetworkName();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](1);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(sa),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: saSelectors
            })
        );

        saDiamond = new SubnetActorDiamond(
            diamondCut,
            SubnetActorDiamond.ConstructorParams({
                parentId: _parentId,
                name: _name,
                ipcGatewayAddr: _ipcGatewayAddr,
                consensus: _consensus,
                minActivationCollateral: _minActivationCollateral,
                minValidators: _minValidators,
                bottomUpCheckPeriod: _checkPeriod,
                topDownCheckPeriod: _checkPeriod,
                majorityPercentage: _majorityPercentage,
                genesis: _genesis
            })
        );

        require(
            keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked(_name)),
            "keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked(_networkName))"
        );
        require(sa.ipcGatewayAddr() == _ipcGatewayAddr, "sa.ipcGatewayAddr() == _ipcGatewayAddr");
        require(
            sa.minActivationCollateral() == _minActivationCollateral,
            "sa.minActivationCollateral() == _minActivationCollateral"
        );
        require(sa.minValidators() == _minValidators, "sa.minValidators() == _minValidators");
        require(sa.topDownCheckPeriod() == _checkPeriod, "sa.topDownCheckPeriod() == _checkPeriod");
        require(keccak256(sa.genesis()) == keccak256(_genesis), "keccak256(sa.genesis()) == keccak256(_genesis)");
        require(sa.majorityPercentage() == _majorityPercentage, "sa.majorityPercentage() == _majorityPercentage");
        require(sa.consensus() == _consensus);
        require(
            sa.getParent().toHash() == _parentId.toHash(),
            "parent.toHash() == SubnetID({root: ROOTNET_CHAINID, route: path}).toHash()"
        );
    }

    function _createBottomUpCheckpointWithConfig(
        uint64 epoch,
        uint64 nonce,
        bytes32 prevHash,
        bytes memory proof
    ) internal view returns (BottomUpCheckpoint memory checkpoint) {
        SubnetID memory subnetActorId = sa.getParent().createSubnetId(address(sa));
        CrossMsg[] memory crossMsgs = new CrossMsg[](1);

        crossMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: subnetActorId, rawAddress: address(this)}),
                to: IPCAddress({subnetId: subnetActorId, rawAddress: address(this)}),
                value: 0,
                nonce: nonce,
                method: this.callback.selector,
                params: new bytes(0)
            }),
            wrapped: false
        });

        checkpoint = BottomUpCheckpoint({
            source: subnetActorId,
            epoch: epoch,
            fee: 0,
            crossMsgs: crossMsgs,
            prevHash: prevHash,
            children: new ChildCheck[](0),
            proof: proof
        });
    }

    function _createBottomUpCheckpoint() internal view returns (BottomUpCheckpoint memory checkpoint) {
        return _createBottomUpCheckpointWithConfig(DEFAULT_CHECKPOINT_PERIOD, 0, EMPTY_HASH, new bytes(0));
    }

    function invariant_BalanceEqualsTotalStake() public {
        assertEq(address(gatewayDiamond).balance, sa.totalStake());
        assertEq(address(sa).balance, 0);
    }

    function testSubnetActorDiamond_SubmitCheckpoint_Works_TwoRounds() public {
        address validator = vm.addr(100);
        _assertJoin(validator, DEFAULT_MIN_VALIDATOR_STAKE);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.expectCall(
            GATEWAY_ADDRESS,
            abi.encodeWithSelector(IGateway(GATEWAY_ADDRESS).commitChildCheck.selector, checkpoint)
        );
        _assertVote(validator, checkpoint);

        (SubnetID memory source, uint64 epoch, uint256 fee, bytes32 prevHash, bytes memory proof) = sa
            .committedCheckpoints(checkpoint.epoch);

        require(sa.prevExecutedCheckpointHash() == checkpoint.toHash());
        require(sa.lastVotingExecutedEpoch() == checkpoint.epoch);
        require(source.toHash() == checkpoint.source.toHash());
        require(epoch == checkpoint.epoch);
        require(fee == checkpoint.fee);
        require(prevHash == checkpoint.prevHash);
        require(proof.length == 0);

        bytes memory testProof = abi.encodePacked("testProof");

        BottomUpCheckpoint memory checkpoint2 = _createBottomUpCheckpointWithConfig(
            2 * DEFAULT_CHECKPOINT_PERIOD,
            1,
            checkpoint.toHash(),
            testProof
        );

        vm.expectCall(
            GATEWAY_ADDRESS,
            abi.encodeWithSelector(IGateway(GATEWAY_ADDRESS).commitChildCheck.selector, checkpoint2)
        );
        _assertVote(validator, checkpoint2);

        (SubnetID memory source2, uint64 epoch2, uint256 fee2, bytes32 prevHash2, bytes memory proof2) = sa
            .committedCheckpoints(checkpoint2.epoch);

        require(sa.prevExecutedCheckpointHash() == checkpoint2.toHash());
        require(sa.lastVotingExecutedEpoch() == checkpoint2.epoch);
        require(source2.toHash() == checkpoint2.source.toHash());
        require(epoch2 == checkpoint2.epoch);
        require(fee2 == checkpoint2.fee);
        require(prevHash2 == checkpoint2.prevHash);
        require(keccak256(proof2) == keccak256(checkpoint2.proof));
    }
}
