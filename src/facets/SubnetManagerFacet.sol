pragma solidity 0.8.19;

import "../lib/AppStorage.sol";
import {EMPTY_HASH, BURNT_FUNDS_ACTOR, METHOD_SEND} from "../constants/Constants.sol";
import {Voting} from "../Voting.sol";
import {CrossMsg, BottomUpCheckpoint, TopDownCheckpoint, StorableMsg} from "../structs/Checkpoint.sol";
import {EpochVoteTopDownSubmission} from "../structs/EpochVoteSubmission.sol";
import {Status} from "../enums/Status.sol";
import {IPCMsgType} from "../enums/IPCMsgType.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {IGateway} from "../interfaces/IGateway.sol";
import {LibGateway} from "../lib/Gateway.sol";
import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {SubnetID, Subnet} from "../structs/Subnet.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {AccountHelper} from "../lib/AccountHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {StorableMsgHelper} from "../lib/StorableMsgHelper.sol";
import {ExecutableQueueHelper} from "../lib/ExecutableQueueHelper.sol";
import {EpochVoteSubmissionHelper} from "../lib/EpochVoteSubmissionHelper.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/security/ReentrancyGuard.sol";
import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import {EnumerableMap} from "openzeppelin-contracts/utils/structs/EnumerableMap.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";

contract SubnetManagerFacet is Modifiers, ReentrancyGuard {
    using FilAddress for address;
    using FilAddress for address payable;
    using AccountHelper for address;
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointHelper for TopDownCheckpoint;
    using StorableMsgHelper for StorableMsg;
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteTopDownSubmission;

    /// @notice initialize the contract with the genesis epoch
    /// @param genesisEpoch - genesis epoch to set
    function initGenesisEpoch(uint64 genesisEpoch) external systemActorOnly {
        if (s.initialized) {
            revert AlreadyInitialized();
        }

        s.genesisEpoch = genesisEpoch;
        s.initialized = true;
    }

    /// @notice register a subnet in the gateway. called by a subnet when it reaches the threshold stake
    function register() external payable {
        if (msg.value < s.minStake) {
            revert NotEnoughFunds();
        }

        SubnetID memory subnetId = s.networkName.createSubnetId(msg.sender);

        (bool registered, Subnet storage subnet) = LibGateway._getSubnet(subnetId);

        if (registered) {
            revert AlreadyRegisteredSubnet();
        }

        subnet.id = subnetId;
        subnet.stake = msg.value;
        subnet.status = Status.Active;
        subnet.genesisEpoch = block.number;
        s.totalSubnets += 1;
    }

    /// @notice addStake - add collateral for an existing subnet
    function addStake() external payable {
        if (msg.value <= 0) {
            revert NotEnoughFunds();
        }

        (bool registered, Subnet storage subnet) = LibGateway._getSubnet(msg.sender);

        if (!registered) {
            revert NotRegisteredSubnet();
        }

        subnet.stake += msg.value;

        if (subnet.status == Status.Inactive) {
            if (subnet.stake >= s.minStake) {
                subnet.status = Status.Active;
            }
        }
    }

    /// @notice release collateral for an existing subnet
    function releaseStake(uint256 amount) external nonReentrant {
        if (amount == 0) {
            revert CannotReleaseZero();
        }

        (bool registered, Subnet storage subnet) = LibGateway._getSubnet(msg.sender);

        if (!registered) {
            revert NotRegisteredSubnet();
        }
        if (subnet.stake < amount) {
            revert NotEnoughFundsToRelease();
        }

        subnet.stake -= amount;

        if (subnet.stake < s.minStake) {
            subnet.status = Status.Inactive;
        }

        payable(subnet.id.getActor()).sendValue(amount);
    }

    function releaseRewards(uint256 amount) external nonReentrant {
        if (amount == 0) {
            revert CannotReleaseZero();
        }

        (bool registered, Subnet storage subnet) = LibGateway._getSubnet(msg.sender);
        if (!registered) {
            revert NotRegisteredSubnet();
        }

        payable(subnet.id.getActor()).sendValue(amount);
    }

    /// @notice kill an existing subnet. It's balance must be empty
    function kill() external {
        (bool registered, Subnet storage subnet) = LibGateway._getSubnet(msg.sender);

        if (!registered) {
            revert NotRegisteredSubnet();
        }
        if (subnet.circSupply > 0) {
            revert NotEmptySubnetCircSupply();
        }

        uint256 stake = subnet.stake;

        s.totalSubnets -= 1;

        delete s.subnets[subnet.id.toHash()];

        payable(msg.sender).sendValue(stake);
    }

    /// @notice fund - commit a top-down message releasing funds in a child subnet. There is an associated fee that gets distributed to validators in the subnet as well
    /// @param subnetId - subnet to fund
    function fund(SubnetID calldata subnetId) external payable signableOnly hasFee {
        CrossMsg memory crossMsg = CrossMsgHelper.createFundMsg(subnetId, msg.sender, msg.value - s.crossMsgFee);

        // commit top-down message.
        LibGateway._commitTopDownMsg(crossMsg);

        LibGateway._distributeRewards(subnetId.getActor(), s.crossMsgFee);
    }

    /// @notice release method locks funds in the current subnet and sends a cross message up the hierarchy to the parent gateway to release the funds
    function release() external payable signableOnly hasFee {
        CrossMsg memory crossMsg = CrossMsgHelper.createReleaseMsg(
            s.networkName,
            msg.sender,
            msg.value - s.crossMsgFee
        );

        LibGateway._commitBottomUpMsg(crossMsg);
    }

    /// @notice set up the top-down validators and their voting power
    /// @param validators - list of validator addresses
    /// @param weights - list of validators voting powers
    function setMembership(address[] memory validators, uint256[] memory weights) external systemActorOnly {
        if (validators.length != weights.length) {
            revert ValidatorsAndWeightsLengthMismatch();
        }
        // invalidate the previous validator set
        ++s.validatorNonce;

        uint256 totalValidatorsWeight = 0;

        // setup the new validator set
        uint256 validatorsLength = validators.length;
        for (uint256 validatorIndex = 0; validatorIndex < validatorsLength; ) {
            address validatorAddress = validators[validatorIndex];
            if (validatorAddress != address(0)) {
                uint256 validatorWeight = weights[validatorIndex];

                if (validatorWeight == 0) {
                    revert ValidatorWeightIsZero();
                }

                s.validatorSet[s.validatorNonce][validatorAddress] = validatorWeight;

                totalValidatorsWeight += validatorWeight;
            }

            // initial validators need to be conveniently funded with at least
            // 1 FIL for them to be able to commit the first few top-down messages.
            // They should use this FIL to fund their own addresses in the subnet
            // so they can keep committing top-down messages. If they don't do this,
            // they won't be able to send cross-net messages in their subnet.
            // Funds are only distributed in child subnets, where top-down checkpoints need
            // to be committed. This doesn't apply to the root.
            // TODO: Once account abstraction is conveniently supported, there will be
            // no need for this initial funding of validators.
            // if (block.number == 1 && !_networkName.isRoot())
            //     payable(validatorAddress).sendValue(INITIAL_VALIDATOR_FUNDS);

            unchecked {
                ++validatorIndex;
            }
        }
        s.totalWeight = totalValidatorsWeight;
    }
}
