// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {SupplySource, SupplyKind} from "../structs/Subnet.sol";
import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";
import {Address} from "openzeppelin-contracts/utils/Address.sol";
import {SafeERC20} from "openzeppelin-contracts/token/ERC20/utils/SafeERC20.sol";

/// @notice Helpers to deal with a supply strategy.
library SupplySourceHelper {
    using SafeERC20 for IERC20;

    error UnusedAllowance();
    error InvalidERC20Address();
    error InsufficientValueReceived();
    error UnexpectedSupplySource();
    error UnknownSupplySource();

    /// @notice Checks that a given supply strategy is correctly formed and its preconditions are met.
    ///         It reverts if conditions are not met.
    function validate(SupplySource memory supplySource) internal view {
        if (supplySource.kind == SupplyKind.ERC20) {
            if (supplySource.tokenAddress == address(0)) {
                revert InvalidERC20Address();
            }
            // We require that the ERC20 token contract exists beforehand.
            // The call to balanceOf will revert if the supplied address does not exist, or if it's not an ERC20 contract.
            // Ideally we'd be able to use ERC165 to check if the contract implements the ERC20 standard, but the latter does not support supportsInterface().
            IERC20 token = IERC20(supplySource.tokenAddress);
            token.balanceOf(address(this));
        }
    }

    /// @notice Asserts that the supply strategy is of the given kind. If not, it reverts.
    function expect(SupplySource memory supplySource, SupplyKind kind) internal pure {
        if (supplySource.kind != kind) {
            revert UnexpectedSupplySource();
        }
    }

    /// @notice Locks the specified amount into custody.
    function lock(SupplySource memory supplySource, address from, uint256 value) internal {
        if (supplySource.kind == SupplyKind.ERC20) {
            IERC20 token = IERC20(supplySource.tokenAddress);
            if (token.allowance({owner: from, spender: address(this)}) != value) {
                // Ensure we're using the full allowance, as otherwise
            }
            token.safeTransferFrom({from: from, to: address(this), value: value});
        }
        // Do nothing for native.
    }

    /// @notice Transfers the specified amount out of our treasury to the recipient address.
    function transfer(SupplySource memory supplySource, address payable recipient, uint256 value) internal {
        if (supplySource.kind == SupplyKind.Native) {
            Address.sendValue(payable(recipient), value);
        } else if (supplySource.kind == SupplyKind.ERC20) {
            IERC20(supplySource.tokenAddress).safeTransfer({to: recipient, value: value});
        } else {
            revert UnknownSupplySource();
        }
    }

    /// @notice Calls the target with the specified data, ensuring it receives the specified value.
    function call(SupplySource memory supplySource, address payable target, bytes memory data, uint256 value) internal returns (bytes memory) {
        // If value is zero, we can just go ahead and call the function.
        if (value == 0) {
            return Address.functionCall(target, data);
        }

        // Otherwise, we need to do something different.
        if (supplySource.kind == SupplyKind.Native) {
            // Use the optimized path to send value along with the call.
            return Address.functionCallWithValue({target: target, data: data, value: value});
        } else if (supplySource.kind == SupplyKind.ERC20) {
            // Transfer the tokens first, _then_ perform the call.
            IERC20(supplySource.tokenAddress).safeTransfer({to: target, value: value});
            return Address.functionCall(target, data);
        }
        revert UnknownSupplySource();
    }

    /// @notice Gets the balance in our treasury.
    function balance(SupplySource memory supplySource) internal view returns (uint256) {
        if (supplySource.kind == SupplyKind.Native) {
            return address(this).balance;
        } else if (supplySource.kind == SupplyKind.ERC20) {
            return IERC20(supplySource.tokenAddress).balanceOf(address(this));
        }
        revert UnknownSupplySource();
    }

    function native() internal pure returns (SupplySource memory) {
        return SupplySource({
            kind: SupplyKind.Native,
            tokenAddress: address(0)
        });
    }

}
