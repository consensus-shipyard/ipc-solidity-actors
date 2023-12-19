// Automatically generated from `foundry-cheatcodes` Vm definitions. Do not modify manually.
// This interface is just for internal testing purposes. Use `forge-std` instead.

// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.19;

interface VmTryFfi {
    function tryFfi(string[] calldata commandInput) external returns (FfiResult memory result);

    struct FfiResult {
        int32 exitCode;
        bytes stdout;
        bytes stderr;
    }
}
