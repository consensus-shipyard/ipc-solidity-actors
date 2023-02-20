// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetActor.sol";

contract SubnetActorTest is Test {

    SubnetActor sa;

    address private constant IPC_GATEWAY_ADDR = address(1024);
    string private constant NETWORK_NAME = "test";

    function setUp() public {
        SubnetID memory parentId = SubnetID("/root", address(0));
        sa = new SubnetActor(parentId, NETWORK_NAME, IPC_GATEWAY_ADDR, ConsensusType.Dummy, 10, 10, 10, 10, 10);
    }


    function testDeployment() public view {

        require(keccak256(abi.encodePacked(sa.name())) == keccak256(abi.encodePacked("test")));
        require(sa.ipcGatewayAddr() == IPC_GATEWAY_ADDR);
        require(sa.consensus() == ConsensusType.Dummy);
        require(sa.minValidatorStake() == 10);
        require(sa.minValidators() == 10);
        require(sa.finalityThreshold() == 10);
        require(sa.checkPeriod() == 10);
        require(sa.genesis() == 10);
        (string memory parent, address actor) = sa.parentId();
        require(keccak256(abi.encodePacked(parent)) == keccak256(abi.encodePacked("/root")));
        require(actor == address(0));
    }
}