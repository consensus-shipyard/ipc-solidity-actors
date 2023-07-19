// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Status} from "../enums/Status.sol";
import {CrossMsg, BottomUpCheckpoint, StorableMsg, ChildCheck} from "../structs/Checkpoint.sol";
import {EpochVoteTopDownSubmission} from "../structs/EpochVoteSubmission.sol";
import {SubnetID, Subnet} from "../structs/Subnet.sol";
import {NotRegisteredSubnet} from "../errors/IPCErrors.sol";
import {CheckpointHelper} from "../lib/CheckpointHelper.sol";
import {LibGateway} from "../lib/LibGateway.sol";
import {GatewayActorStorage} from "../lib/LibGatewayActorStorage.sol";
import {LibVoting} from "../lib/LibVoting.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";

contract GatewayGetterFacet {
    // slither-disable-next-line uninitialized-state
    GatewayActorStorage internal s;

    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;

    function crossMsgFee() external view returns (uint256) {
        return s.crossMsgFee;
    }

    function bottomUpNonce() external view returns (uint64) {
        return s.bottomUpNonce;
    }

    function totalSubnets() external view returns (uint64) {
        return s.totalSubnets;
    }

    function minStake() external view returns (uint256) {
        return s.minStake;
    }

    function initialized() external view returns (bool) {
        return s.initialized;
    }

    function bottomUpCheckPeriod() external view returns (uint64) {
        return s.bottomUpCheckPeriod;
    }

    function topDownCheckPeriod() external view returns (uint64) {
        return s.topDownCheckPeriod;
    }

    function getNetworkName() external view returns (SubnetID memory) {
        return s.networkName;
    }

    function bottomUpCheckpoints(uint64 e) external view returns (BottomUpCheckpoint memory) {
        return s.bottomUpCheckpoints[e];
    }

    /// @notice returns the subnet with the given id
    /// @param subnetId the id of the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function getSubnet(SubnetID calldata subnetId) external view returns (bool, Subnet memory) {
        return LibGateway.getSubnet(subnetId);
    }

    function subnets(bytes32 h) external view returns (Subnet memory subnet) {
        return s.subnets[h];
    }

    /// @notice get number of top-down messages for the given subnet
    function getSubnetTopDownMsgsLength(SubnetID memory subnetId) external view returns (uint256) {
        (, Subnet storage subnet) = LibGateway.getSubnet(subnetId);
        return subnet.topDownMsgs.length;
    }

    /// @notice get the top-down message at the given index for the given subnet
    function getSubnetTopDownMsg(SubnetID memory subnetId, uint256 index) external view returns (CrossMsg memory) {
        (, Subnet storage subnet) = LibGateway.getSubnet(subnetId);
        return subnet.topDownMsgs[index];
    }

    function getTopDownMsgs(SubnetID calldata subnetId) external view returns (CrossMsg[] memory) {
        (bool registered, Subnet storage subnet) = LibGateway.getSubnet(subnetId);

        if (!registered) {
            revert NotRegisteredSubnet();
        }

        return subnet.topDownMsgs;
    }

    function totalWeight() public view returns (uint256) {
        return s.totalWeight;
    }

    function appliedTopDownNonce() public view returns (uint64) {
        return s.appliedTopDownNonce;
    }

    function postbox(bytes32 id) public view returns (StorableMsg memory storableMsg, bool wrapped) {
        return (s.postbox[id].message, s.postbox[id].wrapped);
    }

    /// @notice whether a validator has voted for a checkpoint submission during an epoch
    /// @param epoch - the epoch to check
    /// @param submitter - the validator to check
    function hasValidatorVotedForSubmission(uint64 epoch, address submitter) external view returns (bool) {
        EpochVoteTopDownSubmission storage voteSubmission = s.epochVoteSubmissions[epoch];
        return voteSubmission.vote.submitters[voteSubmission.vote.nonce][submitter];
    }

    /// @notice returns the current bottom-up checkpoint
    /// @param epoch - the epoch to check
    /// @return exists - whether the checkpoint exists
    /// @return checkpoint - the checkpoint struct
    function bottomUpCheckpointAtEpoch(
        uint64 epoch
    ) public view returns (bool exists, BottomUpCheckpoint memory checkpoint) {
        checkpoint = s.bottomUpCheckpoints[epoch];
        exists = !checkpoint.source.isEmpty();
    }

    /// @notice returns the historical bottom-up checkpoint hash
    /// @param epoch - the epoch to check
    /// @return exists - whether the checkpoint exists
    /// @return hash - the hash of the checkpoint
    function bottomUpCheckpointHashAtEpoch(uint64 epoch) external view returns (bool, bytes32) {
        (bool exists, BottomUpCheckpoint memory checkpoint) = bottomUpCheckpointAtEpoch(epoch);
        return (exists, checkpoint.toHash());
    }

    function getGenesisEpoch() public view returns (uint64) {
        return LibVoting.getGenesisEpoch();
    }

    function executableQueue() public view returns (uint64, uint64, uint64) {
        return LibVoting.executableQueue();
    }

    function lastVotingExecutedEpoch() public view returns (uint64) {
        return LibVoting.lastVotingExecutedEpoch();
    }

    function majorityPercentage() public view returns (uint64) {
        return LibVoting.majorityPercentage();
    }
}
