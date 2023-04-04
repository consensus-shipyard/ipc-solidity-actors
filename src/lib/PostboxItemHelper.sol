// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Postbox.sol";
import "../structs/Checkpoint.sol";

library PostboxItemHelper {

    function createItem(CrossMsg calldata crossMsg) internal pure returns(PostboxItem memory) {
        address[] memory owners = new address[](1);
        owners[0] = crossMsg.message.from.rawAddress;

        return PostboxItem(crossMsg, owners);
    }

    function toHash(PostboxItem memory postboxItem) internal pure returns(bytes32) {
        return keccak256(abi.encode(postboxItem));
    }
}