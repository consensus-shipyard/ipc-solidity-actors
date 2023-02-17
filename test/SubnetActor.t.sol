pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetActor.sol";

contract SubnetActorTest is Test {

    SubnetActor subnetActor;

    address private constant IPC_GATEWAY_ADDR = address(1024);
    string private constant NETWORK_NAME = "test";

    function setUp() public {
        SubnetID memory parentId = SubnetID("/root", address(0));
        subnetActor = new SubnetActor(parentId, NETWORK_NAME, IPC_GATEWAY_ADDR, ConsensusType.Dummy, 0, 0, 0, 0, 0);
    }
}