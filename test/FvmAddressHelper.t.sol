// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/lib/FvmAddressHelper.sol";
import {FvmAddress} from "../src/structs/FvmAddress.sol";

contract FvmAddressHelperTest is Test {
    using FvmAddressHelper for FvmAddress;

    function test_works() public pure {
        address addr = 0xeC2804Dd9B992C10396b5Af176f06923d984D90e;
        FvmAddress memory fvmAddr = FvmAddressHelper.from(addr);
        
        address extracted = fvmAddr.extractEvmAddress();
        require(extracted == addr, "addresses not equal");
    }

    function test_decode_works() public pure {
        address addr = 0x1A79385eAd0e873FE0C441C034636D3Edf7014cC;
        FvmAddress memory fAddr = FvmAddress.from(addr);
        require(false, string(fAddr.payload));
        
        bytes memory payload = bytes("0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000014000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000141a79385ead0e873fe0c441c034636d3edf7014cc000000000000000000000000");
        FvmAddress memory fvmAddr = FvmAddress({
            addrType: 4,
            payload: payload
        });
        
        address extracted = fvmAddr.extractEvmAddress();
        require(extracted == addr, "addresses not equal");
    }
}