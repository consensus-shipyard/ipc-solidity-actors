// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/SubnetIDHelper.sol";
import "../structs/Checkpoint.sol";
import "../constants/Constants.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointHelper {
    bytes32 public constant EMPTY_TOP_DOWN_CHECKPOINT_HASH =
        keccak256(
            abi.encode(
                TopDownCheckpoint({
                    epoch: 0,
                    topDownMsgs: new CrossMsg[](0)
                })
            )
        );

    bytes32 public constant EMPTY_BOTTOM_UP_CHECKPOINT_HASH =
        keccak256(
            abi.encode(
                BottomUpCheckpoint({
                    source: SubnetID({
                        route: new address[](0)
                    }),
                    epoch: 0,
                    crossMsgs: new CrossMsg[](0),
                    fee: 0,
                    prevHash: EMPTY_HASH,
                    children: new ChildCheck[](0)
                })
            )
        );

    function toHash(
        BottomUpCheckpoint memory checkpoint
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(checkpoint));
    }

    function toHash(
        TopDownCheckpoint memory checkpoint
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(checkpoint));
    }

    function isSorted(
        BottomUpCheckpoint memory checkpoint
    ) public pure returns (bool) {
        if (checkpoint.crossMsgs.length < 2) return true;
        for (uint i = 1; i < checkpoint.crossMsgs.length; ) {
            if (
                checkpoint.crossMsgs[i].message.nonce <=
                checkpoint.crossMsgs[i - 1].message.nonce
            ) return false;

            unchecked {
                ++i;
            }
        }
        return true;
    }
}
