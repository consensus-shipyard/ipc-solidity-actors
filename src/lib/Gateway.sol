// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IGateway} from "../interfaces/IGateway.sol";
import {AppStorage, LibAppStorage} from "../lib/AppStorage.sol";
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

library LibGateway {
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

    /// @notice returns the current bottom-up checkpoint
    /// @return exists - whether the checkpoint exists
    /// @return epoch - the epoch of the checkpoint
    /// @return checkpoint - the checkpoint struct
    function _getCurrentBottomUpCheckpoint()
        internal
        view
        returns (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint)
    {
        AppStorage storage s = LibAppStorage.appStorage();
        epoch = _getNextEpoch(block.number, s.bottomUpCheckPeriod);
        checkpoint = s.bottomUpCheckpoints[epoch];
        exists = !checkpoint.source.isEmpty();
    }

    /// @notice commit topdown messages for their execution in the subnet. Adds the message to the subnet struct for future execution
    /// @param crossMessage - the cross message to be committed
    function _commitTopDownMsg(CrossMsg memory crossMessage) internal {
        AppStorage storage s = LibAppStorage.appStorage();
        SubnetID memory subnetId = crossMessage.message.to.subnetId.down(s.networkName);

        (bool registered, Subnet storage subnet) = _getSubnet(subnetId);

        if (!registered) {
            revert NotRegisteredSubnet();
        }

        crossMessage.message.nonce = subnet.topDownNonce;
        subnet.topDownNonce += 1;
        subnet.circSupply += crossMessage.message.value;
        subnet.topDownMsgs.push(crossMessage);
    }

    /// @notice commit bottomup messages for their execution in the subnet. Adds the message to the checkpoint for future execution
    /// @param crossMessage - the cross message to be committed
    function _commitBottomUpMsg(CrossMsg memory crossMessage) internal {
        AppStorage storage s = LibAppStorage.appStorage();
        (, , BottomUpCheckpoint storage checkpoint) = _getCurrentBottomUpCheckpoint();

        crossMessage.message.nonce = s.bottomUpNonce;

        checkpoint.fee += s.crossMsgFee;
        checkpoint.crossMsgs.push(crossMessage);
        s.bottomUpNonce += 1;
    }

    /// @notice distribute rewards to validators in child subnet
    /// @param to - the address of the target subnet contract
    /// @param amount - the amount of rewards to distribute
    function _distributeRewards(address to, uint256 amount) internal {
        if (amount == 0) {
            return;
        }
        // slither-disable-next-line unused-return
        Address.functionCall(to.normalize(), abi.encodeWithSelector(ISubnetActor.reward.selector, amount));
    }

    /// @notice returns the subnet created by a validator
    /// @param actor the validator that created the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function _getSubnet(address actor) internal view returns (bool found, Subnet storage subnet) {
        AppStorage storage s = LibAppStorage.appStorage();
        if (actor == address(0)) {
            revert InvalidActorAddress();
        }
        SubnetID memory subnetId = s.networkName.createSubnetId(actor);

        return _getSubnet(subnetId);
    }

    /// @notice returns the subnet with the given id
    /// @param subnetId the id of the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function _getSubnet(SubnetID memory subnetId) internal view returns (bool found, Subnet storage subnet) {
        AppStorage storage s = LibAppStorage.appStorage();
        subnet = s.subnets[subnetId.toHash()];
        found = !subnet.id.isEmpty();
    }

    /// @notice method that gives the epoch for a given block number and checkpoint period
    /// @return epoch - the epoch for the given block number and checkpoint period
    function _getNextEpoch(uint256 blockNumber, uint64 checkPeriod) internal pure returns (uint64) {
        return ((uint64(blockNumber) / checkPeriod) + 1) * checkPeriod;
    }

    /// @notice method that returns the genesis epoch
    /// @return epoch - the genesis epoch
    function getGenesisEpoch() public view returns (uint64) {
        AppStorage storage s = LibAppStorage.appStorage();
        return s.genesisEpoch;
    }

    function _validEpochOnly(uint64 epoch) private view {
        AppStorage storage s = LibAppStorage.appStorage();
        if (epoch <= s.lastVotingExecutedEpoch) {
            revert EpochAlreadyExecuted();
        }
        if (epoch > s.genesisEpoch) {
            if ((epoch - s.genesisEpoch) % s.submissionPeriod != 0) {
                revert EpochNotVotable();
            }
        }
    }

    /// @notice minimum checkpoint period. Values get clamped to this
    uint8 public constant MIN_CHECKPOINT_PERIOD = 10;

    error InvalidMajorityPercentage();
    error ValidatorAlreadyVoted();

    /// @notice returns the current checkpoint execution status based on the current vote
    /// @param vote - the vote submission data
    /// @param totalWeight - the total voting power of the validators
    function _deriveExecutionStatus(
        EpochVoteSubmission storage vote,
        uint256 totalWeight
    ) internal view returns (VoteExecutionStatus) {
        AppStorage storage s = LibAppStorage.appStorage();
        uint256 threshold = (totalWeight * s.majorityPercentage) / 100;
        uint256 mostVotedWeight = vote.getMostVotedWeight();

        // threshold not reached, require THRESHOLD to be surpassed, equality is not enough!
        if (vote.totalSubmissionWeight <= threshold) {
            return VoteExecutionStatus.ThresholdNotReached;
        }

        // consensus reached
        if (mostVotedWeight > threshold) {
            return VoteExecutionStatus.ConsensusReached;
        }

        // now the total submissions has reached the threshold, but the most submitted vote
        // has yet to reach the threshold, that means consensus has not reached.
        // we do a early termination check, to see if consensus will ever be reached.
        //
        // consider an example that consensus will never be reached:
        //
        // -------- | -------------------------|--------------- | ------------- |
        //     MOST_VOTED                 THRESHOLD     TOTAL_SUBMISSIONS  TOTAL_WEIGHT
        //
        // we see MOST_VOTED is smaller than THRESHOLD, TOTAL_SUBMISSIONS and TOTAL_WEIGHT, if
        // the potential extra votes any vote can obtain, i.e. TOTAL_WEIGHT - TOTAL_SUBMISSIONS,
        // is smaller than or equal to the potential extra vote the most voted can obtain, i.e.
        // THRESHOLD - MOST_VOTED, then consensus will never be reached, no point voting, just abort.
        if (threshold - mostVotedWeight >= totalWeight - vote.totalSubmissionWeight) {
            return VoteExecutionStatus.RoundAbort;
        }

        // TODO: we are never reaching here in tests
        return VoteExecutionStatus.ReachingConsensus;
    }

    /// @notice marks a checkpoint for a given epoch as executed
    /// @param epoch - the epoch to mark as executed
    function _markSubmissionExecuted(uint64 epoch) internal {
        AppStorage storage s = LibAppStorage.appStorage();
        // epoch not the next executable epoch
        if (!_isNextExecutableEpoch(epoch)) {
            return;
        }

        // epoch not the next executable epoch in the queue
        if (s.executableQueue.contains(epoch)) {
            if (s.executableQueue.first != epoch) {
                return;
            }
        }

        // remove from the queue if it exists
        s.executableQueue.remove(epoch);

        // update the last executed epoch
        s.lastVotingExecutedEpoch = epoch;
    }

    /// @notice method that checks if the given epoch is the next executable epoch
    /// @param epoch - the epoch to check
    /// @return whether the given epoch is the next executable epoch
    function _isNextExecutableEpoch(uint64 epoch) internal view returns (bool) {
        AppStorage storage s = LibAppStorage.appStorage();
        return epoch == s.lastVotingExecutedEpoch + s.submissionPeriod;
    }

    /// @notice method that returns the next executable epoch
    /// @return nextEpoch - the next executable epoch
    /// @return isExecutable - whether the next epoch is executable
    function _getNextExecutableEpoch() internal view returns (uint64 nextEpoch, bool isExecutable) {
        AppStorage storage s = LibAppStorage.appStorage();
        nextEpoch = s.executableQueue.first;
        isExecutable = _isNextExecutableEpoch(nextEpoch);
    }

    /// @notice method that submits a vote for a given epoch
    /// @param vote - the vote submission data
    /// @param submissionHash - the hash of the submission
    /// @param submitterAddress - the address of the submitter
    /// @param submitterWeight - the voting power of the submitter
    /// @param epoch - the epoch of the vote
    /// @param totalWeight - the total voting power of the validators
    /// @return shouldExecuteVote - whether the vote should be executed
    function _submitVote(
        EpochVoteSubmission storage vote,
        bytes32 submissionHash,
        address submitterAddress,
        uint256 submitterWeight,
        uint64 epoch,
        uint256 totalWeight
    ) internal returns (bool shouldExecuteVote) {
        AppStorage storage s = LibAppStorage.appStorage();
        uint256 nonce = vote.nonce;
        if (vote.submitters[nonce][submitterAddress]) {
            revert ValidatorAlreadyVoted();
        }

        vote.submitters[nonce][submitterAddress] = true;
        vote.totalSubmissionWeight += submitterWeight;
        vote.submissionWeights[nonce][submissionHash] += submitterWeight;

        uint256 mostVotedWeight = vote.submissionWeights[nonce][vote.mostVotedSubmission];
        uint256 currVotedWeight = vote.submissionWeights[nonce][submissionHash];

        if (mostVotedWeight < currVotedWeight) {
            vote.mostVotedSubmission = submissionHash;
        }

        VoteExecutionStatus status = _deriveExecutionStatus(vote, totalWeight);

        if (status == VoteExecutionStatus.ConsensusReached) {
            if (_isNextExecutableEpoch(epoch)) {
                shouldExecuteVote = true;
            } else {
                // there are pending epochs to be executed, just store the submission and skip execution
                s.executableQueue.push(epoch);
            }
        } else if (status == VoteExecutionStatus.RoundAbort) {
            // abort the current round and reset the submission data.
            vote.reset();
        }
    }
}
