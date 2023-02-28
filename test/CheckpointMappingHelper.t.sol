// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";

import "../src/structs/Checkpoint.sol";
import "../src/structs/Subnet.sol";
import "../src/lib/SubnetIDHelper.sol";
import "../src/lib/CheckpointHelper.sol";
import "../src/lib/CheckpointMappingHelper.sol";

contract CheckpointMappingHelperTest is Test {
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointMappingHelper for mapping(uint64 => BottomUpCheckpoint);

    uint64 constant BLOCKS_PER_EPOCH = 10;

    uint64 constant EPOCH_ONE = 0 * BLOCKS_PER_EPOCH;
    uint64 constant EPOCH_TWO = 1 * BLOCKS_PER_EPOCH;
    uint64 constant EPOCH_THREE = 2 * BLOCKS_PER_EPOCH;
    uint64 constant NON_EXISTING_EPOCH = 100000;

    mapping(uint64 => BottomUpCheckpoint) public checkpoints;

    function test_GetCheckpointPerEpoch_Works_SameEpochNextBlock() public {
        createCheckpoint(EPOCH_ONE, 5);

        (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint) = checkpoints
            .getCheckpointPerEpoch(8, BLOCKS_PER_EPOCH);

        require(exists);
        require(epoch == EPOCH_ONE);
        require(checkpoint.toHash() == checkpoints[EPOCH_ONE].toHash());
    }

    function test_GetCheckpointPerEpoch_Works_SameEpochPreviousBlock() public {
        createCheckpoint(EPOCH_ONE, 5);

        (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint) = checkpoints
            .getCheckpointPerEpoch(3, BLOCKS_PER_EPOCH);

        require(exists);
        require(epoch == EPOCH_ONE);
        require(checkpoint.toHash() == checkpoints[EPOCH_ONE].toHash());
    }

    function test_GetCheckpointPerEpoch_Works_EpochTwo() public {
        createCheckpoint(EPOCH_ONE, 5);
        createCheckpoint(EPOCH_TWO, 12);

        (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint) = checkpoints
            .getCheckpointPerEpoch(12, BLOCKS_PER_EPOCH);

        require(exists);
        require(epoch == EPOCH_TWO);
        require(checkpoint.toHash() == checkpoints[EPOCH_TWO].toHash());
    }

    function test_GetCheckpointPerEpoch_Works_FutureEpoch(
        uint64 futureEpoch
    ) public {
        vm.assume(
            futureEpoch > EPOCH_THREE && futureEpoch % BLOCKS_PER_EPOCH == 0
        );

        createCheckpoint(EPOCH_ONE, 5);
        createCheckpoint(EPOCH_TWO, 15);

        for (
            uint nextBlock = 0;
            nextBlock < BLOCKS_PER_EPOCH;
            nextBlock++
        ) {
            uint256 futureBlockNumber = futureEpoch + nextBlock;

            (bool exists, uint64 epoch, ) = checkpoints.getCheckpointPerEpoch(
                futureBlockNumber,
                BLOCKS_PER_EPOCH
            );

            require(exists == false);
            require(epoch == futureEpoch);
        }
    }

    function createCheckpoint(
        uint64 epoch,
        uint64 blockNumber
    ) internal returns (BottomUpCheckpoint storage cp) {
        cp = checkpoints[epoch];

        address[] memory route = new address[](1);
        route[0] = makeAddr("root");

        cp.source = SubnetID(route).createSubnetId(address(100));
        cp.epoch = blockNumber;
    }
}
