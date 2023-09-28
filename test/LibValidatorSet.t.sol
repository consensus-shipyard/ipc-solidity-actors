// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {MaxPQ, LibMaxPQ} from "../src/lib/priority/LibMaxPQ.sol";
import {MinPQ, LibMinPQ} from "../src/lib/priority/LibMinPQ.sol";
import {LibValidatorSet} from "../src/lib/LibStaking.sol";
import {ValidatorSet} from "../src/structs/Subnet.sol";

contract LibValidatorSetTest is Test {
    using LibValidatorSet for ValidatorSet;
    using LibMaxPQ for MaxPQ;
    using LibMinPQ for MinPQ;

    ValidatorSet private validators;

    function test_noPriorActiveValidators() public {
        validators.activeLimit = 2;

        validators.confirmDeposit(address(1), 50);
        validators.confirmDeposit(address(2), 100);

        require(validators.isActiveValidator(address(1)), "address 1 should be active");
        require(validators.isActiveValidator(address(2)), "address 2 should be active");
        require(validators.waitingValidators.getSize() == 0, "waiting validators should be empty");
        require(validators.activeValidators.getSize() == 0, "active validators size should be 2");
    }
}
