// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Checkpoint.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointHelper {
    error CheckpointNotFound(int64 epoch);

    function getPrevCheckpoint(
        mapping(int64 => Checkpoint) storage checkpoints,
        int64 epoch,
        int64 checkPeriod
    ) public view returns (Checkpoint memory) {
        epoch -= checkPeriod;
        while (checkpoints[epoch].signature.length == 0 && epoch > 0) {
            epoch -= checkPeriod;
        }

        return checkpoints[epoch];
    }

    function getCheckpointPerEpoch(
        mapping(int64 => Checkpoint) storage checkpoints,
        uint256 blockNumber,
        int64 checkPeriod
    )
        public
        view
        returns (bool exists, int64 epoch, Checkpoint storage checkpoint)
    {
        epoch = (int64(uint64(blockNumber)) / checkPeriod) * checkPeriod;
        checkpoint = checkpoints[epoch];
        exists =
            keccak256(abi.encode(checkpoint.data.source)) !=
            keccak256(abi.encode(SubnetID({route: new address[](0)})));
    }
}
