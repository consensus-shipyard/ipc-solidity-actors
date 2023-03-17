// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Checkpoint.sol";
import "../constants/Constants.sol";
import "../lib/SubnetIDHelper.sol";

/// @title Helper library for manipulating StorableMsg struct
/// @author LimeChain team
library StorableMsgHelper {
    using SubnetIDHelper for SubnetID;

    function newReleaseMsg(
        SubnetID calldata subnet,
        address signer,
        uint256 value,
        uint64 nonce
    ) public pure returns (StorableMsg memory) {
        return
            StorableMsg({
                from: IPCAddress({
                    subnetId: subnet,
                    rawAddress: BURNT_FUNDS_ACTOR
                }),
                to: IPCAddress({
                    subnetId: subnet.getParentSubnet(),
                    rawAddress: signer
                }),
                value: value,
                nonce: nonce,
                method: 0,
                params: bytes("")
            });
    }

    function newFundMsg(
        SubnetID calldata subnet,
        address signer,
        uint256 value
    ) public pure returns (StorableMsg memory) {
        require(
            subnet.route.length >= 1,
            "error getting parent for subnet addr"
        );

        SubnetID memory parent = subnet.getParentSubnet();

        return
            StorableMsg({
                from: IPCAddress({subnetId: parent, rawAddress: signer}),
                to: IPCAddress({subnetId: subnet, rawAddress: signer}),
                value: value,
                nonce: 0,
                method: 0,
                params: bytes("")
            });
    }
}
