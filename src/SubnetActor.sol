// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./interfaces/ISubnetActor.sol";
import "./enums/ConsensusType.sol";
import "./enums/Status.sol";
import "./structs/Checkpoint.sol";
import "./structs/SubnetId.sol";
import "./structs/Validator.sol";
import "./structs/SubnetActorConstructorParams.sol";

import "./structs/SubnetActorConstructorParams.sol";

contract SubnetActor {
    /// @notice Human-readable name of the subnet.
    string private name;
    /// @notice ID of the parent subnet
    SubnetID private parentId;
    /// @notice Address of the IPC gateway for the subnet
    address private ipcGatewayAddr;
    /// @notice Type of consensus algorithm.
    ConsensusType private Consensus;
    /// @notice The minimum stake required to be a validator in this subnet
    uint256 private minValidatorStake;
    /// @notice Total collateral currently deposited in the SCA from the subnet
    uint256 private totalStake;
    /// @notice validator address to stake amount
    mapping (address => uint256) private stake;
    /// @notice current status of the subnet
    Status private status;
    /// @notice genesis block number
    uint64 private genesis;
    /// @notice number of blocks after which finality is reached
    uint64 private finalityThreshold;
    /// @notice number of blocks between two checkpoints
    uint64 private checkPeriod;
    /// @notice block number to corresponding checkpoint at that block
    mapping(uint64 => Checkpoint) private checkpoints;
    /// @notice CID to Votes (list of validators)
    mapping(bytes => address[]) windowChecks;
    /// @notice List of validators in the subnet
    Validator[] private validatorSet;
    /// @notice Minimal number of validators required for the subnet
    // to be able to validate new blocks.
    uint64 private minValidators;

    constructor(SubnetActorConstructorParams memory params) {
        
    }
}