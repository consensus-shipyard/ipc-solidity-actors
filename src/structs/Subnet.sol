// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./Checkpoint.sol";
import "../enums/Status.sol";

struct SubnetID {
    /// @notice parent path of the subnet
    string parent;
    /// @notice deployed subnet actor address
    address actor;
}

struct Subnet {
    SubnetID id;
    uint256 stake;
    CrossMsg[] topDownMsgs;
    uint256 nonce;
    uint256 circSupply;
    Status status;
    Checkpoint prevCheckpoint;
}
