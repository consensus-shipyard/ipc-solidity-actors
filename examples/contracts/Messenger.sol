// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {METHOD_SEND, EMPTY_BYTES} from "../../src/constants/Constants.sol";
import {FvmAddress} from "../../src/structs/FvmAddress.sol";
import {GatewayCannotBeZero, ZeroAddress, NotEnoughFunds} from "../../src/errors/IPCErrors.sol";
import {IGateway} from "../../src/interfaces/IGateway.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {CrossMsg, StorableMsg} from "../../src/structs/Checkpoint.sol";
import {FvmAddressHelper} from "../../src/lib/FvmAddressHelper.sol";
import {CrossMsgHelper} from "../../src/lib/CrossMsgHelper.sol";

/**
 * @title Messenger
 * @notice An example of a simple wrapper-contract that allows users to send messages cross-subnet using a gateway.
 */
contract Messenger {
    using FvmAddressHelper for FvmAddress;
    using CrossMsgHelper for CrossMsg;

    // Gateway facet used to send messages
    GatewayMessengerFacet private immutable gateway;
    // Subnet for which the contract is deployed
    SubnetID public localSubnet;
    // Message nonce
    uint64 public nonce;
    // Cross-net fee
    uint256 public constant DEFAULT_CROSS_MSG_FEE = 10 gwei;

    event ValueSent(IPCAddress from, IPCAddress to, uint64 nonce, uint256 value);
    event MessageSent(IPCAddress from, IPCAddress to, uint64 nonce, bytes messageBody);

    constructor(address gw, SubnetID memory subnet) {
        if (gw == address(0)) {
            revert GatewayCannotBeZero();
        }
        gateway = GatewayMessengerFacet(address(gw));
        nonce = 0;
        localSubnet = subnet;
    }

    function sendValue(
        SubnetID calldata destinationSubnet,
        address receiver
    ) public payable returns (bytes32) {
        if (receiver == address(0)) {
            revert ZeroAddress();
        }
        if (msg.value <= DEFAULT_CROSS_MSG_FEE) {
            revert NotEnoughFunds();
        }

        IPCAddress memory from = IPCAddress({subnetId: localSubnet, rawAddress: FvmAddressHelper.from(msg.sender)});
        IPCAddress memory to = IPCAddress({subnetId: destinationSubnet, rawAddress: FvmAddressHelper.from(receiver)});

        uint256 value = msg.value - DEFAULT_CROSS_MSG_FEE;

        CrossMsg memory crossMsg = CrossMsg({
                message: StorableMsg({
                from: from,
                to: to,
                value: value,
                nonce: nonce,
                method: METHOD_SEND,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        // emit event and increase nonce
        emit ValueSent({from: from, to: to, nonce: nonce++, value: value});

        // slither-disable-next-line arbitrary-send-eth
        gateway.sendCrossMessage{value: msg.value}(crossMsg);

        return crossMsg.toHash();
    }

    function sendMessage(
        SubnetID calldata destinationSubnet,
        address receiver,
        bytes4 method,
        bytes calldata messageBody
    ) public payable returns (bytes32) {
        if (receiver == address(0)) {
            revert ZeroAddress();
        }
        if (msg.value < DEFAULT_CROSS_MSG_FEE) {
            revert NotEnoughFunds();
        }

        IPCAddress memory from = IPCAddress({subnetId: localSubnet, rawAddress: FvmAddressHelper.from(msg.sender)});
        IPCAddress memory to = IPCAddress({subnetId: destinationSubnet, rawAddress: FvmAddressHelper.from(receiver)});

        uint256 value = msg.value - DEFAULT_CROSS_MSG_FEE;

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: from,
                to: to,
                value: value,
                nonce: nonce,
                method: method,
                params: messageBody
            }),
            wrapped: false
        });

        // emit event and increase nonce
        emit MessageSent({from: from, to: to, nonce: nonce++, messageBody: messageBody});

        // slither-disable-next-line arbitrary-send-eth
        gateway.sendCrossMessage{value: msg.value}(crossMsg);

        return crossMsg.toHash();
    }
}
