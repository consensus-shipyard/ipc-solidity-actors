// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {METHOD_SEND} from "../../src/constants/Constants.sol";
import {FvmAddress} from "../../src/structs/FvmAddress.sol";
import {GatewayCannotBeZero, ZeroAddress, InvalidAmount} from "../../src/errors/IPCErrors.sol";
import {IGateway} from "../../src/interfaces/IGateway.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {CrossMsg, StorableMsg} from "../../src/structs/Checkpoint.sol";
import {FvmAddressHelper} from "../../src/lib/FvmAddressHelper.sol";

/**
 * @title Messenger
 * @notice An example of a contract that allows users to send transactions cross-subnet.
 */
contract DemoCrossMessenger {
    using FvmAddressHelper for FvmAddress;

    event MessageSent(IPCAddress from, IPCAddress to, uint256 value);

    GatewayMessengerFacet private messenger;
    SubnetID public localSubnet;
    uint64 public nonce;
    uint256 public constant DEFAULT_CROSS_MSG_FEE = 10 gwei;

    constructor(address gw, SubnetID memory subnet) {
        if (gw == address(0)) {
            revert GatewayCannotBeZero();
        }
        nonce = 0;
        localSubnet = subnet;
        messenger = new GatewayMessengerFacet();
        messenger = GatewayMessengerFacet(address(gw));
    }

    function sendMessage(SubnetID memory destinationSubnet, address receiver, uint256 amount) external payable {
        if (receiver == address(0)) {
            revert ZeroAddress();
        }
        if (amount < DEFAULT_CROSS_MSG_FEE) {
            revert InvalidAmount();
        }
        address sender = msg.sender;

        IPCAddress memory from = IPCAddress({subnetId: localSubnet, rawAddress: FvmAddressHelper.from(sender)});
        IPCAddress memory to = IPCAddress({subnetId: destinationSubnet, rawAddress: FvmAddressHelper.from(receiver)});

        uint256 value = amount;

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: from,
                to: to,
                value: value,
                nonce: nonce,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: true
        });

        ++nonce;
        emit MessageSent(from, to, value);

        //slither-disable-next-line arbitrary-send-eth
        messenger.sendCrossMessage{value: value}(crossMsg);
    }
}
