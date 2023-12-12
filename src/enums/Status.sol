// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.23;

/// @title Subnet Status enum
/// @author LimeChain team
enum Status {
    Unset,
    Active,
    Inactive,
    Killed,
    Terminating,
    Instantiated
}
