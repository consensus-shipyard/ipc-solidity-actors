// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {GatewayCannotBeZero} from "../../src/errors/IPCErrors.sol";
import {IGateway} from "../../src/interfaces/IGateway.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {CrossMsg} from "../../src/structs/Checkpoint.sol";

contract Messenger {
    GatewayMessengerFacet private sender;

    uint256 constant CROSS_MSG_FEE = 10 gwei;

    constructor(address _gateway){
        if (_gateway == address(0)) {
            revert GatewayCannotBeZero();
        }
        sender = new GatewayMessengerFacet();
        sender = GatewayMessengerFacet(address(_gateway));
    }

    function sendMessage(CrossMsg calldata crossMsg) external payable {
        sender.sendCrossMessage{value: CROSS_MSG_FEE + 1}(crossMsg);
    }
 }
