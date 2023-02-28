// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetActor.sol";
import "../src/Gateway.sol";
import "../src/enums/Status.sol";
import "../src/structs/Subnet.sol";
import "../src/lib/SubnetIDHelper.sol";
import "../src/lib/CheckpointHelper.sol";

contract SubnetActorTest is Test {

    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;

    SubnetActor sa;
    Gateway gw;

    address private constant DEFAULT_IPC_GATEWAY_ADDR = address(1024);
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    string private constant DEFAULT_NETWORK_NAME = "test";
    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    bytes private constant GENESIS = EMPTY_BYTES;
    uint256 constant CROSS_MSG_FEE = 10 gwei;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;

    function setUp() public
    {
        address[] memory path = new address[](1);
        path[0] = address(0);

        Gateway.ConstructorParams memory constructorParams = Gateway.ConstructorParams({
            networkName: SubnetID({route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            genesisEpoch: 0,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gw = new Gateway(constructorParams);

        path[0] = address(gw);

        SubnetActor.ConstructParams memory subnetConstructorParams = SubnetActor.ConstructParams({
            parentId: SubnetID({route: path}),
            name: DEFAULT_NETWORK_NAME,
            ipcGatewayAddr: address(gw),
            consensus: ConsensusType.Dummy,
            minValidatorStake: DEFAULT_MIN_VALIDATOR_STAKE,
            minValidators: DEFAULT_MIN_VALIDATORS,
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            currentEpoch: 0,
            genesis: GENESIS

        });
        sa = new SubnetActor(subnetConstructorParams);
        
    }

    function testDeployment(string calldata _networkName, address _ipcGatewayAddr, uint256 _minValidatorStake, uint64 _minValidators, uint64 _checkPeriod, bytes calldata _genesis, uint8 _majorityPercentage) public {
        vm.assume(_minValidatorStake > DEFAULT_MIN_VALIDATOR_STAKE);
        vm.assume(_checkPeriod > DEFAULT_CHECKPOINT_PERIOD);
        vm.assume(_majorityPercentage <= 100);

        address[] memory path = new address[](1);
        path[0] = address(0);

        SubnetActor.ConstructParams memory subnetConstructorParams = SubnetActor.ConstructParams({
            parentId: SubnetID({route: path}),
            name: _networkName,
            ipcGatewayAddr: _ipcGatewayAddr,
            consensus: ConsensusType.Dummy,
            minValidatorStake: _minValidatorStake,
            minValidators: _minValidators,
            bottomUpCheckPeriod: _checkPeriod,
            topDownCheckPeriod: _checkPeriod,
            majorityPercentage: _majorityPercentage,
            currentEpoch: 0,
            genesis: _genesis
        });
        sa = new SubnetActor(subnetConstructorParams);

        require(keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked(_networkName)), "keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked(_networkName))");
        require(sa.ipcGatewayAddr() == _ipcGatewayAddr, "sa.ipcGatewayAddr() == _ipcGatewayAddr");
        require(sa.minValidatorStake() == _minValidatorStake, "sa.minValidatorStake() == _minValidatorStake");
        require(sa.minValidators() == _minValidators, "sa.minValidators() == _minValidators");
        require(sa.bottomUpCheckPeriod() == _checkPeriod, "sa.bottomUpCheckPeriod() == _checkPeriod");
        require(sa.topDownCheckPeriod() == _checkPeriod, "sa.topDownCheckPeriod() == _checkPeriod");
        require(keccak256(sa.genesis()) == keccak256(_genesis), "keccak256(sa.genesis()) == keccak256(_genesis)");
        require(sa.majorityPercentage() == _majorityPercentage, "sa.majorityPercentage() == _majorityPercentage");

        SubnetID memory parent = sa.getParent();
        require(parent.isRoot(), "parent.isRoot()");
        require(parent.toHash() == SubnetID({route: path}).toHash(), "parent.toHash() == SubnetID({route: path}).toHash()");
    }

    function test_Join_Fail_NoMinColalteral() public payable {
        address validator = vm.addr(100);
        vm.deal(validator, 1 gwei);
        vm.prank(validator);
        vm.expectRevert("a minimum collateral is required to join the subnet");
        sa.join();
    }

    function test_Join_Works() public payable {
        address validator = vm.addr(1235);

        vm.prank(validator);
        vm.deal(validator, DEFAULT_MIN_VALIDATOR_STAKE + 1);
        (bool success, ) = address(sa).call{value: DEFAULT_MIN_VALIDATOR_STAKE}(abi.encodeWithSignature("join()"));
        require(success);
        
        require(sa.stake(validator) == DEFAULT_MIN_VALIDATOR_STAKE);
        require(sa.totalStake() == DEFAULT_MIN_VALIDATOR_STAKE);
        require(sa.validatorCount() == 1);
        require(sa.validatorAt(0) == validator);
    }

    function test_Join_CallRegister() public {
        address validator = vm.addr(1235);

        vm.prank(validator);
        vm.deal(validator, DEFAULT_MIN_VALIDATOR_STAKE + 1);
        vm.expectCall(address(gw), DEFAULT_MIN_VALIDATOR_STAKE, abi.encodeWithSignature("register()"));
        (bool success, ) = address(sa).call{value: DEFAULT_MIN_VALIDATOR_STAKE}(abi.encodeWithSignature("join()"));
        require(success);
    }

    function test_Join_CallAddStake_SubnetAlreadyActive() public {
        address validator = vm.addr(1235);

        _join(validator);

        vm.prank(validator);
        vm.deal(validator, DEFAULT_MIN_VALIDATOR_STAKE / 2 + 1);
        vm.expectCall(address(gw), DEFAULT_MIN_VALIDATOR_STAKE / 2, abi.encodeWithSignature("addStake()"));
        (bool success, ) = address(sa).call{value: DEFAULT_MIN_VALIDATOR_STAKE / 2}(abi.encodeWithSignature("join()"));
        require(success);
    }

    function test_Join_NoNewValidator_ValueLowerThanMinStake() public {
        address validator = vm.addr(1235);
        vm.prank(validator);
        vm.deal(validator, DEFAULT_MIN_VALIDATOR_STAKE);
        (bool success, ) = address(sa).call{value: DEFAULT_MIN_VALIDATOR_STAKE - 1}(abi.encodeWithSignature("join()"));
        require(success);

        require(sa.stake(validator) == DEFAULT_MIN_VALIDATOR_STAKE - 1);
        require(sa.totalStake() == DEFAULT_MIN_VALIDATOR_STAKE - 1);
        require(sa.validatorCount() == 0);
    }

    function test_Join_NoNewValidator_AlreadyExists() public {
        address validator = vm.addr(1235);

        _join(validator);
        _join(validator);
        require(sa.stake(validator) == 2 * DEFAULT_MIN_VALIDATOR_STAKE);
        require(sa.validatorCount() == 1);
    }

    function test_Join_NoNewValidator_DelegatedConsensusType_ValidatorAlreadyJoined() public {
        address[] memory path = new address[](1);
        path[0] = address(gw);

        SubnetActor.ConstructParams memory subnetConstructorParams = SubnetActor.ConstructParams({
            parentId: SubnetID({route: path}),
            name: DEFAULT_NETWORK_NAME,
            ipcGatewayAddr: address(gw),
            consensus: ConsensusType.Delegated,
            minValidatorStake: DEFAULT_MIN_VALIDATOR_STAKE,
            minValidators: DEFAULT_MIN_VALIDATORS,
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            currentEpoch: 0,
            genesis: GENESIS
        });
        sa = new SubnetActor(subnetConstructorParams);

        address validator = vm.addr(1235);
        _join(validator);

        address validator2 = vm.addr(1236);
        _join(validator2);
        require(sa.validatorCount() == 1);
        require(sa.stake(validator) == DEFAULT_MIN_VALIDATOR_STAKE);
        require(sa.stake(validator2) == DEFAULT_MIN_VALIDATOR_STAKE);
    }

    function test_Leave_Works() public payable {
        address validator = address(1235);
        _join(validator);

        vm.prank(validator);
        vm.expectCall(address(gw), abi.encodeWithSignature("releaseStake(uint256)", DEFAULT_MIN_VALIDATOR_STAKE));
        vm.expectCall(validator, DEFAULT_MIN_VALIDATOR_STAKE, bytes(""));
        sa.leave();

        require(sa.stake(validator) == 0);
        require(sa.totalStake() == 0);
        require(sa.validatorCount() == 0);
    }

    function test_Leave_Fail_NoStake() public payable {
        address validator = address(1235);
        vm.prank(validator);
        vm.expectRevert();
        sa.leave();
    }

    function test_Kill_Works() public payable {

        address validator = address(1235);
        _join(validator);

        vm.startPrank(validator);
        sa.leave();

        vm.expectCall(address(gw), abi.encodeWithSignature("kill()"));
        sa.kill();

        require(address(gw).balance == 0);
        require(sa.totalStake() == 0);
        require(sa.validatorCount() == 0);
    }

    function test_Kill_Fails_NotAllValidatorsLeft() public payable {

        address validator1 = address(1235);
        address validator2 = address(1236);
       
        _join(validator1);
        _join(validator2);

        vm.prank(validator1);
        sa.leave();

        vm.prank(validator1);
        vm.expectRevert("this subnet can only be killed when all validators have left");
        sa.kill();
    }

    function test_Kill_Fails_AlreadyTerminating() public {
        address validator = vm.addr(1235);
        _join(validator);
        vm.startPrank(validator);
        sa.leave();
        sa.kill();
        vm.expectRevert("the subnet is already in a killed or terminating state");
        sa.kill();
    }

    function test_SubmitCheckpoint_Works() public {
        address validator = vm.addr(100);
        _join(validator);
        address validator2 = vm.addr(101);
        _join(validator2);
        address validator3 = vm.addr(102);
        _join(validator3);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();
        bytes32 checkpointHash = checkpoint.toHash();

        vm.prank(validator);
        sa.submitCheckpoint(checkpoint);

        require(sa.hasValidatorVotedForCommit(checkpointHash, validator) == true);

        vm.prank(validator2);
        sa.submitCheckpoint(checkpoint);

        require(sa.hasValidatorVotedForCommit(checkpointHash, validator2) == true);

        vm.prank(validator3);
        vm.expectCall(address(this), abi.encodeWithSelector(this.callback.selector));
        sa.submitCheckpoint(checkpoint);

        require(sa.hasValidatorVotedForCommit(checkpointHash, validator3) == true);
    }

    function callback() public view {
        console.log("callback called");
    }

    function test_SubmitCheckpoint_AddsVoter() public  {
        address validator = vm.addr(100);
        _join(validator);
        address validator2 = vm.addr(101);
        _join(validator2);
        
        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.prank(validator);
        sa.submitCheckpoint(checkpoint);

        bytes32 checkpointHash = checkpoint.toHash();
        require(sa.hasValidatorVotedForCommit(checkpointHash, validator) == true);
    }

    function test_SubmitCheckpoint_Fails_InvalidValidator() public {
        address validator = vm.addr(100);
        _join(validator);
        
        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        address notValidator = vm.addr(200);
        vm.prank(notValidator);
        vm.deal(notValidator, 1);
        vm.expectRevert("not validator");
        sa.submitCheckpoint(checkpoint);
    }

    function test_SubmitCheckpoint_Fails_CheckpointAlreadyCommited() public {
        address validator = vm.addr(100);
        _join(validator);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.prank(validator);
        sa.submitCheckpoint(checkpoint);

        checkpoint.epoch = 1;

        vm.prank(validator);
        vm.expectRevert("epoch in checkpoint doesn't correspond with a signing window");
        sa.submitCheckpoint(checkpoint);
    }

    function test_SubmitCheckpoint_Fails_ValidatorAlreadyVoted() public {
        address validator = vm.addr(100);
        _join(validator);

        address validator2 = vm.addr(200);
        _join(validator2);

        BottomUpCheckpoint memory checkpoint = _createBottomUpCheckpoint();

        vm.startPrank(validator);
        sa.submitCheckpoint(checkpoint);

        vm.expectRevert("validator has already voted the checkpoint");
        sa.submitCheckpoint(checkpoint);
    }

    function _join(address _validator) internal {
        uint256 amount = DEFAULT_MIN_VALIDATOR_STAKE;

        vm.prank(_validator);
        vm.deal(_validator, amount + 1);
        (bool success, ) = address(sa).call{value: amount}(abi.encodeWithSignature("join()"));
        require(success);
    }

    function _createBottomUpCheckpoint() internal view returns (BottomUpCheckpoint memory checkpoint){
        address[] memory route = new address[](2);
        route[0] = address(gw);
        route[1] = address(sa);
        SubnetID memory source = SubnetID({route: route});
        CrossMsg[] memory crossMsgs = new CrossMsg[](1);
        crossMsgs[0] = CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({route: new address[](0)}),
                        rawAddress: address(this)
                    }),
                    to: IPCAddress({
                        subnetId: gw.getNetworkName(),
                        rawAddress: address(this)
                    }),
                    value: 0,
                    nonce: 0,
                    method: this.callback.selector,
                    params: new bytes(0)
                }),
                wrapped: false
            });
        checkpoint = BottomUpCheckpoint({source: source, epoch: DEFAULT_CHECKPOINT_PERIOD, fee: 0, crossMsgs: crossMsgs, prevHash: EMPTY_HASH});

    }

}