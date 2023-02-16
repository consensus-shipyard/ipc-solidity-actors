// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./SubnetId.sol";
import "../enums/ConsensusType.sol";
struct SubnetActorConstructorParams {
    // Parent subnet identifier
    SubnetID parent;

    // Human-readable name for the subnet
    string name;

    address ipcGatewayAddr;

    // @notice Consensus implemented in the subnet
    ConsensusType Consensus;

    /// @notice The minimum stake required to be a validator in this subnet
    uint256 minValidatorStake;

    // @notice The minimum number of validators required for the subnet
    uint64 minValidators;

    uint64 finalityThreshold;

    uint64 checkPeriod;

    uint64 genesis;
}