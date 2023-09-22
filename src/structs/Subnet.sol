// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {SubnetID} from "./Subnet.sol";
import {FvmAddress} from "./FvmAddress.sol";
import {BottomUpCheckpointLegacy, CrossMsg} from "./Checkpoint.sol";
import {Status} from "../enums/Status.sol";

struct SubnetID {
    /// @notice chainID of the root subnet
    uint64 root;
    /// @notice parent path of the subnet
    address[] route;
}

struct Subnet {
    uint256 stake;
    uint256 genesisEpoch;
    uint256 circSupply;
    uint64 topDownNonce;
    uint64 appliedBottomUpNonce;
    Status status;
    SubnetID id;
    BottomUpCheckpointLegacy prevCheckpoint;
}

// ======== Subnet Staking =======
enum StakingOperation {
    Deposit,
    Withdraw
}

/// The change request to validator staking
struct StakingChange {
    StakingOperation op;
    uint256 amount;
    address validator;
}

/// The collection of staking changes
struct StakingChangeSet {
    /// @notice The next configuration number to assign to new changes.
    uint64 nextConfigurationNumber;
    /// @notice The total number of changes recorded in the set.
    uint64 totalChanges;
    /// The details of the changes, mapping of configuration number to changes.
    mapping(uint64 => StakingChange) changes;
    /// The details of the changes, mapping of validator address to configuration number.
    mapping(address => uint64) validators;
}

/// Each staking release amount and time
struct StakingRelease {
    /// @notice The block number that this fund can be released
    uint256 releaseAt;
    /// @notice The amount that is locked in the release
    uint256 amount;
}

/// Manages the staking release queue
struct StakingReleaseQueue {
    /// @notice The number of blocks that locks the collateral.
    uint256 lockingDuration;
    /// @notice Keeps track of the validators and their releases.
    mapping(address => StakingRelease[]) releases;
}

struct Validator {
    /// The collateral the validator has staked
    uint256 collateral;
    /// The data associated with the validator, i.e. offchain network address.
    /// This information is not important to the protocol, offchain should know how
    /// to parse or decode the bytes.
    bytes data;
}

/// Keeping track of the list of validators. There are two types of validators:
///     - Active
///     - Waiting
/// Active validators are those that are producing blocks in the child subnet.
/// Waiting validators are those that do no have as high collateral as Active validators.
///
/// The max number of active validators is limited by `activeLimit` and the size of waiting
/// validators is not bounded.
///
/// With each validator staking change, waiting validators can be promoted to active validators
/// and active validators can be knocked off.
///
/// @NOTE THAT THE LIST OF ACTIVE VALIDATORS ARE MAINTAINED OFFCHAIN DUE TO GAS CONCERNS!
struct ValidatorSet {
    /// The total number of active validators allowed.
    uint16 activeLimit;
    /// The total number of validators currently in the set.
    uint16 totalValidators;
    /// The mapping of each validator address to its information.
    mapping(address => Validator) validators;
}

struct IPCAddress {
    SubnetID subnetId;
    FvmAddress rawAddress;
}
