// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./enums/ConsensusType.sol";
import "./enums/Status.sol";
import "./structs/Checkpoint.sol";
import "./structs/Subnet.sol";
import "./interfaces/ISubnetActor.sol";
import "./interfaces/IGateway.sol";
import "./lib/CheckpointMappingHelper.sol";
import "./lib/AccountHelper.sol";
import "./lib/CheckpointHelper.sol";
import "./lib/SubnetIDHelper.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/utils/Address.sol";

/// @title Subnet Actor Contract
/// @author LimeChain team
contract SubnetActor is ISubnetActor, ReentrancyGuard {
    using EnumerableSet for EnumerableSet.AddressSet;
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointMappingHelper for mapping(int64 => BottomUpCheckpoint);
    using FilAddress for address;
    using Address for address payable;
    using AccountHelper for address;

    uint256 private constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 private constant MIN_CHECKPOINT_PERIOD = 10;

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
    /// @notice number of blocks between two bottom-up checkpoints
    uint64 public bottomUpCheckPeriod;
    /// @notice number of blocks between two top-down checkpoints
    uint64 public topDownCheckPeriod;
    /// @notice epoch of creation
    uint64 public genesisEpoch;
    /// @notice block number to corresponding bottom-up checkpoint at that block
    mapping(uint64 => BottomUpCheckpoint) public checkpoints;
    /// @notice List of validators in the subnet
    EnumerableSet.AddressSet private validators;
    /// @notice Minimal number of validators required for the subnet to be able to validate new blocks.
    uint64 public minValidators;

    /// @notice percentage of voters needed for majority
    uint8 public majorityPercentage;

    /// @notice last executed checkpoint epoch. Used as nonce
    uint64 lastVotingExecutedEpoch;

    /// @notice number of tokens(votes) for the checkpoint commit hash
    mapping(bytes32 => uint256) private commitVoteAmount;

    /// @notice commit hash -> EOA address -> have they voted yet?
    mapping(bytes32 => mapping(address => bool))
        public hasValidatorVotedForCommit;

    modifier onlyGateway() {
        require(
            msg.sender == ipcGatewayAddr,
            "only the IPC gateway can call this function"
        );
        _;
    }

    modifier signableOnly() {
        require(msg.sender.isAccount(), "the caller is not an account");
        _;
    }

    modifier mutateState() {
        _;
        if (status == Status.Instantiated && totalStake >= minActivationCollateral) {
            status = Status.Active;
        } else if (status == Status.Active && totalStake < minActivationCollateral) {
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
        uint64 currentEpoch;
        bytes genesis;
    }

    constructor(ConstructParams memory params) {
        require(
            params.majorityPercentage <= 100,
            "majorityPercentage must be <= 100"
        );
        parentId = params.parentId;
        name = params.name;
        ipcGatewayAddr = params.ipcGatewayAddr;
        consensus = params.consensus;
        minActivationCollateral = params.minActivationCollateral < MIN_COLLATERAL_AMOUNT
            ? MIN_COLLATERAL_AMOUNT
            : params.minActivationCollateral;
        minValidators = params.minValidators;
        bottomUpCheckPeriod = params.bottomUpCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.bottomUpCheckPeriod;
        topDownCheckPeriod = params.topDownCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.topDownCheckPeriod;
        genesis = params.genesis;
        genesisEpoch = params.currentEpoch;
        majorityPercentage = params.majorityPercentage;
        status = Status.Instantiated;
    }

    receive() external payable onlyGateway {}

    function join() external payable mutateState signableOnly {
        require(
            msg.value > 0,
            "a minimum collateral is required to join the subnet"
        );

        stake[msg.sender] += msg.value;
        totalStake += msg.value;
        if (
            stake[msg.sender] >= minActivationCollateral &&
            !validators.contains(msg.sender) &&
            (consensus != ConsensusType.Delegated || validators.length() == 0)
        ) validators.add(msg.sender);

        if (status == Status.Instantiated) {
            if (totalStake >= minActivationCollateral) {
                payable(ipcGatewayAddr).functionCallWithValue(
                    abi.encodeWithSignature("register()"),
                    totalStake
                );
            }
        } else {
            payable(ipcGatewayAddr).functionCallWithValue(
                abi.encodeWithSignature("addStake()"),
                msg.value
            );
        }
    }

    function leave() external mutateState nonReentrant signableOnly {
        require(stake[msg.sender] != 0, "caller has no stake in subnet");

        uint256 amount = stake[msg.sender];

        stake[msg.sender] = 0;
        totalStake -= amount;
        validators.remove(msg.sender);

        if (status == Status.Terminating) return;

        IGateway(ipcGatewayAddr).releaseStake(amount);

        payable(msg.sender).sendValue(amount);
    }

    function kill() external mutateState signableOnly {
        require(
            address(this).balance == 0,
            "there is still collateral in the subnet"
        );
        require(
            status != Status.Terminating && status != Status.Killed,
            "the subnet is already in a killed or terminating state"
        );
        require(
            validators.length() == 0 && totalStake == 0,
            "this subnet can only be killed when all validators have left"
        );

        status = Status.Terminating;

        IGateway(ipcGatewayAddr).kill();
    }

    function submitCheckpoint(
        BottomUpCheckpoint calldata checkpoint
    ) external signableOnly {
        require(validators.contains(msg.sender), "not validator");
        require(
            status == Status.Active,
            "submitting checkpoints is not allowed while subnet is not active"
        );
        require(
            lastVotingExecutedEpoch + bottomUpCheckPeriod == checkpoint.epoch,
            "epoch in checkpoint doesn't correspond with a signing window"
        );
        require(
            checkpoint.source.toHash() ==
                parentId.createSubnetId(address(this)).toHash(),
            "submitting checkpoint with the wrong source"
        );

        bytes32 commitHash = checkpoint.toHash();
        require(
            !hasValidatorVotedForCommit[commitHash][msg.sender],
            "validator has already voted the checkpoint"
        );

        hasValidatorVotedForCommit[commitHash][msg.sender] = true;

        commitVoteAmount[commitHash] += stake[msg.sender];

        bool hasMajority = commitVoteAmount[commitHash] * 100 >
            totalStake * majorityPercentage;

        if (hasMajority == false) return;

        // store the commitment on vote majority
        checkpoints[checkpoint.epoch] = checkpoint;

        lastVotingExecutedEpoch = checkpoint.epoch;

        IGateway(ipcGatewayAddr).commitChildCheck(checkpoint);
    }

    function reward() public payable onlyGateway nonReentrant {
        uint validatorLength = validators.length();
        require(validatorLength != 0, "no validators in subnet");

        require(
            address(this).balance >= validatorLength,
            "we need to distribute at least one wei to each validator"
        );

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
}
