// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IPCAddress, SubnetID} from "../../src/structs/Subnet.sol";
import {ZeroAddress} from "../../src/errors/IPCErrors.sol";
import {DemoCrossMessenger} from "./Messenger.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

error NoTransfer();

contract DemoTokenMessenger is ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint256 public lastEventNonce = 0;
    DemoCrossMessenger messenger;

    constructor(address _messenger){
        if (_messenger == address(0)) {
            revert ZeroAddress();
        }
        messenger = DemoCrossMessenger(_messenger);
    }

    function sendToken(address tokenContract, SubnetID memory destinationSubnet, address receiver, uint256 amount) external nonReentrant {
        uint256 startingBalance = IERC20(tokenContract).balanceOf(address(this));
        IERC20(tokenContract).safeTransferFrom(msg.sender, address(this), amount);
        uint256 endingBalance = IERC20(tokenContract).balanceOf(address(this));

        if (endingBalance <= startingBalance) {
            revert NoTransfer();
        }

        ++lastEventNonce;
        messenger.sendMessageFrom(tokenContract, destinationSubnet, receiver, amount);
    }

    receive() external payable{}

}
