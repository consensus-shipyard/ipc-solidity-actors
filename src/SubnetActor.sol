// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./enums/ConsensusType.sol";
import "./enums/Status.sol";
import "./structs/Checkpoint.sol";
import "./structs/Subnet.sol";
import "./structs/Validator.sol";

contract SubnetActor {
    /// @notice Human-readable name of the subnet.
    string public name;
    /// @notice ID of the parent subnet
    SubnetID public parentId;
    /// @notice Address of the IPC gateway for the subnet
    address public ipcGatewayAddr;
    /// @notice Type of consensus algorithm.
    ConsensusType public consensus;
    /// @notice The minimum stake required to be a validator in this subnet
    uint256 public minValidatorStake;
    /// @notice Total collateral currently deposited in the SCA from the subnet
    uint256 public totalStake;
    /// @notice validator address to stake amount
    mapping(address => uint256) public stake;
    /// @notice current status of the subnet
    Status public status;
    /// @notice genesis block number
    uint64 public genesis;
    /// @notice number of blocks after which finality is reached
    uint64 public finalityThreshold;
    /// @notice number of blocks between two checkpoints
    uint64 public checkPeriod;
    /// @notice block number to corresponding checkpoint at that block
    mapping(uint64 => Checkpoint) public checkpoints;
    /// @notice CID to Votes (list of validators)
    mapping(bytes => address[]) windowChecks;
    /// @notice List of validators in the subnet
    Validator[] public validatorSet;
    /// @notice Minimal number of validators required for the subnet
    // to be able to validate new blocks.
    uint64 public minValidators;

    constructor(SubnetID memory _parentId, string memory _name, address _ipcGatewayAddr, ConsensusType _consensus, uint256 _minValidatorStake, uint64 _minValidators, uint64 _finalityThreshold, uint64 _checkPeriod, uint64 _genesis) {
        parentId = _parentId;
        name = _name;
        ipcGatewayAddr = _ipcGatewayAddr;
        consensus = _consensus;
        minValidatorStake = _minValidatorStake;
        minValidators = _minValidators;
        finalityThreshold = _finalityThreshold;
        checkPeriod = _checkPeriod;
        genesis = _genesis;
    }
}
