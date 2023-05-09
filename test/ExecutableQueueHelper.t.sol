// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";

import "../src/lib/ExecutableQueueHelper.sol";
import "../src/structs/ExecutableQueue.sol";

contract ExecutableQueueHelperTest is Test {
    using ExecutableQueueHelper for ExecutableQueue;

    ExecutableQueue private queue;

    uint64 constant EPOCH_ONE = 10;
    uint64 constant EPOCH_TWO = 20;

    function test_Push_Works_SingleEpoch() public {
        _assertPush(EPOCH_ONE, 0);
    }

    function test_Push_Works_MultipleEpochs() public {
        _assertPush(EPOCH_ONE, 0);
        _assertPush(EPOCH_TWO, 1);
    }

    function test_Push_Fail_AlreadyExists() public {
        _assertPush(EPOCH_ONE, 0);

        queue.push(EPOCH_ONE);

        require(queue.tail == 1);
    }

    function test_Pop_Works() public {
        _assertPush(EPOCH_ONE, 0);
        _assertPop(EPOCH_ONE, 0);
    }

    function test_Pop_Fail_AlreadyPoped() public {
        _assertPush(EPOCH_ONE, 0);
        _assertPop(EPOCH_ONE, 0);

        queue.pop();

        require(queue.head == 1);
    }

    function test_Contains_Works_True() public {
        _assertPush(EPOCH_ONE, 0);

        require(queue.contains(EPOCH_ONE));
    }

    function test_Contains_Works_False() public view {
        require(queue.contains(EPOCH_ONE) == false);
    }

    function test_First_Works_SingleEpoch() public {
        _assertPush(EPOCH_ONE, 0);

        require(queue.first() == EPOCH_ONE);
    }

    function test_First_Works_MultipleEpoch() public {
        _assertPush(EPOCH_ONE, 0);
        _assertPush(EPOCH_TWO, 1);

        require(queue.first() == EPOCH_ONE);
    }

    function test_First_Works_SecondEpoch() public {
        _assertPush(EPOCH_ONE, 0);
        _assertPush(EPOCH_TWO, 1);

        _assertPop(EPOCH_ONE, 0);

        require(queue.first() == EPOCH_TWO);
    }

    function test_First_Works_NonExistingEpoch() public view {
        require(queue.first() == 0);
    }

    function _assertPush(uint64 epoch, uint256 index) private {
        uint256 tail = queue.tail;

        queue.push(epoch);

        require(queue.epochs[index] == epoch);
        require(queue.indexes[epoch] == index);
        require(queue.tail == tail + 1);
    }

    function _assertPop(uint64 epoch, uint256 index) private {
        uint256 tail = queue.tail;
        uint256 head = queue.head;

        queue.pop();

        require(queue.epochs[index] == 0);
        require(queue.indexes[epoch] == 0);
        require(queue.tail == tail);
        require(queue.head == head + 1);
    }
}
