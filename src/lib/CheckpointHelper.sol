// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/SubnetIDHelper.sol";
import "../structs/Checkpoint.sol";

/// @title Helper library for manipulating Checkpoint struct
/// @author LimeChain team
library CheckpointHelper {
    function toHash(
        Checkpoint memory checkpoint
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(checkpoint.data));
    }

    function hasCrossMsgMeta(
        Checkpoint memory checkpoint
    ) public pure returns (bool) {
        return
            keccak256(abi.encode(checkpoint.data.crossMsgs)) !=
            keccak256(
                abi.encode(
                    CrossMsgMeta({
                        nonce: 0,
                        value: 0,
                        fee: 0,
                        msgs: new CrossMsg[](0)
                    })
                )
            );
    }
}
