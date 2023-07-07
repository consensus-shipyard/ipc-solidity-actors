// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ConsensusType} from "../enums/ConsensusType.sol";
import {Status} from "../enums/Status.sol";
import {BottomUpCheckpoint, CrossMsg} from "../structs/Checkpoint.sol";
import {SubnetID} from "../structs/Subnet.sol";
import {EpochVoteSubmission} from "../structs/EpochVoteSubmission.sol";
import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {IGateway} from "../interfaces/IGateway.sol";
import {AccountHelper} from "../lib/AccountHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {ExecutableQueueHelper} from "../lib/ExecutableQueueHelper.sol";
import {EpochVoteBottomUpSubmission} from "../structs/EpochVoteSubmission.sol";
import {EpochVoteSubmissionHelper} from "../lib/EpochVoteSubmissionHelper.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {FvmAddress} from "../structs/FvmAddress.sol";
import {FvmAddressHelper} from "../lib/FvmAddressHelper.sol";

struct SubnetActorStorage {
    /// @notice Total collateral currently deposited in the GW from the subnet
    uint256 totalStake;

    /// @notice Sequence number that uniquely identifies a validator set.
    uint64 configurationNumber;

    /// @notice current status of the subnet
    Status status;

    /// @notice contains the last executed checkpoint hash
    bytes32 prevExecutedCheckpointHash;

    /// @notice contains all committed bottom-up checkpoint at specific epoch
    mapping(uint64 => BottomUpCheckpoint) committedCheckpoints;

    /// @notice List of validators in the subnet
    EnumerableSet.AddressSet validators;

    /// @notice contains voted submissions for a given epoch
    // slither-disable-next-line uninitialized-state
    mapping(uint64 => EpochVoteBottomUpSubmission) epochVoteSubmissions;

    /// @notice validator address to stake amount
    mapping(address => uint256) stake;

    /// @notice validator address to accumulated rewards
    mapping(address => uint256) accumulatedRewards;

    /// @notice validator address to validator net address
    mapping(address => string) validatorNetAddresses;

    /// @notice validator address to validator worker address
    mapping(address => FvmAddress) validatorWorkerAddresses;

    /// @notice ID of the parent subnet
    SubnetID parentId;

    /// @notice genesis block
    bytes genesis;

    /// immutable params

    /// @notice number of blocks in a top-down epoch
    uint64 topDownCheckPeriod;

    /// @notice number of blocks in a bottom-up epoch
    uint64 bottomUpCheckPeriod;

    /// @notice Type of consensus algorithm.
    ConsensusType consensus;

    /// @notice Address of the IPC gateway for the subnet
    address ipcGatewayAddr;

    /// @notice Human-readable name of the subnet.
    bytes32 name;

    // @notice Hash of the current subnet id
    bytes32 currentSubnetHash;

    /// @notice Minimal number of validators required for the subnet to be able to validate new blocks.
    uint64 minValidators;

    uint256 minActivationCollateral;
}

library LibSubnetActorStorage {
    function appStorage() internal pure returns (SubnetActorStorage storage ds) {
        assembly {
            ds.slot := 0
        }
    }
}

contract SubnetActorModifiers {
    // solhint-disable-next-line private-vars-leading-underscore
    SubnetActorStorage internal s;

    using EnumerableSet for EnumerableSet.AddressSet;
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using FilAddress for address;
    using Address for address payable;
    using AccountHelper for address;
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteSubmission;
    using CrossMsgHelper for CrossMsg;
    using FvmAddressHelper for FvmAddress;

    error NotGateway();
    error NotAccount();
    error WorkerAddressInvalid();
    error CollateralIsZero();
    error CallerHasNoStake();
    error CollateralStillLockedInSubnet();
    error SubnetAlreadyKilled();
    error NotAllValidatorsHaveLeft();
    error NotValidator();
    error SubnetNotActive();
    error WrongCheckpointSource();
    error CheckpointNotChained();
    error NoValidatorsInSubnet();
    error NotEnoughBalanceForRewards();
    error MessagesNotSorted();
    error NoRewardToWithdraw();
    error GatewayCannotBeZero();

    function _signableOnly() private view {
        if (!msg.sender.isAccount()) {
            revert NotAccount();
        }
    }

    function _onlyGateway() private view {
        if (msg.sender != s.ipcGatewayAddr) {
            revert NotGateway();
        }
    }

    function _notKilled() private view {
        if (s.status == Status.Killed) {
            revert SubnetAlreadyKilled();
        }
    }

    modifier onlyGateway() {
        _onlyGateway();
        _;
    }

    modifier signableOnly() {
        _signableOnly();
        _;
    }

    modifier notKilled() {
        _notKilled();
        _;
    }
}