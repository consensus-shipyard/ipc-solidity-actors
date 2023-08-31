// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IPCAddress, SubnetID} from "../../../src/structs/Subnet.sol";
import {FvmAddress} from "../../../src/structs/FvmAddress.sol";
import {GatewayMessengerFacet} from "../../../src/gateway/GatewayMessengerFacet.sol";
import {GatewayGetterFacet} from "../../../src/gateway/GatewayGetterFacet.sol";
import {CrossMsg, StorableMsg} from "../../../src/structs/Checkpoint.sol";
import {GatewayCannotBeZero} from "../../../src/errors/IPCErrors.sol";
import {IERC20} from "../../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "../../../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "../../../lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";
import {FvmAddressHelper} from "../../../src/lib/FvmAddressHelper.sol";

error NoTransfer();

/**
 * @title TokenMessenger
 * @notice An example of a contract that allows users to send a token cross-subnet.
 */
contract ERC20TokenMessenger is ReentrancyGuard {
    using FvmAddressHelper for FvmAddress;
    using SafeERC20 for IERC20;

    uint64 public nonce = 0;
    // Gateway facet used to send messages
    GatewayMessengerFacet private immutable messenger;
    // Gateway facet used to get information about the subnet
    GatewayGetterFacet private immutable info;

    event TokenSent(
        address tokenContract,
        address sender,
        SubnetID destinationSubnet,
        address receiver,
        address user,
        uint64 nonce,
        uint256 value
    );

    constructor(address _gateway) {
        if (_gateway == address(0)) {
            revert GatewayCannotBeZero();
        }
        messenger = GatewayMessengerFacet(address(_gateway));
        info = GatewayGetterFacet(address(_gateway));
    }

    function sendToken(
        address tokenContract,
        SubnetID memory destinationSubnet,
        address receiver,
        address user,
        uint256 amount
    ) public payable nonReentrant {
        uint256 startingBalance = IERC20(tokenContract).balanceOf(address(this));

        IERC20(tokenContract).safeTransferFrom({from: msg.sender, to: address(this), value: amount});

        uint256 endingBalance = IERC20(tokenContract).balanceOf(address(this));

        if (endingBalance <= startingBalance) {
            revert NoTransfer();
        }

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
            from: IPCAddress({
            subnetId: info.getNetworkName(),
            rawAddress: FvmAddressHelper.from(address(tokenContract))
        }),
            to: IPCAddress({subnetId: destinationSubnet, rawAddress: FvmAddressHelper.from(address(receiver))}),
            value: 0,
            nonce: nonce,
            method: bytes4(keccak256("transfer(address,uint256)")),
            params: abi.encode(user, amount)
        }),
            wrapped: false
        });

        emit TokenSent({
            tokenContract: tokenContract,
            sender: msg.sender,
            destinationSubnet: destinationSubnet,
            receiver: receiver,
            user: user,
            nonce: nonce++,
            value: amount
        });

        return messenger.sendCrossMessage{value: msg.value}(crossMsg);
    }

    receive() external payable {}
}