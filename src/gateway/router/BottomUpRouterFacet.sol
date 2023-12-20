// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {ISubnetActor} from "../../interfaces/ISubnetActor.sol";
import {GatewayActorModifiers} from "../../lib/LibGatewayActorStorage.sol";
import {BottomUpMsgBatch} from "../../structs/CrossNet.sol";
import {LibGateway} from "../../lib/LibGateway.sol";
import {Status} from "../../enums/Status.sol";
import {BatchNotCreated, BatchAlreadyExists, InvalidBatchEpoch, NotEnoughSubnetCircSupply, SubnetNotActive, SubnetNotFound, InvalidBatchSource, MaxMsgsPerBatchExceeded, BatchWithNoMessages, InvalidCrossMsgDstSubnet, NotRegisteredSubnet, InvalidCrossMsgNonce} from "../../errors/IPCErrors.sol";
import {Subnet} from "../../structs/Subnet.sol";
import {LibQuorum} from "../../lib/LibQuorum.sol";
import {QuorumObjKind} from "../../structs/Quorum.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {IPCMsgType} from "../../enums/IPCMsgType.sol";

import {CrossMsg, SubnetID} from "../../structs/CrossNet.sol";
import {CrossMsgHelper} from "../../lib/CrossMsgHelper.sol";

import {SupplySourceHelper} from "../../lib/SupplySourceHelper.sol";
import {SupplySource} from "../../structs/Subnet.sol";
import {SubnetActorGetterFacet} from "../../subnet/SubnetActorGetterFacet.sol";

import {SubnetIDHelper} from "../../lib/SubnetIDHelper.sol";
import {StorableMsgHelper} from "../../lib/StorableMsgHelper.sol";
import {StorableMsg} from "../../structs/CrossNet.sol";

contract BottomUpRouterFacet is GatewayActorModifiers {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using SupplySourceHelper for SupplySource;
    using StorableMsgHelper for StorableMsg;

    /// @notice submit a batch of cross-net messages for execution.
    /// @dev this method is called by the corresponding subnet actor.
    /// Called from a subnet actor if the batch is valid.
    /// @param batch The batch of bottom-up cross-network messages to be executed.
    function execBottomUpMsgBatch(BottomUpMsgBatch calldata batch) external {
        if (batch.subnetID.getActor() != msg.sender) {
            revert InvalidBatchSource();
        }

        _checkMsgLength(batch);

        (bool subnetExists, Subnet storage subnet) = LibGateway.getSubnet(msg.sender);
        if (!subnetExists) {
            revert SubnetNotFound();
        }
        // cross-net messages can't be executed in inactive subnets.
        if (subnet.status != Status.Active) {
            revert SubnetNotActive();
        }

        uint256 totalValue;
        uint256 totalFee;
        uint256 crossMsgLength = batch.msgs.length;
        for (uint256 i; i < crossMsgLength; ) {
            totalValue += batch.msgs[i].message.value;
            totalFee += batch.msgs[i].message.fee;
            unchecked {
                ++i;
            }
        }

        uint256 totalAmount = totalFee + totalValue;

        if (subnet.circSupply < totalAmount) {
            revert NotEnoughSubnetCircSupply();
        }

        subnet.circSupply -= totalAmount;

        // execute cross-messages
        _applyMessages(subnet.id, batch.msgs);

        if (s.crossMsgRelayerRewards) {
            // reward relayers in the subnet for committing the previous checkpoint
            // slither-disable-next-line unused-return
            Address.functionCallWithValue({
                target: msg.sender,
                data: abi.encodeCall(
                    ISubnetActor.distributeRewardToRelayers,
                    (block.number, totalFee, QuorumObjKind.Checkpoint)
                ),
                value: totalFee
            });
        }
    }

    /// @notice cuts a new message batch if the batch period is reached without
    /// the maximum number of messages being reached.
    /// @param batch - a bottom-up batch
    /// @param membershipRootHash - a root hash of the Merkle tree built from the validator public keys and their weight
    /// @param membershipWeight - the total weight of the membership
    function createBottomUpMsgBatch(
        BottomUpMsgBatch calldata batch,
        bytes32 membershipRootHash,
        uint256 membershipWeight
    ) external systemActorOnly {
        _checkMsgLength(batch);
        // We only externally trigger new batches if the maximum number
        // of messages for the batch hasn't been reached.
        // We also check that we are not trying to create a batch from
        // the future
        if (batch.blockHeight % s.bottomUpMsgBatchPeriod != 0 || block.number <= batch.blockHeight) {
            revert InvalidBatchEpoch();
        }

        if (LibGateway.bottomUpBatchMsgsExists(batch.blockHeight)) {
            revert BatchAlreadyExists();
        }

        LibQuorum.createQuorumInfo({
            self: s.bottomUpMsgBatchQuorumMap,
            objHeight: batch.blockHeight,
            objHash: keccak256(abi.encode(batch)),
            membershipRootHash: membershipRootHash,
            membershipWeight: membershipWeight,
            majorityPercentage: s.majorityPercentage
        });
        LibGateway.storeBottomUpMsgBatch(batch);
    }

    /// @notice Set a new batch retention height and garbage collect all batches in range [`retentionHeight`, `newRetentionHeight`)
    /// @param newRetentionHeight - the height of the oldest batch to keep
    function pruneBottomUpMsgBatches(uint256 newRetentionHeight) external systemActorOnly {
        for (uint256 h = s.bottomUpMsgBatchQuorumMap.retentionHeight; h < newRetentionHeight; ) {
            delete s.bottomUpMsgBatches[h];
            unchecked {
                ++h;
            }
        }

        LibQuorum.pruneQuorums(s.bottomUpMsgBatchQuorumMap, newRetentionHeight);
    }

    /// @notice checks whether the provided batch signature for the block at height `height` is valid and accumulates that
    /// @param height - the height of the block in the checkpoint
    /// @param membershipProof - a Merkle proof that the validator was in the membership at height `height` with weight `weight`
    /// @param weight - the weight of the validator
    /// @param signature - the signature of the checkpoint
    function addBottomUpMsgBatchSignature(
        uint256 height,
        bytes32[] memory membershipProof,
        uint256 weight,
        bytes memory signature
    ) external {
        LibQuorum.isHeightAlreadyProcessed(s.bottomUpMsgBatchQuorumMap, height);

        // slither-disable-next-line unused-return
        (bool exists, ) = LibGateway.getBottomUpMsgBatch(height);
        if (!exists) {
            revert BatchNotCreated();
        }
        LibQuorum.addQuorumSignature({
            self: s.bottomUpMsgBatchQuorumMap,
            height: height,
            membershipProof: membershipProof,
            weight: weight,
            signature: signature
        });
    }

    /// @notice applies a cross-net messages coming from some other subnet.
    /// The forwarder argument determines the previous subnet that submitted the checkpoint triggering the cross-net message execution.
    /// @param arrivingFrom - the immediate subnet from which this message is arriving
    /// @param crossMsgs - the cross-net messages to apply
    function _applyMessages(SubnetID memory arrivingFrom, CrossMsg[] memory crossMsgs) internal {
        uint256 crossMsgsLength = crossMsgs.length;
        for (uint256 i; i < crossMsgsLength; ) {
            _applyMsg(arrivingFrom, crossMsgs[i]);
            unchecked {
                ++i;
            }
        }
    }

    /// @notice executes a cross message if its destination is the current network, otherwise adds it to the postbox to be propagated further
    /// @param arrivingFrom - the immediate subnet from which this message is arriving
    /// @param crossMsg - the cross message to be executed
    function _applyMsg(SubnetID memory arrivingFrom, CrossMsg memory crossMsg) internal {
        if (crossMsg.message.to.subnetId.isEmpty()) {
            revert InvalidCrossMsgDstSubnet();
        }

        // If the crossnet destination is NOT the current network (network where the gateway is running),
        // we add it to the postbox for further propagation.
        if (!crossMsg.message.to.subnetId.equals(s.networkName)) {
            bytes32 cid = crossMsg.toHash();
            s.postbox[cid] = crossMsg;
            return;
        }

        // Now, let's find out the directionality of this message and act accordingly.
        // slither-disable-next-line uninitialized-local
        SupplySource memory supplySource;
        IPCMsgType applyType = crossMsg.message.applyType(s.networkName);
        if (applyType == IPCMsgType.BottomUp) {
            // Load the subnet this message is coming from. Ensure that it exists and that the nonce expectation is met.
            (bool registered, Subnet storage subnet) = LibGateway.getSubnet(arrivingFrom);
            if (!registered) {
                revert NotRegisteredSubnet();
            }
            if (subnet.appliedBottomUpNonce != crossMsg.message.nonce) {
                revert InvalidCrossMsgNonce();
            }
            subnet.appliedBottomUpNonce += 1;

            // The value carried in bottom-up messages needs to be treated according to the supply source
            // configuration of the subnet.
            supplySource = SubnetActorGetterFacet(subnet.id.getActor()).supplySource();
        } else if (applyType == IPCMsgType.TopDown) {
            // Note: there is no need to load the subnet, as a top-down application means that _we_ are the subnet.
            if (s.appliedTopDownNonce != crossMsg.message.nonce) {
                revert InvalidCrossMsgNonce();
            }
            s.appliedTopDownNonce += 1;

            // The value carried in top-down messages locally maps to the native coin, so we pass over the
            // native supply source.
            supplySource = SupplySourceHelper.native();
        }

        // slither-disable-next-line unused-return
        crossMsg.execute(supplySource);
    }

    /// @notice Checks the length of a message batch, ensuring it is in (0, maxMsgsPerBottomUpBatch).
    /// @param batch The batch of messages to check.
    function _checkMsgLength(BottomUpMsgBatch memory batch) internal view {
        if (batch.msgs.length > s.maxMsgsPerBottomUpBatch) {
            revert MaxMsgsPerBatchExceeded();
        }
        if (batch.msgs.length == 0) {
            revert BatchWithNoMessages();
        }
    }
}
