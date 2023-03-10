// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./Checkpoint.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";

/// @title Postbox struct and related structs
/// @author LimeChain team
struct PostBoxItem {
    CrossMsg crossMsg;
    EnumerableSet.AddressSet owners;
    bool hasOwners;
}
