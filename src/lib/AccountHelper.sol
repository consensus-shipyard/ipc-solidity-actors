// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../constants/Constants.sol";

/// @title Helper library for checking account type
/// @author LimeChain team
library AccountHelper {
    bytes32 constant ACCOUNT_HASH =
        0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

    function isAccount(address _address) internal view returns (bool) {
        uint size;

        assembly {
            size := extcodesize(_address)
        }

        return
            size == 0 &&
            ACCOUNT_HASH == _address.codehash &&
            ACCOUNT_HASH == keccak256(_address.code);
    }

    function isMultisig(address _address) internal pure returns (bool) {
        return _address == MULTISIG_ACTOR;
    }
}
