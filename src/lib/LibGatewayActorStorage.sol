// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {VoteExecutionStatus} from "../enums/VoteExecutionStatus.sol";
import {IGateway} from "../interfaces/IGateway.sol";
import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {EpochVoteTopDownSubmission, EpochVoteSubmission} from "../structs/EpochVoteSubmission.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {BottomUpCheckpoint, CrossMsg, TopDownCheckpoint, StorableMsg} from "../structs/Checkpoint.sol";
import {SubnetID, Subnet} from "../structs/Subnet.sol";
import {AccountHelper} from "../lib/AccountHelper.sol";
import {EpochVoteSubmissionHelper} from "../lib/EpochVoteSubmissionHelper.sol";
import {ExecutableQueueHelper} from "../lib/ExecutableQueueHelper.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";

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

struct GatewayActorStorage {
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
}

library LibGatewayActorStorage {
    function appStorage() internal pure returns (GatewayActorStorage storage ds) {
        assembly {
            ds.slot := 0
        }
    }
}

contract GatewayActorModifiers {
    GatewayActorStorage internal s;

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
