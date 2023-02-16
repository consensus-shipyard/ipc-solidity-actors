// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./SubnetId.sol";

struct Checkpoint {
    CheckData data;
    bytes signature;
}

struct CheckData {
    SubnetID source;
    bytes tipSet;
    uint64 epoch;
    Checkpoint[] prevCheck;
    Checkpoint[] children;
    CrossMsgMeta crossMsgs;
}

struct CrossMsgMeta {
    CrossMsg msgsCid;
    uint64 nonce;
    uint256 value;
    uint256 fee; 
}

struct CrossMsg {
    StorableMsg msg;
    bool wrapped;
}

struct StorableMsg {
    IPCAddress from;
    IPCAddress to;
    uint64 method;
    bytes params;
    uint256 value;
    uint64 nonce;
}

struct IPCAddress {
    SubnetID subnetId;
    address rawAddress;
}