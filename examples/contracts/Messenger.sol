// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {METHOD_SEND} from "../../src/constants/Constants.sol";
import {FvmAddress} from "../../src/structs/FvmAddress.sol";
import {GatewayCannotBeZero, ZeroAddress} from "../../src/errors/IPCErrors.sol";
import {IGateway} from "../../src/interfaces/IGateway.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {CrossMsg, StorableMsg} from "../../src/structs/Checkpoint.sol";
import {FvmAddressHelper} from "../../src/lib/FvmAddressHelper.sol";
import {CrossMsgHelper} from "../../src/lib/CrossMsgHelper.sol";

/**
 * @title Messenger
 * @notice An example of a contract that allows users to send messages cross-subnet.
 */
contract Messenger {
    using FvmAddressHelper for FvmAddress;
    using CrossMsgHelper for CrossMsg;

    // Gateway facet used to send messages
    GatewayMessengerFacet private immutable messenger;
    // Subnet for which the contract is deployed
    SubnetID public localSubnet;
    // Message nonce
    uint64 public nonce;
    // Cross-net fee
    uint256 public constant DEFAULT_CROSS_MSG_FEE = 10 gwei;

    event MessageSent(IPCAddress from, IPCAddress to, uint64 nonce, bytes messageBody);

    constructor(address gw, SubnetID memory subnet) {
        if (gw == address(0)) {
            revert GatewayCannotBeZero();
        }
        messenger = GatewayMessengerFacet(address(gw));
        nonce = 0;
        localSubnet = subnet;
    }

    function sendMessage(
        SubnetID calldata destinationSubnet,
        address receiver,
        bytes calldata messageBody
    ) public payable returns (bytes32) {
        if (receiver == address(0)) {
            revert ZeroAddress();
        }

        IPCAddress memory from = IPCAddress({subnetId: localSubnet, rawAddress: FvmAddressHelper.from(msg.sender)});
        IPCAddress memory to = IPCAddress({subnetId: destinationSubnet, rawAddress: FvmAddressHelper.from(receiver)});

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: from,
                to: to,
                value: msg.value,
                nonce: nonce,
                method: METHOD_SEND,
                params: messageBody
            }),
            wrapped: true
        });

        // emit event and increase nonce
        emit MessageSent({from: from, to: to, nonce: nonce++, messageBody: messageBody});

        // slither-disable-next-line arbitrary-send-eth
        messenger.sendCrossMessage{value: msg.value}(crossMsg);

        return crossMsg.toHash();
    }
}
