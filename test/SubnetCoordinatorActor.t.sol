// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SubnetCoordinatorActor.sol";

contract SubnetActorTest is Test {
    int64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint64 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant MAX_NONCE = type(uint64).max;

    SubnetCoordinatorActor sca;


    function testDeployment(int64 checkpointPeriod) public {
        vm.assume(checkpointPeriod >= DEFAULT_CHECKPOINT_PERIOD);

        sca = new SubnetCoordinatorActor("/root", checkpointPeriod);
    
        (string memory parent, address actor) = sca.networkName();

        require(
            keccak256(abi.encode(parent)) == keccak256(abi.encode("/root"))
        );
        require(actor == address(0));
        require(sca.minStake() == MIN_COLLATERAL_AMOUNT);
        require(sca.checkPeriod() == checkpointPeriod);
        require(sca.appliedBottomUpNonce() == MAX_NONCE);
    }
}
