// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./Subnet.sol";

struct Checkpoint {
    CheckData data;
    bytes signature;
}

struct CheckData {
    SubnetID source;
    bytes tipSet;
    uint64 epoch;
    bytes prevCheck;
    Checkpoint[] children;
    CrossMsgMeta crossMsgs;
}

struct CrossMsgMeta {
    CrossMsg msgsCid;
    uint256 nonce;
    uint256 value;
    uint256 fee;
}

struct CrossMsg {
    StorableMsg msg;
    bool wrapped;
}

struct CrossMsgs {
    CrossMsg[] msgs;
}

struct StorableMsg {
    IPCAddress from;
    IPCAddress to;
    uint256 value;
    uint256 nonce;
    uint64 method;
    bytes params;
}

struct IPCAddress {
    SubnetID subnetId;
    address rawAddress;
}
