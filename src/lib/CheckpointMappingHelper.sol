// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/SubnetIDHelper.sol";
import "../lib/CheckpointHelper.sol";
import "../structs/Checkpoint.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointMappingHelper {
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;

    bytes32 private constant EMPTY_SUBNET_HASH =
        keccak256(abi.encode(SubnetID(new address[](0))));

    function getCheckpointPerEpoch(
        mapping(uint64 => BottomUpCheckpoint) storage checkpoints,
        uint256 blockNumber,
        uint64 checkPeriod
    )
        public
        view
        returns (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint)
    {
        epoch = (uint64(blockNumber) / checkPeriod) * checkPeriod;
        checkpoint = checkpoints[epoch];
        exists = checkpoint.source.toHash() != EMPTY_SUBNET_HASH;
    }
}
