// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {ISubnetActor} from "../interfaces/ISubnetActor.sol";
import {GatewayActorStorage, LibGatewayActorStorage} from "../lib/LibGatewayActorStorage.sol";
import {SubnetID, Subnet} from "../structs/Subnet.sol";
import {CrossMsg, BottomUpCheckpoint, ParentFinality} from "../structs/Checkpoint.sol";
import {Membership, Validator} from "../structs/Validator.sol";
import {InvalidConfigurationNumber, NotRegisteredSubnet, InvalidActorAddress, ValidatorWeightIsZero, ValidatorsAndWeightsLengthMismatch, ParentFinalityAlreadyCommitted} from "../errors/IPCErrors.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {CrossMsgHelper} from "../lib/CrossMsgHelper.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {LibVoting} from "../lib/LibVoting.sol";
import {FvmAddress} from "../structs/FvmAddress.sol";
import {FvmAddressHelper} from "./FvmAddressHelper.sol";

library LibGateway {
    using FilAddress for address;
    using FilAddress for address payable;
    using FvmAddressHelper for FvmAddress;
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using CheckpointHelper for BottomUpCheckpoint;

    /// @notice returns the current bottom-up checkpoint
    /// @return exists - whether the checkpoint exists
    /// @return epoch - the epoch of the checkpoint
    /// @return checkpoint - the checkpoint struct
    function getCurrentBottomUpCheckpoint()
        internal
        view
        returns (bool exists, uint64 epoch, BottomUpCheckpoint storage checkpoint)
    {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        epoch = LibVoting.getNextEpoch(block.number, s.bottomUpCheckPeriod);
        checkpoint = s.bottomUpCheckpoints[epoch];
        exists = !checkpoint.source.isEmpty();
    }

    /// @notice obtain the ipc parent finality at certain block number
    /// @param blockNumber - the block number to obtain the finality
    function getParentFinality(uint256 blockNumber) internal view returns (ParentFinality memory) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        return s.finalitiesMap[blockNumber];
    }

    /// @notice obtain the latest committed ipc parent finality
    function getLatestParentFinality() internal view returns (ParentFinality memory) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        return getParentFinality(s.latestParentHeight);
    }

    /// @notice commit the ipc parent finality into storage
    /// @param finality - the finality to be committed
    function commitParentFinality(ParentFinality calldata finality) internal {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();

        if (s.latestParentHeight > finality.height) {
            revert ParentFinalityAlreadyCommitted();
        }
        s.finalitiesMap[finality.height] = finality;
        s.latestParentHeight = finality.height;
    }

    /// @notice set the next membership
    /// @dev It is called by the child subnet when a new configuration is adopted.
    /// @param n - configuration number
    /// @param validators - list of validator addresses
    /// @param weights - list of validators voting powers
    function newMembership(uint64 n, FvmAddress[] memory validators, uint256[] memory weights) internal {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();

        if (validators.length != weights.length) {
            revert ValidatorsAndWeightsLengthMismatch();
        }

        if (n <= s.lastMembership.configurationNumber) {
            return;
        }

        uint256 len = validators.length;
        uint256 totalValidatorsWeight;

        s.lastMembership.configurationNumber = n;
        // clear old validators
        delete s.lastMembership.validators;

        FvmAddress memory zero = FvmAddressHelper.from(address(0));
        for (uint256 i = 0; i < len; ) {
            if (!FvmAddressHelper.equal(validators[i], zero)) {
                uint256 validatorWeight = weights[i];

                if (validatorWeight == 0) {
                    revert ValidatorWeightIsZero();
                }

                s.validatorSetWeights[n][validators[i].toHash()] = validatorWeight;

                s.lastMembership.validators.push(Validator({addr: validators[i], weight: validatorWeight}));

                totalValidatorsWeight += validatorWeight;
            }

            unchecked {
                ++i;
            }
        }
        s.lastMembership.totalWeight = totalValidatorsWeight;
    }

    /// @notice update the membership of the child subnet and returns it
    function updateMembership() internal returns (Membership memory) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        s.currentMembership = s.lastMembership;
        return s.currentMembership;
    }

    /// @notice commit topdown messages for their execution in the subnet. Adds the message to the subnet struct for future execution
    /// @param crossMessage - the cross message to be committed
    function commitTopDownMsg(CrossMsg memory crossMessage) internal {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        SubnetID memory subnetId = crossMessage.message.to.subnetId.down(s.networkName);

        (bool registered, Subnet storage subnet) = getSubnet(subnetId);

        if (!registered) {
            revert NotRegisteredSubnet();
        }

        crossMessage.message.nonce = subnet.topDownNonce;
        subnet.topDownNonce += 1;
        subnet.circSupply += crossMessage.message.value;

        s.topDownMsgs[subnetId.toHash()][block.number].push(crossMessage);
    }

    /// @notice commit bottomup messages for their execution in the subnet. Adds the message to the checkpoint for future execution
    /// @param crossMessage - the cross message to be committed
    function commitBottomUpMsg(CrossMsg memory crossMessage) internal {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        (, , BottomUpCheckpoint storage checkpoint) = getCurrentBottomUpCheckpoint();

        crossMessage.message.nonce = s.bottomUpNonce;

        checkpoint.fee += s.crossMsgFee;
        checkpoint.crossMsgs.push(crossMessage);
        s.bottomUpNonce += 1;
    }

    /// @notice distribute rewards to validators in child subnet
    /// @param to - the address of the target subnet contract
    /// @param amount - the amount of rewards to distribute
    function distributeRewards(address to, uint256 amount) internal {
        if (amount == 0) {
            return;
        }
        // slither-disable-next-line unused-return
        Address.functionCall(to.normalize(), abi.encodeCall(ISubnetActor.reward, amount));
    }

    /// @notice get the list of top down messages from block number, we may also consider introducing pagination.
    /// @param subnetId - The subnet id to fetch messages from
    /// @param fromBlock - The starting block to get top down messages, inclusive.
    /// @param toBlock - The ending block to get top down messages, inclusive.
    function getTopDownMsgs(
        SubnetID calldata subnetId,
        uint256 fromBlock,
        uint256 toBlock
    ) internal view returns (CrossMsg[] memory) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();

        // invalid from block number
        if (fromBlock > toBlock) {
            return new CrossMsg[](0);
        }

        bytes32 subnetHash = subnetId.toHash();
        uint256 msgLength = 0;
        for (uint256 i = fromBlock; i <= toBlock; ) {
            msgLength += s.topDownMsgs[subnetHash][i].length;
            unchecked {
                i++;
            }
        }

        CrossMsg[] memory messages = new CrossMsg[](msgLength);
        uint256 index = 0;
        for (uint256 i = fromBlock; i <= toBlock; ) {
            // perform copy
            for (uint256 j = 0; j < s.topDownMsgs[subnetHash][i].length; ) {
                messages[index] = s.topDownMsgs[subnetHash][i][j];
                unchecked {
                    j++;
                    index++;
                }
            }

            unchecked {
                i++;
            }
        }

        return messages;
    }

    /// @notice returns the subnet created by a validator
    /// @param actor the validator that created the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function getSubnet(address actor) internal view returns (bool found, Subnet storage subnet) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        if (actor == address(0)) {
            revert InvalidActorAddress();
        }
        SubnetID memory subnetId = s.networkName.createSubnetId(actor);

        return getSubnet(subnetId);
    }

    /// @notice returns the subnet with the given id
    /// @param subnetId the id of the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function getSubnet(SubnetID memory subnetId) internal view returns (bool found, Subnet storage subnet) {
        GatewayActorStorage storage s = LibGatewayActorStorage.appStorage();
        subnet = s.subnets[subnetId.toHash()];
        found = !subnet.id.isEmpty();
    }
}
