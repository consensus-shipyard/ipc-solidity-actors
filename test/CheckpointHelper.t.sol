// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";

import "../src/structs/Checkpoint.sol";
import "../src/lib/CheckpointHelper.sol";

contract CheckpointHelperTest is Test {
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointHelper for TopDownCheckpoint;

    BottomUpCheckpoint public checkpoint;
    TopDownCheckpoint public topDownCheckpoint;

    function test_ToHash_Works_BottomUpCheckpoint() public {
        checkpoint.epoch = 10;
        
        require(
            BottomUpCheckpoint({
                source: SubnetID(new address[](0)),
                epoch: 10,
                crossMsgs: new CrossMsg[](0),
                fee: 0,
                prevHash: EMPTY_HASH
            }).toHash() == checkpoint.toHash()
        );
    }

    function test_ToHash_Works_TopDownCheckpoint() public {
        topDownCheckpoint.epoch = 10;
        require(TopDownCheckpoint({
            epoch: 10,
            topDownMsgs: new CrossMsg[](0)
        }).toHash() == topDownCheckpoint.toHash());
    }

    function test_Sorted_SingleElement() public {
        checkpoint.crossMsgs = new CrossMsg[](1);
        checkpoint.crossMsgs[0].message.nonce = 10;
        require(checkpoint.isSorted());
    }

    function test_Sorted_True() public {
        checkpoint.crossMsgs = new CrossMsg[](3);
        checkpoint.crossMsgs[0].message.nonce = 10;
        checkpoint.crossMsgs[1].message.nonce = 20;
        checkpoint.crossMsgs[2].message.nonce = 30;
        require(checkpoint.isSorted());
    }

    function test_Sorted_False() public {
        checkpoint.crossMsgs = new CrossMsg[](3);
        checkpoint.crossMsgs[0].message.nonce = 10;
        checkpoint.crossMsgs[1].message.nonce = 20;
        checkpoint.crossMsgs[2].message.nonce = 10;
        require(checkpoint.isSorted() == false);
    }

}
