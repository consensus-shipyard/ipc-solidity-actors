// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/SubnetIDHelper.sol";
import "../structs/Checkpoint.sol";
import "../constants/Constants.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointHelper {
    bytes32 constant EMPTY_TOPDOWNCHECKPOINT_HASH =
        keccak256(
            abi.encode(
                TopDownCheckpoint({epoch: 0, topDownMsgs: new CrossMsg[](0)})
            )
        );

    function toHash(
        BottomUpCheckpoint memory bottomupCheckpoint
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(bottomupCheckpoint));
    }

    function toHash(
        TopDownCheckpoint memory topdownCheckpoint
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(topdownCheckpoint));
    }

    function isEmpty(
        TopDownCheckpoint memory topdownCheckpoint
    ) public pure returns (bool) {
        return toHash(topdownCheckpoint) == EMPTY_TOPDOWNCHECKPOINT_HASH;
    }
}
