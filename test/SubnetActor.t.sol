// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetActor.sol";
import "../src/Gateway.sol";
import "../src/enums/Status.sol";

contract SubnetActorTest is Test {

    SubnetActor sa;
    Gateway gw;

    address private constant DEFAULT_IPC_GATEWAY_ADDR = address(1024);
    int64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    string private constant DEFAULT_NETWORK_NAME = "test";
    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    int64 private constant DEFAULT_FINALITY_TRESHOLD = 1;
    int64 private constant DEFAULT_CHECK_PERIOD = 1;
    bytes private constant GENESIS = new bytes(0);

    function setUp() public
    {

        gw = new Gateway("/root", DEFAULT_CHECKPOINT_PERIOD);
        SubnetID memory parentId = SubnetID("/root", address(gw));
        sa = new SubnetActor(parentId, DEFAULT_NETWORK_NAME, address(gw), ConsensusType.Dummy, DEFAULT_MIN_VALIDATOR_STAKE, DEFAULT_MIN_VALIDATORS, DEFAULT_FINALITY_TRESHOLD, DEFAULT_CHECK_PERIOD, GENESIS);
    
    }

    function testDeployment(string calldata _networkName, address _ipcGatewayAddr, uint256 _minValidatorStake, uint64 _minValidators, int64 _finalityTreshold, int64 _checkPeriod, bytes calldata _genesis) public {
        
        SubnetID memory parentId = SubnetID("/root", _ipcGatewayAddr);
        sa = new SubnetActor(parentId, _networkName, _ipcGatewayAddr, ConsensusType.Dummy, _minValidatorStake, _minValidators, _finalityTreshold, _checkPeriod, _genesis);
    
        require(keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked(_networkName)));
        require(sa.ipcGatewayAddr() == _ipcGatewayAddr);
        require(sa.consensus() == ConsensusType.Dummy);
        require(sa.minValidatorStake() == _minValidatorStake);
        require(sa.minValidators() == _minValidators);
        require(sa.finalityThreshold() == _finalityTreshold);
        require(sa.checkPeriod() == _checkPeriod);
        require(keccak256(sa.genesis()) == keccak256(_genesis));
        (string memory parent, address actor) = sa.parentId();
        require(keccak256(abi.encodePacked(parent)) == keccak256(abi.encodePacked("/root")));
        require(actor == _ipcGatewayAddr);
    }

    function test_Join_Fail_NoAddressZero() public payable {
        address validator = address(0);

        vm.prank(validator);
        vm.expectRevert("validator address cannot be zero");
        sa.join(validator);
    }

    function test_Join_Fail_NoMinColalteral() public payable {
        address validator = address(1);
        vm.prank(validator);
        vm.expectRevert("a minimum collateral is required to join the subnet");
        sa.join(validator);
    }

    function test_Join_Works(uint256 amount) public payable {
        vm.assume(amount > 1 ether);

        address validator = address(1235);

        vm.prank(validator);
        vm.deal(validator, amount);
        (bool success, ) = address(sa).call{value: amount}(abi.encodeWithSignature("join(address)", validator));
        require(success);
        
        require(sa.stake(validator) == amount);
        require(sa.totalStake() == amount);
        require(sa.validatorCount() == 1);
        require(sa.validatorAt(0) == validator);
    }

    function test_Leave_Works() public payable {
        address validator = address(1235);
        _join(validator);

        vm.prank(validator);
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

    function _join(address _validator) internal {
        uint256 amount = 1 ether;

        vm.prank(_validator);
        vm.deal(_validator, amount);
        (bool success, ) = address(sa).call{value: amount}(abi.encodeWithSignature("join(address)", _validator));
        require(success);
    }

}