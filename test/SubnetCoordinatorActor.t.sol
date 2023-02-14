pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetCoordinatorActor.sol";

contract SubnetActorTest is Test {
    SubnetCoordinatorActor sca;

    function setUp() public {
        sca = new SubnetCoordinatorActor("/root", 10);
    }

    function testDeployment() public view {
        (string memory parent, address actor) = sca.networkName();

        require(
            keccak256(abi.encode(parent)) == keccak256(abi.encode("/root"))
        );
        require(actor == address(0));
    }
}
