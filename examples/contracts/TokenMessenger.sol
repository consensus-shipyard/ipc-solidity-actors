// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {ZeroAddress} from "../../src/errors/IPCErrors.sol";
import {Messenger} from "./Messenger.sol";
import {IERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "../../lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

error NoTransfer();

/**
 * @title TokenMessenger
 * @notice An example of a contract that allows users to send a token cross-subnet.
 */
contract TokenMessenger is ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint64 public lastEventNonce = 0;
    Messenger private immutable messenger;

    event TokenSent(
        address tokenContract,
        address sender,
        SubnetID destinationSubnet,
        address receiver,
        uint64 nonce,
        uint256 value
    );

    constructor(address _messenger) {
        if (_messenger == address(0)) {
            revert ZeroAddress();
        }
        messenger = Messenger(_messenger);
    }

    function sendToken(
        address tokenContract,
        SubnetID memory destinationSubnet,
        address receiver,
        uint256 amount
    ) external nonReentrant {
        uint256 startingBalance = IERC20(tokenContract).balanceOf(address(this));

        IERC20(tokenContract).safeTransferFrom({from: msg.sender, to: address(this), value: amount});

        uint256 endingBalance = IERC20(tokenContract).balanceOf(address(this));

        if (endingBalance <= startingBalance) {
            revert NoTransfer();
        }

        bytes memory payload = abi.encode(msg.sender, amount);

        emit TokenSent({
            tokenContract: tokenContract,
            sender: msg.sender,
            destinationSubnet: destinationSubnet,
            receiver: receiver,
            nonce: lastEventNonce++,
            value: amount
        });

        messenger.sendMessage({destinationSubnet: destinationSubnet, receiver: receiver, messageBody: payload});
    }

    receive() external payable {}
}
