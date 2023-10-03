// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {Status} from "../enums/Status.sol";
import {CollateralIsZero, EmptyAddress, MessagesNotSorted, NotEnoughBalanceForRewards, NoValidatorsInSubnet, NotValidator, NotAllValidatorsHaveLeft, SubnetNotActive, WrongCheckpointSource, NoRewardToWithdraw, NotStakedBefore, InconsistentPrevCheckpoint, InvalidSignatureErr, InvalidCheckpointMessagesHash, InvalidCheckpointEpoch, HeightAlreadyExecuted} from "../errors/IPCErrors.sol";
import {IGateway} from "../interfaces/IGateway.sol";
import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {BottomUpCheckpoint, CrossMsg} from "../structs/Checkpoint.sol";
import {FvmAddress} from "../structs/FvmAddress.sol";
import {SubnetID, Validator, ValidatorSet} from "../structs/Subnet.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {MultisignatureChecker} from "../lib/LibMultisignatureChecker.sol";
import {FvmAddressHelper} from "../lib/FvmAddressHelper.sol";
import {ReentrancyGuard} from "../lib/LibReentrancyGuard.sol";
import {SubnetActorModifiers} from "../lib/LibSubnetActorStorage.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {LibValidatorSet, LibStaking} from "../lib/LibStaking.sol";
import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";

contract SubnetActorManagerFacet is ISubnetActor, SubnetActorModifiers, ReentrancyGuard {
    using EnumerableSet for EnumerableSet.AddressSet;
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using LibValidatorSet for ValidatorSet;
    using FilAddress for address;
    using Address for address payable;
    using FvmAddressHelper for FvmAddress;

    event BottomUpCheckpointSubmitted(BottomUpCheckpoint checkpoint, address submitter);
    event BottomUpCheckpointExecuted(uint64 epoch, address submitter);
    event NextBottomUpCheckpointExecuted(uint64 epoch, address submitter);

    /// @notice method that allows a validator to join the subnet
    /// @param netAddr - the network address of the validator
    function join(string calldata netAddr, FvmAddress calldata workerAddr) external payable notKilled {
        uint256 validatorStake = msg.value;
        address validator = msg.sender;
        if (validatorStake == 0) {
            revert CollateralIsZero();
        }

        s.stake[validator] += validatorStake;
        s.totalStake += validatorStake;

        if (s.stake[validator] >= s.minActivationCollateral) {
            if (!s.validators.contains(validator)) {
                // slither-disable-next-line unused-return
                s.validators.add(validator);
                s.validatorNetAddresses[validator] = netAddr;
                s.validatorWorkerAddresses[validator] = workerAddr;
            }
        }

        if (s.status == Status.Instantiated) {
            if (s.totalStake >= s.minActivationCollateral) {
                s.status = Status.Active;
                IGateway(s.ipcGatewayAddr).register{value: s.totalStake}();
            }
        } else {
            if (s.status == Status.Inactive) {
                if (s.totalStake >= s.minActivationCollateral) {
                    s.status = Status.Active;
                }
            }
            IGateway(s.ipcGatewayAddr).addStake{value: validatorStake}();
        }
    }

    /// @notice method that allows a validator to leave the subnet
    function leave() external nonReentrant notKilled {
        uint256 amount = s.stake[msg.sender];

        if (amount == 0) {
            revert NotValidator();
        }

        s.stake[msg.sender] = 0;
        s.totalStake -= amount;
        // slither-disable-next-line unused-return
        s.validators.remove(msg.sender);
        if (s.status == Status.Active) {
            if (s.totalStake < s.minActivationCollateral) {
                s.status = Status.Inactive;
            }
        }

        IGateway(s.ipcGatewayAddr).releaseStake(amount);

        payable(msg.sender).sendValue(amount);
    }

    /// @notice method that allows to kill the subnet when all validators left. It is not a privileged operation.
    function kill() external notKilled {
        if (s.validators.length() != 0 || s.totalStake != 0) {
            revert NotAllValidatorsHaveLeft();
        }

        s.status = Status.Killed;

        IGateway(s.ipcGatewayAddr).kill();
    }

    /// @notice method that distributes the rewards for the subnet to validators.
    function reward(uint256 amount) external onlyGateway {
        uint256 validatorsLength = s.validators.length();

        if (validatorsLength == 0) {
            revert NoValidatorsInSubnet();
        }
        if (amount < validatorsLength) {
            revert NotEnoughBalanceForRewards();
        }

        uint256 rewardAmount = amount / validatorsLength;

        for (uint256 i = 0; i < validatorsLength; ) {
            s.accumulatedRewards[s.validators.at(i)] += rewardAmount;
            unchecked {
                ++i;
            }
        }
    }

    /// @notice method that allows a validator to withdraw it's accumulated rewards using pull-based transfer
    function withdraw() external {
        uint256 amount = s.accumulatedRewards[msg.sender];

        if (amount == 0) {
            revert NoRewardToWithdraw();
        }

        s.accumulatedRewards[msg.sender] = 0;

        IGateway(s.ipcGatewayAddr).releaseRewards(amount);

        payable(msg.sender).sendValue(amount);
    }

    function setValidatorNetAddr(string calldata newNetAddr) external {
        address validator = msg.sender;
        if (!s.validators.contains(validator)) {
            revert NotValidator();
        }
        if (bytes(newNetAddr).length == 0) {
            revert EmptyAddress();
        }
        s.validatorNetAddresses[validator] = newNetAddr;
    }

    function setValidatorWorkerAddr(FvmAddress calldata newWorkerAddr) external {
        address validator = msg.sender;
        if (!s.validators.contains(validator)) {
            revert NotValidator();
        }
        s.validatorWorkerAddresses[validator] = newWorkerAddr;
    }

    /// @notice Executes the checkpoint if it is valid.
    /// @param signatories The addresses of the signatories.
    /// @param checkpoint The executed bottom-up checkpoint
    /// @param signatures The collected checkpoint signatures
    /// @param messages The list of executed cross-messages
    function submitCheckpoint(
        address[] calldata signatories,
        BottomUpCheckpoint calldata checkpoint,
        bytes calldata signatures,
        CrossMsg[] calldata messages
    ) external {
        if (checkpoint.blockHeight <= s.lastBottomUpCheckpointExecutedHeight) {
            revert HeightAlreadyExecuted();
        }
        if (checkpoint.blockHeight % s.bottomUpCheckPeriod != 0) {
            revert InvalidCheckpointEpoch();
        }
        if (s.status != Status.Active) {
            revert SubnetNotActive();
        }
        if (!s.validatorSet.isActiveValidator(msg.sender)) {
            revert NotValidator();
        }

        bytes32 msgHash = keccak256(abi.encode(messages));
        if (msgHash != checkpoint.crossMessagesHash) {
            revert InvalidCheckpointMessagesHash();
        }

        bytes32 checkpointHash = keccak256(abi.encode(checkpoint));

        validateCheckpoint({signatories: signatories, checkpointHash: checkpointHash, signatures: signatures});

        _commitBottomUpCheckpoint({checkpoint: checkpoint});
    }

    /// @notice method that commits a checkpoint after its validation and reaching majority
    /// @param checkpoint - the batch messages data
    function _commitBottomUpCheckpoint(BottomUpCheckpoint calldata checkpoint) internal {
        s.committedCheckpoints[checkpoint.blockHeight] = checkpoint;
        // TODO: remove this line and prevExecutedCheckpointHash ?
        s.prevExecutedCheckpointHash = checkpoint.toHash();

        IGateway(s.ipcGatewayAddr).commitBottomUpCheckpoint(checkpoint);
    }

    /// @notice Get the information of a validator
    function getValidator(address validatorAddress) external view returns (Validator memory validator) {
        if (!LibStaking.hasStaked(msg.sender)) {
            revert NotStakedBefore();
        }
        validator = s.validatorSet.validators[validatorAddress];
    }

    /// @notice Set the data of a validator
    function setMetadata(bytes calldata metadata) external {
        if (!LibStaking.hasStaked(msg.sender)) {
            revert NotStakedBefore();
        }
        LibStaking.setValidatorData(msg.sender, metadata);
    }

    /// @notice method that allows a validator to join the subnet
    /// @param data The offchain data that should be associated with the validator
    function join2(bytes calldata data) external payable notKilled {
        if (msg.value == 0) {
            revert CollateralIsZero();
        }

        LibStaking.setValidatorData(msg.sender, data);
        LibStaking.deposit(msg.sender, msg.value);
    }

    /// @notice method that allows a validator to increase their stake
    function stake() external payable notKilled {
        if (msg.value == 0) {
            revert CollateralIsZero();
        }

        if (!LibStaking.hasStaked(msg.sender)) {
            revert NotStakedBefore();
        }

        LibStaking.deposit(msg.sender, msg.value);
    }

    /// @notice method that allows a validator to leave the subnet
    function leave2() external notKilled {
        uint256 amount = LibStaking.totalValidatorCollateral(msg.sender);
        if (amount == 0) {
            revert NotValidator();
        }

        LibStaking.withdraw(msg.sender, amount);
    }

    /// @notice method that allows to kill the subnet when all validators left. It is not a privileged operation.
    function kill2() external notKilled {
        if (LibStaking.totalValidators() != 0) {
            revert NotAllValidatorsHaveLeft();
        }

        s.status = Status.Killed;

        IGateway(s.ipcGatewayAddr).kill();
    }

    /// @notice Valdiator claims their released collateral
    function claim() external nonReentrant notKilled {
        LibStaking.claimCollateral(msg.sender);
    }

    /**
     * @notice Checks whether the checkpoint is valid for the provided signatories, signatures and hash. Reverts otherwise.
     * @dev Signatories in `signatories` and their signatures in `signatures` must be provided in the same order.
     * @param signatories The addresses of the signatories.
     * @param hash The hash of the checkpoint.
     * @param signatures The packed signatures of the checkpoint.
     */
    // TODO: should it be public or internal?
    function validateCheckpoint(address[] memory signatories, bytes32 hash, bytes memory signatures) public view {
        uint256[] memory collaterals = s.validatorSet.getConfirmedCollaterals(signatories);

        uint256 threshold = (s.validatorSet.totalConfirmedCollateral * s.majorityPercentage) / 100;

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature({
            signatories: signatories,
            weights: collaterals,
            threshold: threshold,
            hash: hash,
            signatures: signatures
        });

        if (!valid) {
            revert InvalidSignatureErr(uint8(err));
        }
    }
}
