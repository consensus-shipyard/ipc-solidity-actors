// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

/// @title Subnet Status enum
/// @author LimeChain team
enum Status {
    Instantiated,
    Active,
    Inactive,
    Terminating,
    Killed
}