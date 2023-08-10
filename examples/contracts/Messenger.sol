// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {METHOD_SEND} from "../../src/constants/Constants.sol";
import {FvmAddress} from "../../src/structs/FvmAddress.sol";
import {GatewayCannotBeZero} from "../../src/errors/IPCErrors.sol";
import {IGateway} from "../../src/interfaces/IGateway.sol";
import {GatewayMessengerFacet} from "../../src/gateway/GatewayMessengerFacet.sol";
import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {CrossMsg, StorableMsg} from "../../src/structs/Checkpoint.sol";
import {FvmAddressHelper} from "../../src/lib/FvmAddressHelper.sol";

contract Messenger {
    using FvmAddressHelper for FvmAddress;

    GatewayMessengerFacet private sender;
    SubnetID public subnet;
    uint64 public nonce;
    uint256 public constant CROSS_MSG_FEE = 10 gwei;

    constructor(address _gateway, SubnetID memory _subnet) {
        if (_gateway == address(0)) {
            revert GatewayCannotBeZero();
        }
        nonce = 0;
        subnet = _subnet;
        sender = new GatewayMessengerFacet();
        sender = GatewayMessengerFacet(address(_gateway));
    }

    function sendMessage(SubnetID memory dstSubnet, address dstUser) external payable {
        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: subnet, rawAddress: FvmAddressHelper.from(msg.sender)}),
                to: IPCAddress({subnetId: dstSubnet, rawAddress: FvmAddressHelper.from(dstUser)}),
                value: CROSS_MSG_FEE + 1,
                nonce: nonce,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: true
        });
        ++nonce;
        sender.sendCrossMessage{value: CROSS_MSG_FEE + 1}(crossMsg);
    }
}
