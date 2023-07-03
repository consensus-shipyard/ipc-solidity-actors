// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {FvmAddress, DelegatedAddress} from "../structs/FvmAddress.sol";

/// @title Helper library for Fil Address
library FvmAddressHelper {
    /// f1: SECP256K1 key address, 20 byte hash of PublicKey.
    uint8 public constant SECP256K1 = 1;
    uint8 public constant PAYLOAD_HASH_LEN = 20;

    /// For delegated FIL address
    uint8 public constant DELEGATED = 4;
    uint64 public constant EAM_ACTOR = 10;

    /// @notice Checks if two fil addresses are the same
    function from(address addr) internal pure returns (FvmAddress memory fvmAddress) {
        bytes memory payload = abi.encode(DelegatedAddress({
            namespace: EAM_ACTOR,
            length: 20,
            buffer: abi.encodePacked(addr)
        }));

        fvmAddress = FvmAddress({
            addrType: DELEGATED,
            payload: payload
        });
    }

    function extractEvmAddress(FvmAddress calldata fvmAddress) internal pure returns (address addr) {
        require(fvmAddress.addrType == DELEGATED, "IPC-1");
        
        DelegatedAddress memory delegated = abi.decode(fvmAddress.payload, (DelegatedAddress));
        
        require(delegated.namespace == EAM_ACTOR, "IPC-1");
        require(delegated.length == 20, "IPC-1");
        require(delegated.buffer.length == 20, "IPC-1");
        
        addr = _bytesToAddress(delegated.buffer);
    }

    /// @notice Checks if two fil addresses are the same
    function isEqual(FvmAddress calldata f1, FvmAddress calldata f2) internal pure returns (bool) {
        if (f1.addrType != f2.addrType) {
            return false;
        }
        return f1.payload.length == f2.payload.length && keccak256(f1.payload) == keccak256(f2.payload);
    }

    /// @notice Checks if the fil addresses is valid. For f4, We only support evm address.
    function isValid(FvmAddress calldata filAddress) internal pure returns (bool) {
        if (filAddress.addrType == SECP256K1) { return _isValidF1Address(filAddress.payload); }
        if (filAddress.addrType == DELEGATED) { return _isValidF4EVMAddress(filAddress.payload); }

        return false;
    }

    function _isValidF1Address(bytes calldata payload) private pure returns (bool) {
        return payload.length == PAYLOAD_HASH_LEN;
    }

    function _isValidF4EVMAddress(bytes calldata payload) private pure returns (bool) {
        DelegatedAddress memory delegated = abi.decode(payload, (DelegatedAddress));
        
        if (delegated.namespace != EAM_ACTOR) { return false; }
        if (delegated.length != 20) { return false; }
        if (delegated.buffer.length != 20) { return false; }

        return true;
    }

    function _bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys,20))
        }
    }
}
