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

    function applyType(StorableMsg calldata storableMsg, SubnetID calldata curr)
        public
        pure
        returns (IPCMsgType)
    {
        if (
            curr.commonParent(storableMsg.to.subnetId).equals(
                storableMsg.from.subnetId.commonParent(storableMsg.to.subnetId)
            ) && ipcType(storableMsg) == IPCMsgType.BottomUp
        ) return IPCMsgType.BottomUp;

        return IPCMsgType.TopDown;
    }

    function ipcType(StorableMsg calldata storableMsg)
        public
        pure
        returns (IPCMsgType)
    {
        return
            storableMsg.from.subnetId.isBottomUp(storableMsg.to.subnetId)
                ? IPCMsgType.BottomUp
                : IPCMsgType.TopDown;
    }
}
