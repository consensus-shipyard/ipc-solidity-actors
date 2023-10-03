// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {MultisignatureChecker} from "../src/lib/LibMultisignatureChecker.sol";
import {ECDSA} from "openzeppelin-contracts/utils/cryptography/ECDSA.sol";

contract SignerTest is StdInvariant, Test {
    function testBasicSignerInterface() public pure {
        uint256 PRIVATE_KEY = 1000;
        address signer = vm.addr(PRIVATE_KEY);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY, hash);
        bytes memory signature = abi.encodePacked(r, s, v);

        address s1 = ECDSA.recover(hash, signature);
        require(s1 == signer, "s1 == signer");
    }

    function testMultiSignatureChecker_VerifyFourSignaturesFromRust() public pure {
        uint256 PRIVATE_KEY_BASE = 1;
        bytes32 hash = keccak256(abi.encodePacked("test"));

        address[] memory signers = new address[](4);
        for (uint256 i = 0; i < 4; i++) {
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);
        }

        bytes
            memory multisignatureBytes = hex"bb958903eb2617ebb142d54c20df2c4eb46159e2c717b0240037336418cb8ed359f4d1342c037dd7bec0deacdbba00fac2fa9f50a51865bbe474bc706175675e1bce51ad58a2b88a7215945005997f1eb39c0a701e2708af4831fdc6ade68ae6667b9e4c8e696ab698ae176b87fe9db80fd6c5c3a13c816e44959da9fa8e0aab0b1b8ad40a780540429c8374dd17b5ec151ed8465890f1480f23a81c53b379675f756464a70aa7525633e4b48cfa78d22e640d0c3bf24c68c37ef769bc33139ed0b31c3f7a7e121897535daa5e3d6c1dd95840c67bdaf7da4d9f8f76429faaa79ba95853c4b2132388739af7124ce1b9086b11502850b99f90b59cf9c56215bdfe46271c";

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            multisignatureBytes
        );
        require(valid == true, "valid == true");
        require(err == MultisignatureChecker.Error.Nil, "err == Nil");
    }

    function testMultiSignatureChecker_OneSignature() public view {
        uint256 PRIVATE_KEY = 1;
        address signer = vm.addr(PRIVATE_KEY);

        bytes32 hash = keccak256(abi.encodePacked("test"));
        console.logBytes32(hash);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY, hash);
        bytes memory signatureBytes = abi.encodePacked(r, s, v);
        console.logBytes(signatureBytes);
        console.logBytes32(s);
        console.logBytes32(r);
        console.log(v);

        require(signatureBytes.length == 65, "signatureBytes.length == 65");

        address[] memory signers = new address[](1);
        signers[0] = signer;

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            signatureBytes
        );
        require(valid == true, "valid == true");
        require(err == MultisignatureChecker.Error.Nil);
    }

    function testMultiSignatureChecker_FourSignatures() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](4);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 4; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);

            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }

        require(multisignatureBytes.length == 65 * 4, "multisignatureBytes.length == 65 * 4");

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            multisignatureBytes
        );
        require(valid == true, "valid == true");
        require(err == MultisignatureChecker.Error.Nil, "err == Nil");
    }

    function testMultiSignatureChecker_InvalidSignaturesLength() public pure {
        bytes32 hash = keccak256(abi.encodePacked("test"));

        address[] memory signers = new address[](1);
        signers[0] = vm.addr(101);

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            abi.encodePacked(hash)
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes, "err == InvalidSignaturesBytes");

        (valid, err) = MultisignatureChecker.isValidMultiSignature(signers, hash, bytes("1234567890"));
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes, "err == InvalidSignaturesBytes");

        bytes memory signature66 = bytes.concat(abi.encodePacked(hash), abi.encodePacked(hash), "1", "1");

        (valid, err) = MultisignatureChecker.isValidMultiSignature(signers, hash, signature66);
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes, "err == InvalidSignaturesBytes");

        (valid, err) = MultisignatureChecker.isValidMultiSignature(signers, hash, bytes(""));
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes, "err == InvalidSignaturesBytes");
    }

    function testMultiSignatureChecker_InvalidSignatureInMultisig() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](4);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;
        bytes32 b;

        for (uint256 i = 0; i < 4; i++) {
            (uint8 v, bytes32 r, ) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, b, v);
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);

            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            abi.encodePacked(multisignatureBytes)
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignature, "err == InvalidSignature");
    }

    function testMultiSignatureChecker_InvalidSignatureOfSigner() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](2);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 2; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }

        signers[0] = vm.addr(PRIVATE_KEY_BASE + 1);
        signers[1] = vm.addr(PRIVATE_KEY_BASE);

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidMultiSignature(
            signers,
            hash,
            multisignatureBytes
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSigner, "err == InvalidSignature");
    }

    // ====

    function testMultiSignatureChecker_Weighted_OneSignature() public pure {
        uint256 PRIVATE_KEY = 1000;
        address signer = vm.addr(PRIVATE_KEY);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY, hash);
        bytes memory signatureBytes = abi.encodePacked(r, s, v);

        require(signatureBytes.length == 65, "signatureBytes.length == 65");

        address[] memory signers = new address[](1);
        signers[0] = signer;

        uint256[] memory weights = new uint256[](1);
        weights[0] = 10;

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            10,
            hash,
            signatureBytes
        );
        require(valid == true, "valid == true");
        require(err == MultisignatureChecker.Error.Nil, "err == Nil");
    }

    function testMultiSignatureChecker_Weighted_FourSignatures() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](4);
        uint256[] memory weights = new uint256[](4);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 4; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);
            weights[i] = 10;

            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }

        require(multisignatureBytes.length == 65 * 4, "multisignatureBytes.length == 65 * 4");

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            30,
            hash,
            multisignatureBytes
        );
        require(valid == true, "valid == true");
        require(err == MultisignatureChecker.Error.Nil, "err == Nil");
    }

    function testMultiSignatureChecker_Weighted_InvalidSignaturesLength() public pure {
        bytes32 hash = keccak256(abi.encodePacked("test"));

        address[] memory signers = new address[](1);
        signers[0] = vm.addr(101);

        uint256[] memory weights = new uint256[](1);
        weights[0] = 10;

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            10,
            hash,
            abi.encodePacked(hash)
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes);

        (valid, err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            10,
            hash,
            bytes("1234567890")
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes);

        bytes memory signature66 = bytes.concat(abi.encodePacked(hash), abi.encodePacked(hash), "1", "1");

        (valid, err) = MultisignatureChecker.isValidWeightedMultiSignature(signers, weights, 10, hash, signature66);
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes);

        (valid, err) = MultisignatureChecker.isValidWeightedMultiSignature(signers, weights, 10, hash, bytes(""));
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignaturesBytes, "err == InvalidSignaturesBytes");
    }

    function testMultiSignatureChecker_Weighted_InvalidSignatureInMultisig() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](4);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;
        bytes32 b;

        uint256[] memory weights = new uint256[](4);

        for (uint256 i = 0; i < 4; i++) {
            (uint8 v, bytes32 r, ) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, b, v);
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);
            weights[i] = 10;

            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            30,
            hash,
            abi.encodePacked(multisignatureBytes)
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSignature, "err == InvalidSignature");
    }

    function testMultiSignatureChecker_Weighted_InvalidSignatureOfSigner() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](2);
        uint256[] memory weights = new uint256[](2);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 2; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
            weights[i] = 10;
        }

        signers[0] = vm.addr(PRIVATE_KEY_BASE + 1);
        signers[1] = vm.addr(PRIVATE_KEY_BASE);

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            10,
            hash,
            multisignatureBytes
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidSigner, "err == InvalidSigner");
    }

    function testMultiSignatureChecker_Weighted_LessThanThreshold() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](2);
        uint256[] memory weights = new uint256[](2);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 2; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
            weights[i] = 10;
            signers[i] = vm.addr(PRIVATE_KEY_BASE + i);
        }

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            100,
            hash,
            multisignatureBytes
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.WeightsSumLessThanThreshold, "err == WeightsSumLessThanThreshold");
    }

    function testMultiSignatureChecker_Weighted_InvalidNumberOfWeights() public pure {
        uint256 PRIVATE_KEY_BASE = 1000;
        address[] memory signers = new address[](2);
        uint256[] memory weights = new uint256[](1);

        bytes32 hash = keccak256(abi.encodePacked("test"));

        bytes memory multisignatureBytes;

        for (uint256 i = 0; i < 2; i++) {
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(PRIVATE_KEY_BASE + i, hash);
            bytes memory signature = abi.encodePacked(r, s, v);
            multisignatureBytes = bytes.concat(multisignatureBytes, signature);
        }
        weights[0] = 1;

        signers[0] = vm.addr(PRIVATE_KEY_BASE + 1);
        signers[1] = vm.addr(PRIVATE_KEY_BASE);

        (bool valid, MultisignatureChecker.Error err) = MultisignatureChecker.isValidWeightedMultiSignature(
            signers,
            weights,
            10,
            hash,
            multisignatureBytes
        );
        require(valid == false, "valid == false");
        require(err == MultisignatureChecker.Error.InvalidArrayLength, "err == InvalidArrayLength");
    }
}
