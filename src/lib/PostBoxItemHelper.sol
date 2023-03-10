// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "../structs/Postbox.sol";

library PostBoxItemHelper {
    using EnumerableSet for EnumerableSet.AddressSet;

    function toHash(
        PostBoxItem storage postBoxItem
    ) public view returns (bytes32) {

        return
            keccak256(
                abi.encodePacked(
                    postBoxItem.crossMsg.message.from.subnetId.route,
                    postBoxItem.crossMsg.message.from.rawAddress,
                    postBoxItem.crossMsg.message.to.subnetId.route,
                    postBoxItem.crossMsg.message.to.rawAddress,
                    postBoxItem.crossMsg.message.value,
                    postBoxItem.crossMsg.message.nonce,
                    postBoxItem.crossMsg.message.method,
                    postBoxItem.crossMsg.message.params,
                    postBoxItem.crossMsg.wrapped,
                    postBoxItem.owners.values(),
                    postBoxItem.hasOwners
                )
            );
            // keccak256(
            //     abi.encodePacked(
            //         abi.encode(postBoxItem.crossMsg),
            //         postBoxItem.owners.values(),
            //         postBoxItem.hasOwners
            //     )
            // );
    }
}
