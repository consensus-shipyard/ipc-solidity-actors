// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {GatewayActorModifiers} from "../../lib/LibGatewayActorStorage.sol";
import {CrossMsg, SubnetID, StorableMsg} from "../../structs/CrossNet.sol";
import {LibGateway} from "../../lib/LibGateway.sol";
import {IPCMsgType} from "../../enums/IPCMsgType.sol";
import {SubnetActorGetterFacet} from "../../subnet/SubnetActorGetterFacet.sol";
import {Subnet} from "../../structs/Subnet.sol";

import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {SubnetIDHelper} from "../../lib/SubnetIDHelper.sol";
import {CrossMsgHelper} from "../../lib/CrossMsgHelper.sol";
import {SupplySourceHelper} from "../../lib/SupplySourceHelper.sol";
import {SupplySource} from "../../structs/Subnet.sol";

import {InvalidCrossMsgNonce, InvalidCrossMsgNonce, NotRegisteredSubnet, InvalidCrossMsgDstSubnet} from "../../errors/IPCErrors.sol";

import {StorableMsgHelper} from "../../lib/StorableMsgHelper.sol";

contract CrossMessagingFacet is GatewayActorModifiers {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using SupplySourceHelper for SupplySource;
    using StorableMsgHelper for StorableMsg;

    /// @notice Applies top-down crossnet messages locally. This is invoked by IPC nodes when drawing messages from
    ///         their parent subnet for local execution. That's why the sender is restricted to the system sender,
    ///         because this method is implicitly invoked by the node during block production.
    /// @dev It requires the caller to be the system actor.
    /// @param crossMsgs The array of cross-network messages to be applied.
    function applyCrossMessages(CrossMsg[] calldata crossMsgs) external systemActorOnly {
        _applyMessages(s.networkName.getParentSubnet(), crossMsgs);
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
}
