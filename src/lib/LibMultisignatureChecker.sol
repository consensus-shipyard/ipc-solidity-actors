// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {ECDSA} from "openzeppelin-contracts/utils/cryptography/ECDSA.sol";

/// @title Multi-signature ECDSA verification helper.
library MultisignatureChecker {
    uint8 public constant SIGNATURE_LENGTH = 65;

    enum Error {
        Nil,
        InvalidArrayLength,
        InvalidSignaturesBytes,
        InvalidSigner,
        InvalidSignature,
        WeightsSumLessThanThreshold
    }

    function parseSignature(
        bytes memory signatures,
        uint256 index
    ) public pure returns (uint8 v, bytes32 r, bytes32 s) {
        uint256 offset = index * SIGNATURE_LENGTH;

        assembly {
            r := mload(add(signatures, add(32, offset)))
            s := mload(add(signatures, add(64, offset)))
            v := byte(0, mload(add(signatures, add(96, offset))))
        }

        return (v, r, s);
    }

    /// @notice Counts the number of signatures in a signatures bytes array. Returns 0 if the length is invalid.
    /// @param signatures The signatures bytes array
    /// @dev Signatures are 65 bytes long and are densely packed.
    function countSignatures(bytes memory signatures) public pure returns (uint256) {
        uint256 len = signatures.length;
        return (len % SIGNATURE_LENGTH) == 0 ? (len / SIGNATURE_LENGTH) : 0;
    }

    /**
     * @dev Checks if a multi-signature is valid for a given message hash, set of signatories, and set of signatures.
     * Signatures are validated using `ECDSA.recover`.
     */
    function isValidMultiSignature(
        address[] memory signatories,
        bytes32 hash,
        bytes memory signatures
    ) internal pure returns (bool, Error) {
        bool valid = true;

        uint256 signaturesNumber = countSignatures(signatures);
        if (signaturesNumber == 0) {
            return (!valid, Error.InvalidSignaturesBytes);
        }
        if (signaturesNumber != signatories.length) {
            return (!valid, Error.InvalidArrayLength);
        }

        uint8 v;
        bytes32 r;
        bytes32 s;

        for (uint256 i = 0; i < signaturesNumber; ) {
            (v, r, s) = parseSignature(signatures, i);
            (address recovered, ECDSA.RecoverError ecdsaErr, ) = ECDSA.tryRecover({hash: hash, v: v, r: r, s: s});
            if (ecdsaErr != ECDSA.RecoverError.NoError) {
                return (!valid, Error.InvalidSignature);
            }
            if (recovered != signatories[i]) {
                return (!valid, Error.InvalidSigner);
            }
            unchecked {
                ++i;
            }
        }
        return (valid, Error.Nil);
    }

    /**
     * @dev Checks if a weighted multi-signature is valid for a given message hash, set of signatories, set of weights, and set of signatures.
     * Signatures are validated using `ECDSA.recover`. The multi-signature fails if the sum of the weights is less than the threshold.
     */
    function isValidWeightedMultiSignature(
        address[] memory signatories,
        uint256[] memory weights,
        uint256 threshold,
        bytes32 hash,
        bytes memory signatures
    ) internal pure returns (bool, Error) {
        bool valid = true;
        uint256 weight;

        uint256 signaturesNumber = countSignatures(signatures);
        if (signaturesNumber == 0) {
            return (!valid, Error.InvalidSignaturesBytes);
        }
        if (signaturesNumber != signatories.length || signaturesNumber != weights.length) {
            return (!valid, Error.InvalidArrayLength);
        }

        uint8 v;
        bytes32 r;
        bytes32 s;

        for (uint256 i = 0; i < signaturesNumber; ) {
            (v, r, s) = parseSignature(signatures, i);
            (address recovered, ECDSA.RecoverError ecdsaErr, ) = ECDSA.tryRecover({hash: hash, v: v, r: r, s: s});
            if (ecdsaErr != ECDSA.RecoverError.NoError) {
                return (!valid, Error.InvalidSignature);
            }
            if (recovered != signatories[i]) {
                return (!valid, Error.InvalidSigner);
            }
            weight = weight + weights[i];
            unchecked {
                ++i;
            }
        }
        if (weight >= threshold) {
            return (valid, Error.Nil);
        }
        return (!valid, Error.WeightsSumLessThanThreshold);
    }
}
