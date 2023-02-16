// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./SubnetId.sol";
import "../enums/ConsensusType.sol";
struct SubnetActorConstructorParams {
    /// @notice Parent subnet identifier
    SubnetID parent;

    /// @notice Human-readable name for the subnet
    string name;

    /// @notice the address of the parent SCA
    address ipcGatewayAddr;

    /// @notice Consensus implemented in the subnet
    ConsensusType consensus;

    /// @notice The minimum stake required to be a validator in this subnet
    uint256 minValidatorStake;

    /// @notice The minimum number of validators required for the subnet
    uint64 minValidators;

    /// @notice number of blocks after which finality is reached
    uint64 finalityThreshold;

    /// @notice number of blocks between two checkpoints
    uint64 checkPeriod;

    /// @notice genesis block number
    uint64 genesis;
}