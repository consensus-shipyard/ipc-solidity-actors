// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/SubnetIDHelper.sol";
<<<<<<< HEAD
import "../lib/CheckpointHelper.sol";
=======
>>>>>>> 177836e (feat: add toHash() function to CP & SubetID structs, fix condition in cross msg in GW, refactor join method and tests, fix interfaces)
import "../structs/Checkpoint.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointMappingHelper {
    using SubnetIDHelper for SubnetID;
<<<<<<< HEAD
    using CheckpointHelper for Checkpoint;

    bytes32 private constant EMPTY_SUBNET_HASH =
        keccak256(abi.encode(SubnetID(new address[](0))));

    function getPrevCheckpointHash(
        mapping(int64 => Checkpoint) storage checkpoints,
        int64 epoch,
        int64 checkPeriod
    ) public view returns (bytes32) {
=======

    function getPrevCheckpoint(
        mapping(int64 => Checkpoint) storage checkpoints,
        int64 epoch,
        int64 checkPeriod
    ) public view returns (Checkpoint memory) {
>>>>>>> 177836e (feat: add toHash() function to CP & SubetID structs, fix condition in cross msg in GW, refactor join method and tests, fix interfaces)
        epoch -= checkPeriod;
        while (checkpoints[epoch].signature.length == 0 && epoch > 0) {
            epoch -= checkPeriod;
        }

<<<<<<< HEAD
        return checkpoints[epoch].toHash();
=======
        return checkpoints[epoch];
>>>>>>> 177836e (feat: add toHash() function to CP & SubetID structs, fix condition in cross msg in GW, refactor join method and tests, fix interfaces)
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
<<<<<<< HEAD
        exists = checkpoint.data.source.toHash() != EMPTY_SUBNET_HASH;
=======
        exists =
            checkpoint.data.source.toHash() !=
            SubnetID(new address[](0)).toHash();
>>>>>>> 177836e (feat: add toHash() function to CP & SubetID structs, fix condition in cross msg in GW, refactor join method and tests, fix interfaces)
    }
}
