// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IGateway} from "../interfaces/IGateway.sol";
import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {SubnetID, Subnet} from "../structs/Subnet.sol";
import {BottomUpCheckpoint, CrossMsg} from "../structs/Checkpoint.sol";
import {CrossMsg, BottomUpCheckpoint, TopDownCheckpoint, StorableMsg} from "../structs/Checkpoint.sol";
import {EpochVoteTopDownSubmission} from "../structs/EpochVoteSubmission.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {AccountHelper} from "./AccountHelper.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {EpochVoteSubmission} from "../structs/EpochVoteSubmission.sol";
import {VoteExecutionStatus} from "../enums/VoteExecutionStatus.sol";
import {ExecutableQueueHelper} from "../lib/ExecutableQueueHelper.sol";
import {EpochVoteSubmissionHelper} from "../lib/EpochVoteSubmissionHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {AccountHelper} from "../lib/AccountHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {EpochVoteSubmission} from "../structs/EpochVoteSubmission.sol";
import {VoteExecutionStatus} from "../enums/VoteExecutionStatus.sol";
import {ExecutableQueueHelper} from "../lib/ExecutableQueueHelper.sol";
import {EpochVoteSubmissionHelper} from "../lib/EpochVoteSubmissionHelper.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";

error EmptySubnet();
error NotSystemActor();
error NotSignableAccount();
error NotEnoughFee();
error NotEnoughFunds();
error NotEnoughFundsToRelease();
error CannotReleaseZero();
error NotEnoughBalance();
error NotInitialized();
error NotValidator();
error NotEnoughSubnetCircSupply();
error NotEmptySubnetCircSupply();
error NotRegisteredSubnet();
error AlreadyRegisteredSubnet();
error AlreadyInitialized();
error InconsistentPrevCheckpoint();
error InvalidActorAddress();
error InvalidPostboxOwner();
error InvalidCheckpointEpoch();
error InvalidCheckpointSource();
error InvalidCrossMsgNonce();
error InvalidCrossMsgDestinationSubnet();
error InvalidCrossMsgDestinationAddress();
error InvalidCrossMsgsSortOrder();
error InvalidCrossMsgFromSubnetId();
error InvalidCrossMsgFromRawAddress();
error CannotSendCrossMsgToItself();
error SubnetNotActive();
error PostboxNotExist();
error MessagesNotSorted();
error ValidatorsAndWeightsLengthMismatch();
error ValidatorWeightIsZero();
error NotEnoughFundsForMembership();
error EpochAlreadyExecuted();
error EpochNotVotable();

struct AppStorage {
    /// @notice path to the current network
    SubnetID networkName;
    /// @notice Number of active subnets spawned from this one
    uint64 totalSubnets;
    /// @notice Minimum stake required to create a new subnet
    uint256 minStake;
    /// @notice List of subnets
    /// SubnetID => Subnet
    mapping(bytes32 => Subnet) subnets;
    /// @notice bottom-up period in number of epochs for the subnet
    uint64 bottomUpCheckPeriod;
    /// @notice Postbox keeps track of all the cross-net messages triggered by
    /// an actor that need to be propagated further through the hierarchy.
    /// cross-net message id => CrossMsg
    mapping(bytes32 => CrossMsg) postbox;
    /// @notice cross-net message id => set of owners
    mapping(bytes32 => mapping(address => bool)) postboxHasOwner;
    /// @notice top-down period in number of epochs for the subnet
    uint64 topDownCheckPeriod;
    /// @notice BottomUpCheckpoints in the GW per epoch
    // slither-disable-next-line uninitialized-state
    mapping(uint64 => BottomUpCheckpoint) bottomUpCheckpoints;
    /// @notice nonce for bottom-up messages
    uint64 bottomUpNonce;
    /// @notice AppliedNonces keep track of the next nonce of the message to be applied.
    /// This prevents potential replay attacks.
    uint64 appliedTopDownNonce;
    /// @notice fee amount charged per cross message
    uint256 crossMsgFee;
    /// @notice total votes of all validators
    uint256 totalWeight;
    /// @notice List of validators and how many votes of the total each validator has for top-down messages
    // validatorNonce => validator => weight
    mapping(uint256 => mapping(address => uint256)) validatorSet;
    /// @notice sequence number that uniquely identifies a validator set
    uint256 validatorNonce;
    /// @notice epoch => SubnetID => [childIndex, exists(0 - no, 1 - yes)]
    mapping(uint64 => mapping(bytes32 => uint256[2])) children;
    /// @notice epoch => SubnetID => check => exists
    mapping(uint64 => mapping(bytes32 => mapping(bytes32 => bool))) checks;
    /// @notice whether the contract is initialized
    bool initialized;
    /// @notice contains voted submissions for a given epoch
    // slither-disable-next-line uninitialized-state
    mapping(uint64 => EpochVoteTopDownSubmission) epochVoteSubmissions;
    /// @notice percent approvals needed to reach consensus
    uint8 majorityPercentage;
    /// @notice number of blocks between two checkpoint submissions
    uint64 submissionPeriod;
    /// @notice last executed epoch after voting
    uint64 lastVotingExecutedEpoch;
    /// @notice Initial epoch number
    uint64 genesisEpoch;
    /// @notice Contains the executable epochs that are ready to be executed, but has yet to be executed.
    /// This usually happens when previous submission epoch has not executed, but the next submission
    /// epoch is ready to be executed. Most of the time this should be empty
    ExecutableQueue executableQueue;
}

library LibAppStorage {
    function appStorage() internal pure returns (AppStorage storage ds) {
        assembly {
            ds.slot := 0
        }
    }
}

contract Modifiers {
    // solhint-disable-next-line private-vars-leading-underscore
    AppStorage internal s;

    using FilAddress for address;
    using FilAddress for address payable;
    using AccountHelper for address;
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointHelper for TopDownCheckpoint;
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteTopDownSubmission;
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteSubmission;

    function _validEpochOnly(uint64 epoch) private view {
        if (epoch <= s.lastVotingExecutedEpoch) {
            revert EpochAlreadyExecuted();
        }
        if (epoch > s.genesisEpoch) {
            if ((epoch - s.genesisEpoch) % s.submissionPeriod != 0) {
                revert EpochNotVotable();
            }
        }
    }

    modifier validEpochOnly(uint64 epoch) {
        _validEpochOnly(epoch);
        _;
    }

    function _signableOnly() private view {
        if (!msg.sender.isAccount()) {
            revert NotSignableAccount();
        }
    }

    function _hasFee() private view {
        if (msg.value < s.crossMsgFee) {
            revert NotEnoughFee();
        }
    }

    function _systemActorOnly() private view {
        if (!msg.sender.isSystemActor()) {
            revert NotSystemActor();
        }
    }

    function _onlyValidPostboxOwner(bytes32 msgCid) private view {
        if (!s.postboxHasOwner[msgCid][msg.sender]) {
            revert InvalidPostboxOwner();
        }
    }

    modifier signableOnly() {
        _signableOnly();
        _;
    }

    modifier systemActorOnly() {
        _systemActorOnly();
        _;
    }

    modifier hasFee() {
        _hasFee();
        _;
    }

    modifier onlyValidPostboxOwner(bytes32 msgCid) {
        _onlyValidPostboxOwner(msgCid);
        _;
    }
}
