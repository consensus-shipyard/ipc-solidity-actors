// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {MinPQ, LibMinPQ} from "../src/lib/priority/LibMinPQ.sol";
import {LibValidatorSet} from "../src/lib/LibStaking.sol";
import {ValidatorSet} from "../src/structs/Subnet.sol";

contract LibMinPQTest is Test {
    using LibValidatorSet for ValidatorSet;
    using LibMinPQ for MinPQ;

    MinPQ private minPQ;
    ValidatorSet private validators;

    function test_minPQBasic() public {
        require(minPQ.getSize() == 0, "initial pq size not 0");

        address addr = address(1);
        validators.confirmDeposit(addr, 100);

        minPQ.insert(validators, addr);

        require(minPQ.getSize() == 1, "size not correct");
        (address minAddress, uint256 minValue) = minPQ.min(validators);
        require(minAddress == addr, "address not correct");
        require(minValue == 100, "min collateral correct");

        addr = address(2);
        validators.confirmDeposit(addr, 50);

        minPQ.insert(validators, addr);

        require(minPQ.getSize() == 2, "size not 2");
        (minAddress, minValue) = minPQ.min(validators);
        require(minAddress == addr, "address not 2");
        require(minValue == 50, "min collateral 50");
    }

    function test_minPQInsertAndPop() public {
        require(minPQ.getSize() == 0, "initial pq size not 0");

        uint256 total = 100;
        for (uint256 i = 1; i <= total; i++) {
            address addr = address(uint160(i));
            validators.confirmDeposit(addr, 100 * i);
        }

        uint256 size = 1;
        address minAddress;
        uint256 minValue;

        for (uint256 i = total; i > 0; i--) {
            address addr = address(uint160(i));

            minPQ.insert(validators, addr);

            require(minPQ.getSize() == size, "size not correct");
            (minAddress, minValue) = minPQ.min(validators);

            require(minAddress == addr, "address not correct");
            require(minValue == 100 * i, "min collateral not correct");

            size++;
        }

        size = total;
        for (uint256 i = 1; i <= total; i++) {
            address addr = address(uint160(i));

            (minAddress, minValue) = minPQ.min(validators);
            require(minAddress == addr, "address not correct");
            require(minValue == 100 * i, "min collateral correct");
            require(minPQ.getSize() == size, "size not correct");

            minPQ.pop(validators);
            size--;
        }
    }
}
