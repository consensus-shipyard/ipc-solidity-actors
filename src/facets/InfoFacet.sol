// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "../lib/AppStorage.sol";
import {EMPTY_HASH, BURNT_FUNDS_ACTOR, METHOD_SEND} from "../constants/Constants.sol";
import {Voting} from "../Voting.sol";
import {CrossMsg, BottomUpCheckpoint, TopDownCheckpoint, StorableMsg, ChildCheck} from "../structs/Checkpoint.sol";
import {EpochVoteTopDownSubmission} from "../structs/EpochVoteSubmission.sol";
import {LibGateway} from "../lib/Gateway.sol";
import {Status} from "../enums/Status.sol";
import {IPCMsgType} from "../enums/IPCMsgType.sol";
import {ExecutableQueue} from "../structs/ExecutableQueue.sol";
import {IGateway} from "../interfaces/IGateway.sol";
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

contract InfoFacet {
    AppStorage internal s;

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

    function majorityPercentage() external view returns (uint8) {
        return s.majorityPercentage;
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

    function bottomUpCheckpoints(
        uint64 e
    )
        external
        view
        returns (
            SubnetID memory source,
            uint64 epoch,
            uint256 fee,
            CrossMsg[] memory crossMsgs,
            ChildCheck[] memory children,
            bytes32 prevHash,
            bytes memory proof
        )
    {
        return (
            s.bottomUpCheckpoints[e].source,
            s.bottomUpCheckpoints[e].epoch,
            s.bottomUpCheckpoints[e].fee,
            s.bottomUpCheckpoints[e].crossMsgs,
            s.bottomUpCheckpoints[e].children,
            s.bottomUpCheckpoints[e].prevHash,
            s.bottomUpCheckpoints[e].proof
        );
    }

    /// @notice returns the subnet with the given id
    /// @param subnetId the id of the subnet
    /// @return found whether the subnet exists
    /// @return subnet -  the subnet struct
    function getSubnet(SubnetID calldata subnetId) external view returns (bool, Subnet memory) {
        return LibGateway._getSubnet(subnetId);
    }

    function subnets(
        bytes32 h
    )
        external
        view
        returns (
            Status status,
            uint64 topDownNonce,
            uint64 appliedBottomUpNonce,
            uint256 stake,
            uint256 genesisEpoch,
            uint256 circSupply,
            SubnetID memory id,
            BottomUpCheckpoint memory prevCheckpoint
        )
    {
        status = s.subnets[h].status;
        topDownNonce = s.subnets[h].topDownNonce;
        appliedBottomUpNonce = s.subnets[h].appliedBottomUpNonce;
        stake = s.subnets[h].stake;
        genesisEpoch = s.subnets[h].genesisEpoch;
        circSupply = s.subnets[h].circSupply;
        id = s.subnets[h].id;
        prevCheckpoint = s.subnets[h].prevCheckpoint;
    }

    /// @notice get number of top-down messages for the given subnet
    function getSubnetTopDownMsgsLength(SubnetID memory subnetId) external view returns (uint256) {
        (, Subnet storage subnet) = LibGateway._getSubnet(subnetId);

        return subnet.topDownMsgs.length;
    }

    function getGenesisEpoch() public view returns (uint64) {
        return LibGateway.getGenesisEpoch();
    }

    function totalWeight() public view returns (uint256) {
        return s.totalWeight;
    }

    function appliedTopDownNonce() public view returns (uint64) {
        return s.appliedTopDownNonce;
    }

    function postboxHasOwner(bytes32 id, address caller) public view returns (bool) {
        return s.postboxHasOwner[id][caller];
    }

    function postbox(bytes32 id) public view returns (StorableMsg memory storableMsg, bool wrapped) {
        return (s.postbox[id].message, s.postbox[id].wrapped);
    }

    /// @notice get the top-down message at the given index for the given subnet
    function getSubnetTopDownMsg(SubnetID memory subnetId, uint256 index) external view returns (CrossMsg memory) {
        (, Subnet storage subnet) = LibGateway._getSubnet(subnetId);
        return subnet.topDownMsgs[index];
    }

    function executableQueue() public view returns (uint64, uint64, uint64) {
        return (s.executableQueue.period, s.executableQueue.first, s.executableQueue.last);
    }

    function lastVotingExecutedEpoch() public view returns (uint64) {
        return s.lastVotingExecutedEpoch;
    }
}