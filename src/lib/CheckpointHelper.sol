// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {BottomUpCheckpoint, CrossMsg} from "../structs/Checkpoint.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointHelper {
    function toHash(BottomUpCheckpoint memory bottomupCheckpoint) public pure returns (bytes32) {
        return keccak256(abi.encode(bottomupCheckpoint));
    }
}
