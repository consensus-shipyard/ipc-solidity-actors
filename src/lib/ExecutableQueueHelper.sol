// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/ExecutableQueue.sol";

library ExecutableQueueHelper {
    function push(ExecutableQueue storage queue, uint64 epoch) internal {
        if (contains(queue, epoch)) return;

        queue.epochs[queue.tail] = epoch;
        queue.indexes[epoch] = queue.tail;
        queue.tail++;
    }

    function pop(ExecutableQueue storage queue) internal {
        if (queue.head >= queue.tail) return;

        uint64 epoch = queue.epochs[queue.head];

        delete queue.indexes[epoch];
        delete queue.epochs[queue.head];

        queue.head++;
    }

    function contains(
        ExecutableQueue storage queue,
        uint64 epoch
    ) internal view returns (bool) {
        uint256 index = queue.indexes[epoch];

        // epoch cannot be 0
        return epoch > 0 && queue.epochs[index] == epoch;
    }

    function first(
        ExecutableQueue storage queue
    ) internal view returns (uint64) {
        return queue.epochs[queue.head];
    }
}
