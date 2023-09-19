// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {SubnetID} from "./Subnet.sol";
import {FvmAddress} from "./FvmAddress.sol";
import {BottomUpCheckpoint, CrossMsg} from "./Checkpoint.sol";
import {Status} from "../enums/Status.sol";

struct SubnetID {
    /// @notice chainID of the root subnet
    uint64 root;
    /// @notice parent path of the subnet
    address[] route;
}

/// @notice All the information about a validator
struct Validator {
    address validator;
    uint256 weight;
    /// @notice The extra info about the validator. This information is not
    /// @notice important for the contract, but useful for offchain computation.
    /// @dev Offchain should know how to decode these bytes, contract does not
    /// @dev need to know about the details.
    bytes info;
}

/// @notice All the information about a validator
struct ValidatorChange {
    Validator validator;
    uint64 configurationNumber;
    SubnetOpt operation;
}

/// The operations that validators can perform for the subnet lifecycle
enum SubnetOpt {
    Join,
    Leave
}

struct Subnet {
    uint256 stake;
    uint256 genesisEpoch;
    uint256 circSupply;
    uint64 topDownNonce;
    uint64 appliedBottomUpNonce;
    Status status;
    SubnetID id;
    BottomUpCheckpoint prevCheckpoint;
}

struct IPCAddress {
    SubnetID subnetId;
    FvmAddress rawAddress;
}
