// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/structs/Checkpoint.sol";
import "../src/lib/CheckpointHelper.sol";

contract CheckpointHelperTest is Test {
    using CheckpointHelper for Checkpoint;

    Checkpoint public checkpoint;

    function test_ToHash_Works_EmptyCheckpoint() public view {
        require(
            CheckpointHelper.EMPTY_CHECKPOINT_DATA_HASH == checkpoint.toHash()
        );
    }

    function test_ToHash_Works_NonEmptyCheckpoint() public {
        checkpoint.data.epoch = 10;

        // checkpoint with epoch = 10
        bytes32 expected = 0xeb38f3be9a69f7b48ad5fecc6e052d96a0c77c986204d4c96c556f22d472cb08;

        require(expected == checkpoint.toHash());
    }

    function test_HasCrossMsgMeta_Works_True() public {
        checkpoint.data.crossMsgs.nonce = 1;
        checkpoint.data.crossMsgs.value = 1;

        require(checkpoint.hasCrossMsgMeta() == true);
    }

    function test_HasCrossMsgMeta_Works_False() public view {
        require(checkpoint.hasCrossMsgMeta() == false);
    }
}
