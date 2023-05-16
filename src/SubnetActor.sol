// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./Voting.sol";
import "./enums/ConsensusType.sol";
import "./enums/Status.sol";
import "./enums/VoteExecutionStatus.sol";
import "./structs/Checkpoint.sol";
import "./structs/Subnet.sol";
import "./interfaces/ISubnetActor.sol";
import "./interfaces/IGateway.sol";
import "./lib/AccountHelper.sol";
import "./lib/CheckpointHelper.sol";
import "./lib/SubnetIDHelper.sol";
import "./lib/ExecutableQueueHelper.sol";
import "./lib/EpochVoteSubmissionHelper.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/utils/Address.sol";

/// @title Subnet Actor Contract
/// @author LimeChain team
contract SubnetActor is ISubnetActor, ReentrancyGuard, Voting {
    using EnumerableSet for EnumerableSet.AddressSet;
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using FilAddress for address;
    using Address for address payable;
    using AccountHelper for address;
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteSubmission;

    uint256 private constant MIN_COLLATERAL_AMOUNT = 1 ether;

    /// @notice Human-readable name of the subnet.
    string public name;

    /// @notice ID of the parent subnet
    SubnetID private parentId;

    /// @notice Address of the IPC gateway for the subnet
    address public ipcGatewayAddr;

    /// @notice Type of consensus algorithm.
    ConsensusType public consensus;

    /// @notice The minimum collateral required to be a validator in this subnet
    uint256 public minActivationCollateral;

    /// @notice Total collateral currently deposited in the GW from the subnet
    uint256 public totalStake;

    /// @notice validator address to stake amount
    mapping(address => uint256) public stake;

    /// @notice current status of the subnet
    Status public status;

    /// @notice genesis block
    bytes public genesis;

    /// @notice number of blocks in a top-down epoch
    uint64 public topDownCheckPeriod;

    /// @notice number of blocks in a bottom-up epoch
    uint64 public bottomUpCheckPeriod;

    /// @notice contains all committed bottom-up checkpoint at specific epoch
    mapping(uint64 => BottomUpCheckpoint) public committedCheckpoints;

    /// @notice List of validators in the subnet
    EnumerableSet.AddressSet private validators;

    /// @notice Minimal number of validators required for the subnet to be able to validate new blocks.
    uint64 public minValidators;
    
    /// @notice contains the last executed checkpoint hash
    bytes32 public prevExecutedCheckpointHash;

    /// @notice contains voted submissions for a given epoch 
    mapping(uint64 => EpochVoteBottomUpSubmission) private epochVoteSubmissions;

    error NotGateway();
    error NotAccount();
    error CollateralIsZero();
    error CallerHasNoStake();
    error CollateralStillLockedInSubnet();
    error SubnetAlreadyTerminating();
    error NotAllValidatorsHaveLeft();
    error NotValidator();
    error SubnetNotActive();
    error WrongCheckpointSource();
    error CheckpointNotChained();
    error NoRewardsSentForDistribution();
    error NoValidatorsInSubnet();
    error NotEnoughBalanceForRewards();

    modifier onlyGateway() {
        if(msg.sender != ipcGatewayAddr) revert NotGateway();
        _;
    }

    modifier signableOnly() {
        if(!msg.sender.isAccount()) revert NotAccount();
        _;
    }

    modifier mutateState() {
        _;
        if (
            status == Status.Instantiated &&
            totalStake >= minActivationCollateral
        ) {
            status = Status.Active;
        } else if (
            status == Status.Active && totalStake < minActivationCollateral
        ) {
            status = Status.Inactive;
        } else if (
            status == Status.Inactive && totalStake >= minActivationCollateral
        ) {
            status = Status.Active;
        } else if (status == Status.Terminating && totalStake == 0) {
            status = Status.Killed;
        }
    }

    struct ConstructParams {
        SubnetID parentId;
        string name;
        address ipcGatewayAddr;
        ConsensusType consensus;
        uint256 minActivationCollateral;
        uint64 minValidators;
        uint64 bottomUpCheckPeriod;
        uint64 topDownCheckPeriod;
        uint8 majorityPercentage;
        bytes genesis;
    }

    constructor(ConstructParams memory params) Voting(params.majorityPercentage, params.bottomUpCheckPeriod) {
        parentId = params.parentId;
        name = params.name;
        ipcGatewayAddr = params.ipcGatewayAddr;
        consensus = params.consensus;
        minActivationCollateral = params.minActivationCollateral <
            MIN_COLLATERAL_AMOUNT
            ? MIN_COLLATERAL_AMOUNT
            : params.minActivationCollateral;
        minValidators = params.minValidators;
        topDownCheckPeriod = params.topDownCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.topDownCheckPeriod;
        bottomUpCheckPeriod = submissionPeriod;
        status = Status.Instantiated;
        genesis = params.genesis;
        // NOTE: we currently use 0 as the genesisEpoch for subnets so checkpoints
        // are submitted directly from epoch 0.
        // In the future we can use the current epoch. This will be really
        // useful once we support the docking of subnets to new parents, etc.
        genesisEpoch = 0;
    }

    receive() external payable onlyGateway {}

    function join() external payable signableOnly mutateState {
        if(status == Status.Terminating && status != Status.Killed) revert SubnetAlreadyTerminating();
        if(msg.value == 0) revert CollateralIsZero();
        
        stake[msg.sender] += msg.value;
        totalStake += msg.value;

        if (
            stake[msg.sender] >= minActivationCollateral &&
            !validators.contains(msg.sender) &&
            (consensus != ConsensusType.Delegated || validators.length() == 0)
        ) {
            validators.add(msg.sender);
        }

        if (status == Status.Instantiated) {
            if (totalStake >= minActivationCollateral) {
                IGateway(ipcGatewayAddr).register{value: totalStake}();
            }
        } else {
            IGateway(ipcGatewayAddr).addStake{value: msg.value}();
        }
    }

    function leave() external mutateState nonReentrant signableOnly {
        if(status == Status.Terminating && status != Status.Killed) revert SubnetAlreadyTerminating();
        if(stake[msg.sender] == 0) revert CallerHasNoStake();
        
        uint256 amount = stake[msg.sender];

        stake[msg.sender] = 0;
        totalStake -= amount;
        validators.remove(msg.sender);

        IGateway(ipcGatewayAddr).releaseStake(amount);

        payable(msg.sender).sendValue(amount);
    }

    function kill() external signableOnly mutateState {
        if(address(this).balance > 0) revert CollateralStillLockedInSubnet();
        if(status == Status.Terminating && status != Status.Killed) revert SubnetAlreadyTerminating();
        if(validators.length() != 0 || totalStake != 0) revert NotAllValidatorsHaveLeft();

        status = Status.Terminating;

        IGateway(ipcGatewayAddr).kill();
    }

    function submitCheckpoint(
        BottomUpCheckpoint calldata checkpoint
    ) external signableOnly validEpochOnly(checkpoint.epoch) {
        if(!validators.contains(msg.sender)) revert NotValidator();
        if(status != Status.Active) revert SubnetNotActive();
        if(checkpoint.source.toHash() != parentId.createSubnetId(address(this)).toHash()) revert WrongCheckpointSource();

        // the epoch being submitted is the next executable epoch, we perform a check to ensure
        // the checkpoints are chained. This is an early termination check to ensure the checkpoints
        // are actually chained.
        if(_isNextExecutableEpoch(checkpoint.epoch) && prevExecutedCheckpointHash != checkpoint.prevHash) revert CheckpointNotChained();
    
        EpochVoteBottomUpSubmission storage voteSubmission = epochVoteSubmissions[checkpoint.epoch];

        // submit the vote
        bool shouldExecuteVote = _submitBottomUpVote(voteSubmission, checkpoint, msg.sender, stake[msg.sender]);
        bool isCommited;

        BottomUpCheckpoint storage submissionToExecute;

        if (shouldExecuteVote) {
            submissionToExecute = _getMostVotedSubmission(voteSubmission);
            isCommited = _commitCheckpoint(voteSubmission.vote, submissionToExecute);
        } else {
            // try to get the next executable epoch from the queue
            (uint64 nextExecutableEpoch, bool isExecutableEpoch) = _getNextExecutableEpoch();

            if (isExecutableEpoch) {
                EpochVoteBottomUpSubmission storage nextVoteSubmission = epochVoteSubmissions[nextExecutableEpoch];

                submissionToExecute  = _getMostVotedSubmission(nextVoteSubmission);
                isCommited = _commitCheckpoint(nextVoteSubmission.vote, submissionToExecute);
            }
        }

        if (isCommited) {
            IGateway(ipcGatewayAddr).commitChildCheck(checkpoint);
        }
    }

    /// Distributes the rewards for the subnet to validators.
    function reward() public payable onlyGateway nonReentrant {
        uint validatorLength = validators.length();
        if(msg.value == 0) revert NoRewardsSentForDistribution();
        if(validatorLength == 0) revert NoValidatorsInSubnet();
        if(address(this).balance < validatorLength) revert NotEnoughBalanceForRewards();

        uint rewardAmount = address(this).balance / validatorLength;

        for (uint i = 0; i < validatorLength; ) {
            payable(validators.at(i)).sendValue(rewardAmount);
            unchecked {
                ++i;
            }
        }
    }

    function getParent() external view returns (SubnetID memory) {
        return parentId;
    }

    function validatorCount() external view returns (uint) {
        return validators.length();
    }

    function validatorAt(uint index) external view returns (address) {
        return validators.at(index);
    }

    function hasValidatorVotedForSubmission(uint64 epoch, address submitter) external view returns(bool) {
        EpochVoteBottomUpSubmission storage voteSubmission = epochVoteSubmissions[epoch];

        return voteSubmission.vote.submitters[voteSubmission.vote.nonce][submitter];
    }

    function _submitBottomUpVote(
        EpochVoteBottomUpSubmission storage voteSubmission,
        BottomUpCheckpoint calldata submission,
        address submitterAddress,
        uint256 submitterWeight
    ) internal returns (bool shouldExecuteVote) {
        bytes32 submissionHash = submission.toHash();
        
        shouldExecuteVote = _submitVote(voteSubmission.vote, submissionHash, submitterAddress, submitterWeight, submission.epoch, totalStake);

        // store the submission only the first time
        if (voteSubmission.submissions[submissionHash].isEmpty()) {
            voteSubmission.submissions[submissionHash] = submission;
        }
    }

    function _getMostVotedSubmission(EpochVoteBottomUpSubmission storage voteSubmission) internal view returns(BottomUpCheckpoint storage){
        return voteSubmission.submissions[voteSubmission.vote.mostVotedSubmission];
    }

    function _commitCheckpoint(EpochVoteSubmission storage vote, BottomUpCheckpoint storage checkpoint) internal returns(bool committed) {
        if (checkpoint.isEmpty()) {
            return false;
        }

        /// Ensures the checkpoints are chained. If not, should abort the current checkpoint.
        if (prevExecutedCheckpointHash != checkpoint.prevHash) {
            vote.reset();
            executableQueue.remove(checkpoint.epoch);

            return false;
        }

        _markSubmissionExecuted(checkpoint.epoch);

        committedCheckpoints[checkpoint.epoch] = checkpoint;
        prevExecutedCheckpointHash = checkpoint.toHash();

        return true;
    }
}
