// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IGateway} from "../interfaces/IGateway.sol";
import {LibSubnetActorStorage, SubnetActorStorage} from "./LibSubnetActorStorage.sol";
import {StakingReleaseQueue, StakingChangeSet, StakingChange, StakingOperation, StakingRelease, ValidatorSet} from "../structs/Subnet.sol";
import {WithdrawExceedingCollateral} from "../errors/IPCErrors.sol";

/// The util library for `StakingChangeSet`
library LibStakingChangeSet {
    /// @notice Perform upsert operation to the withdraw changes, return total value to withdraw
    /// @notice of the validator.
    /// Each insert will increment the configuration number by 1, update will not.
    function upsertWithdraw(
        StakingChangeSet storage changes,
        address validator,
        uint256 amount
    ) internal pure returns (uint256 total) {
        require(false, "not implemented");

        // Sh! Silent the warning now. Will remove once implemented;
        changes;
        validator;
        amount;

        total = 0;
    }

    /// @notice Perform upsert operation to the deposit changes
    /// Each insert will increment the configuration number by 1, update will not.
    function upsertDeposit(StakingChangeSet storage changes, address validator, uint256 amount) internal pure {
        require(false, "not implemented");

        // Sh! Silent the warning now. Will remove once implemented;
        changes;
        validator;
        amount;
    }

    /// @notice Check if there are any changes
    function isEmpty(StakingChangeSet storage changes) internal view returns (bool) {
        return changes.totalChanges == 0;
    }

    /// @notice Get the starting configuration number in the change set
    function startConfigurationNumber(StakingChangeSet storage changes) internal view returns (uint64) {
        return changes.nextConfigurationNumber - changes.totalChanges;
    }

    /// @notice Get the change at configuration number
    function getChange(
        StakingChangeSet storage changes,
        uint64 configurationNumber
    ) internal view returns (StakingChange storage) {
        return changes.changes[configurationNumber];
    }
}

/// The util library for `StakingReleaseQueue`
library LibStakingRelaseQueue {
    function setLockDuration(StakingReleaseQueue storage queue, uint256 blocks) internal {
        queue.lockingDuration = blocks;
    }

    /// @notice Set the amount and time for release collateral
    function addNewRelease(StakingReleaseQueue storage queue, address validator, uint256 amount) internal {
        uint256 releaseBlock = block.number + queue.lockingDuration;
        StakingRelease memory release = StakingRelease({releaseAt: releaseBlock, amount: amount});

        queue.releases[validator].push(release);
    }

    /// @notice Validator claim the collateral that are released
    function claim(StakingReleaseQueue storage queue, address validator, uint256 amount) internal pure {
        require(false, "not implemented yet");

        // Sh! Silent the warning now. Will remove once implemented;
        validator;
        amount;
        queue;
    }
}

/// The util library for `ValidatorSet`
library LibValidatorSet {
    /// @notice Get the collateral of the validator.
    function getCollateral(
        ValidatorSet storage validators,
        address validator
    ) internal view returns (uint256 collateral) {
        collateral = validators.validators[validator].collateral;
    }

    /// @notice Validator increases its collateral by amount.
    function deposit(ValidatorSet storage validators, address validator, uint256 amount) internal {
        validators.validators[validator].collateral += amount;
    }

    /// @notice Validator reduces its collateral by amount.
    function withdraw(ValidatorSet storage validators, address validator, uint256 amount) internal {
        validators.validators[validator].collateral -= amount;
    }
}

library LibStaking {
    using LibStakingRelaseQueue for StakingReleaseQueue;
    using LibStakingChangeSet for StakingChangeSet;
    using LibValidatorSet for ValidatorSet;

    /// @notice Deposit into the collateral
    function deposit(address validator, uint256 amount) internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();

        s.changeSet.upsertDeposit(validator, amount);
        IGateway(s.ipcGatewayAddr).addStake{value: amount}();
    }

    /// @notice Withdraw `msg.value` amount of collateral by `msg.sender`
    function withdraw() internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();

        uint256 totalWithdraw = s.changeSet.upsertWithdraw(msg.sender, msg.value);

        if (s.validatorSet.getCollateral(msg.sender) < totalWithdraw) {
            revert WithdrawExceedingCollateral();
        }
    }

    /// @notice Confirm the changes in bottom up checkpoint submission, only call this in bottom up checkpoint execution.
    function confirmChange() internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();
        StakingChangeSet storage changeSet = s.changeSet;

        uint64 start = changeSet.startConfigurationNumber();
        uint64 end = changeSet.nextConfigurationNumber;
        for (uint64 i = start; i < end; ) {
            StakingChange storage change = changeSet.getChange(i);
            address validator = change.validator;
            uint256 amount = change.amount;

            if (change.op == StakingOperation.Withdraw) {
                s.validatorSet.withdraw(validator, amount);
                s.releaseQueue.addNewRelease(validator, amount);
            } else {
                s.validatorSet.deposit(validator, amount);
            }

            unchecked {
                i++;
            }
        }
    }
}
