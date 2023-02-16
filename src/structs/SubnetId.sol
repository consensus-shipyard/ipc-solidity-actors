// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

struct SubnetID {
    /// @notice parent path of the subnet
    string parent;

    /// @notice deployed subnet actor address
    address actor;
}