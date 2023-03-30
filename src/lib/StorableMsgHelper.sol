// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Checkpoint.sol";
import "../constants/Constants.sol";
import "../lib/SubnetIDHelper.sol";
import "../enums/IPCMsgType.sol";

/// @title Helper library for manipulating StorableMsg struct
/// @author LimeChain team
library StorableMsgHelper {
    using SubnetIDHelper for SubnetID;

    bytes32 public constant EMPTY_STORABLE_MESSAGE_HASH =
        keccak256(
            abi.encode(
                StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID(new address[](0)),
                        rawAddress: address(0)
                    }),
                    to: IPCAddress({
                        subnetId: SubnetID(new address[](0)),
                        rawAddress: address(0)
                    }),
                    value: 0,
                    nonce: 0,
                    method: 0,
                    params: bytes("")
                })
            )
        );

    function applyType(
        StorableMsg calldata storableMsg,
        SubnetID calldata curr
    ) public pure returns (IPCMsgType) {
        SubnetID memory sto = storableMsg.to.subnetId;
        SubnetID memory sfrom = storableMsg.from.subnetId;
        if (
            curr.commonParent(sto).equals(sfrom.commonParent(sto)) &&
            ipcType(storableMsg) == IPCMsgType.BottomUp
        ) return IPCMsgType.BottomUp;

        return IPCMsgType.TopDown;
    }

    function ipcType(
        StorableMsg calldata storableMsg
    ) public pure returns (IPCMsgType) {
        SubnetID memory sto = storableMsg.to.subnetId;
        SubnetID memory sfrom = storableMsg.from.subnetId;

        return sfrom.isBottomUp(sto) ? IPCMsgType.BottomUp : IPCMsgType.TopDown;
    }

    function toHash(
        StorableMsg calldata storableMsg
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(storableMsg));
    }
}
