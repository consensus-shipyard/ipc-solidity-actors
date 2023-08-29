// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {METHOD_SEND, EMPTY_BYTES} from "../constants/Constants.sol";
import {StorableMsg, CrossMsg} from "../structs/Checkpoint.sol";
import {SubnetID, IPCAddress} from "../structs/Subnet.sol";
import {SubnetIDHelper} from "../lib/SubnetIDHelper.sol";
import {FvmAddressHelper} from "../lib/FvmAddressHelper.sol";
import {FvmAddress} from "../structs/FvmAddress.sol";
import {FilAddress} from "fevmate/utils/FilAddress.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";

import "forge-std/console.sol";

/// @title Helper library for manipulating StorableMsg struct
/// @author LimeChain team
library CrossMsgHelper {
    using SubnetIDHelper for SubnetID;
    using FilAddress for address;
    using FvmAddressHelper for FvmAddress;

    function createReleaseMsg(
        SubnetID calldata subnet,
        address signer,
        FvmAddress calldata to,
        uint256 value
    ) public pure returns (CrossMsg memory) {
        return
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({subnetId: subnet, rawAddress: FvmAddressHelper.from(signer)}),
                    to: IPCAddress({subnetId: subnet.getParentSubnet(), rawAddress: to}),
                    value: value,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: EMPTY_BYTES
                }),
                wrapped: false
            });
    }

    function createFundMsg(
        SubnetID calldata subnet,
        address signer,
        FvmAddress calldata to,
        uint256 value
    ) public pure returns (CrossMsg memory) {
        return
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({subnetId: subnet.getParentSubnet(), rawAddress: FvmAddressHelper.from(signer)}),
                    to: IPCAddress({subnetId: subnet, rawAddress: to}),
                    value: value,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: EMPTY_BYTES
                }),
                wrapped: false
            });
    }

    function toHash(CrossMsg memory crossMsg) internal pure returns (bytes32) {
        return keccak256(abi.encode(crossMsg));
    }

    function toHash(CrossMsg[] memory crossMsgs) public pure returns (bytes32) {
        return keccak256(abi.encode(crossMsgs));
    }

    function isEmpty(CrossMsg memory crossMsg) internal pure returns (bool) {
        return
            crossMsg.message.nonce == 0 &&
            crossMsg.message.to.subnetId.root == 0 &&
            crossMsg.message.from.subnetId.root == 0;
    }

    function execute(CrossMsg calldata crossMsg) public returns (bytes memory) {
        uint256 value = crossMsg.message.value;
        address recipient = crossMsg.message.to.rawAddress.extractEvmAddress().normalize();
        console.log(">>>> execute:");
        console.log("crossMsg.value:", value);
        console.log("msg.value:", msg.value);
        console.log("recipient:", recipient);

        if (crossMsg.message.method == METHOD_SEND) {
            console.log("METHOD_SEND received");
            Address.sendValue(payable(recipient), value);
            return EMPTY_BYTES;
        }

        console.logBytes4(crossMsg.message.method);
        console.logBytes(crossMsg.message.params);

        bytes memory params = crossMsg.message.params;

        if (crossMsg.wrapped) {
            params = abi.encode(crossMsg);
        }

        //bytes memory data = abi.encodeWithSelector(crossMsg.message.method, params);
        bytes memory data = params;
        console.logBytes(data);

        if (value > 0) {
            return Address.functionCallWithValue({target: recipient, data: data, value: value});
        }
        console.log("Address.functionCall");
        console.log("Address this:", address(this));
        //(address a, uint256 ff) = abi.decode(params, (address,uint256));
        //console.log("decoded:", a);
        //console.log("decoded:", ff);

        return Address.functionCall(recipient, data);
    }

    // checks whether the cross messages are sorted in ascending order or not
    function isSorted(CrossMsg[] calldata crossMsgs) external pure returns (bool) {
        uint256 prevNonce = 0;
        uint256 length = crossMsgs.length;
        for (uint256 i = 0; i < length; ) {
            uint256 nonce = crossMsgs[i].message.nonce;

            if (prevNonce >= nonce) {
                if (i > 0) {
                    return false;
                }
            }

            prevNonce = nonce;
            unchecked {
                ++i;
            }
        }

        return true;
    }
}
