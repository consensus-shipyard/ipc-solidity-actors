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
}
