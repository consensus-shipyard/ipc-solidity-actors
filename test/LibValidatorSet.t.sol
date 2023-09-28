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

    function test_validatorSet_noPriorActiveValidators() public {
        validators.activeLimit = 2;

        validators.confirmDeposit(address(1), 50);
        validators.confirmDeposit(address(2), 100);

        require(validators.isActiveValidator(address(1)), "address 1 should be active");
        require(validators.isActiveValidator(address(2)), "address 2 should be active");
        require(validators.waitingValidators.getSize() == 0, "waiting validators should be empty");
        require(validators.activeValidators.getSize() == 2, "active validators size should be 2");
    }

    function test_validatorSet_activeValidatorDepositCollateral() public {
        validators.activeLimit = 100;

        for (uint160 i = 1; i <= 100; i++) {
            validators.confirmDeposit(address(i), i);
            require(validators.isActiveValidator(address(i)), "address should be active");
        }
        require(validators.waitingValidators.getSize() == 0, "waiting validators should be empty");
        require(validators.activeValidators.getSize() == 100, "active validators size should be 100");

        validators.confirmDeposit(address(1), 100);

        for (uint160 i = 1; i < 100; i++) {
            validators.activeValidators.pop(validators);
        }
    
        (address maxAddress, uint256 maxCollateral) = validators.activeValidators.min(validators);
        require(maxAddress == address(1), "address 1 should be the last validator");
        require(maxCollateral == 101, "address 1 collateral incorrect");
    }

    /// @notice Exceeding active validator limit and there is no waiting validators
    /// Setup: 100 active validators with collateral less than 101. New validator 
    ///        deposits 101.
    /// Expected: 100 active validators, max active deposit is 101. 1 waiting validator, collateral 1
    function test_validatorSet_exceedingActiveLimitNoWaiting() public {
        validators.activeLimit = 100;

        for (uint160 i = 1; i <= 100; i++) {
            validators.confirmDeposit(address(i), i);
            require(validators.isActiveValidator(address(i)), "address should be active");
        }

        validators.confirmDeposit(address(101), 101);

        /// check waiting validator
        require(!validators.activeValidators.contains(address(1)), "address 1 should not be active");
        require(validators.waitingValidators.contains(address(1)), "address 1 should be waiting");
        require(validators.waitingValidators.getSize() == 1, "waiting validators should only have 1");
        
        // check new active validators
        for (uint160 i = 1; i < 100; i++) {
            validators.activeValidators.pop(validators);
        }
    
        (address maxAddress, uint256 maxCollateral) = validators.activeValidators.min(validators);
        require(maxAddress == address(101), "address 101 should be the last validator");
        require(maxCollateral == 101, "address 101 collateral not 101");
    }

    /// @notice Exceeding active validator limit and there are waiting validators
    /// Setup: 100 active validators with collateral btw 2 to 102. 5 waiting validators with collateral 1.
    ///        Incoming validator is not active validator nor waiting validator with collateral 1000
    /// Expected: 100 active validators, max active deposit is 1000. 6 waiting validator, collateral 1 or 2
    function test_validatorSet_exceedingActiveLimitWithWaitingI() public {
        // setup
        validators.activeLimit = 100;

        for (uint160 i = 2; i <= 101; i++) {
            validators.confirmDeposit(address(i), i);
            require(validators.isActiveValidator(address(i)), "address should be active");
        }

        for (uint160 i = 102; i <= 106; i++) {
            validators.confirmDeposit(address(i), 1);
            require(!validators.isActiveValidator(address(i)), "address should not be active");
        }

        // new validator
        validators.confirmDeposit(address(1000), 1000);
        
        // check expected result

        /// check waiting validator
        require(validators.waitingValidators.getSize() == 6, "waiting validators should only have 6");
        require(!validators.activeValidators.contains(address(2)), "address 2 should not be active");
        require(validators.waitingValidators.contains(address(2)), "address 2 should be waiting");

        (address maxAddress, uint256 maxCollateral) = validators.waitingValidators.max(validators);
        require(maxAddress == address(2), "address 2 should be the max collateral validtor");
        require(maxCollateral == 2, "address 2 should have max collateral 2");

        // check new active validators
        for (uint160 i = 1; i < 100; i++) {
            validators.activeValidators.pop(validators);
        }
        (maxAddress, maxCollateral) = validators.activeValidators.min(validators);
        require(maxAddress == address(1000), "address 1000 should be the last validator");
        require(maxCollateral == 1000, "address 1000 collateral not 1000");
    }
}
