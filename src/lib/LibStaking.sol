// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IGateway} from "../interfaces/IGateway.sol";
import {LibSubnetActorStorage, SubnetActorStorage} from "./LibSubnetActorStorage.sol";
import {StakingReleaseQueue, StakingChangeSet, StakingChange, StakingOperation, StakingRelease, ValidatorSet} from "../structs/Subnet.sol";
import {WithdrawExceedingCollateral, CannotConfirmFutureChanges} from "../errors/IPCErrors.sol";

/// The util library for `StakingChangeSet`
library LibStakingChangeSet {
    event NewStakingRequest(StakingOperation op, address validator, uint256 amount, uint64 configurationNumber);

    /// @notice Perform upsert operation to the withdraw changes, return total value to withdraw
    /// @notice of the validator.
    /// Each insert will increment the configuration number by 1, update will not.
    function withdrawRequest(StakingChangeSet storage changes, address validator, uint256 amount) internal {
        uint64 configurationNumber = changes.nextConfigurationNumber;
        changes.nextConfigurationNumber = configurationNumber + 1;

        emit NewStakingRequest({
            op: StakingOperation.Deposit,
            validator: validator,
            amount: amount,
            configurationNumber: configurationNumber
        });
    }

    /// @notice Perform upsert operation to the deposit changes
    function depositRequest(StakingChangeSet storage changes, address validator, uint256 amount) internal {
        uint64 configurationNumber = changes.nextConfigurationNumber;
        changes.nextConfigurationNumber = configurationNumber + 1;

        emit NewStakingRequest({
            op: StakingOperation.Withdraw,
            validator: validator,
            amount: amount,
            configurationNumber: configurationNumber
        });
    }

    /// @notice Get the change at configuration number
    function getChange(
        StakingChangeSet storage changes,
        uint64 configurationNumber
    ) internal view returns (StakingChange storage) {
        return changes.changes[configurationNumber];
    }

    function purgeChange(StakingChangeSet storage changes, uint64 configurationNumber) internal {
        delete changes.changes[configurationNumber];
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
    function getActiveCollateral(
        ValidatorSet storage validators,
        address validator
    ) internal view returns (uint256 collateral) {
        collateral = validators.validators[validator].activeCollateral;
    }

    /// @notice Validator increases its total collateral by amount.
    function recordDeposit(ValidatorSet storage validators, address validator, uint256 amount) internal {
        validators.validators[validator].totalCollateral += amount;
    }

    /// @notice Validator reduces its total collateral by amount.
    function recordWithdraw(ValidatorSet storage validators, address validator, uint256 amount) internal {
        uint256 total = validators.validators[validator].totalCollateral;
        if (total < amount) {
            revert WithdrawExceedingCollateral();
        }

        total -= amount;
        validators.validators[validator].totalCollateral = total;
    }

    /// @notice Validator increases its active collateral by amount.
    function updateActive(
        ValidatorSet storage validators,
        address validator,
        uint256 amount,
        StakingOperation op
    ) internal {
        if (op == StakingOperation.Deposit) {
            validators.validators[validator].activeCollateral += amount;
        } else {
            validators.validators[validator].activeCollateral -= amount;
        }
    }
}

library LibStaking {
    using LibStakingRelaseQueue for StakingReleaseQueue;
    using LibStakingChangeSet for StakingChangeSet;
    using LibValidatorSet for ValidatorSet;

    event ConfigurantionNumberConfirmed(uint64 number);

    /// @notice Deposit the collateral
    function deposit(address validator, uint256 amount) internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();

        s.changeSet.depositRequest(validator, amount);
        s.validatorSet.recordDeposit(validator, amount);
    }

    /// @notice Withdraw the collateral
    function withdraw(address validator, uint256 amount) internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();

        s.changeSet.withdrawRequest(validator, amount);
        s.validatorSet.recordWithdraw(validator, amount);
    }

    /// @notice Confirm the changes in bottom up checkpoint submission, only call this in bottom up checkpoint execution.
    function confirmChange(uint64 configurationNumber) internal {
        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();
        StakingChangeSet storage changeSet = s.changeSet;

        if (configurationNumber >= changeSet.nextConfigurationNumber) {
            revert CannotConfirmFutureChanges();
        }

        uint64 start = changeSet.startConfigurationNumber;
        for (uint64 i = start; i <= configurationNumber; ) {
            StakingChange storage change = changeSet.getChange(i);
            address validator = change.validator;
            uint256 amount = change.amount;

            if (change.op == StakingOperation.Withdraw) {
                s.validatorSet.updateActive({validator: validator, amount: amount, op: StakingOperation.Withdraw});
                s.releaseQueue.addNewRelease(validator, amount);
            } else {
                s.validatorSet.updateActive({validator: validator, amount: amount, op: StakingOperation.Deposit});
                IGateway(s.ipcGatewayAddr).addStake{value: amount}();
            }

            changeSet.purgeChange(i);

            unchecked {
                i++;
            }
        }

        changeSet.startConfigurationNumber = configurationNumber + 1;

        emit ConfigurantionNumberConfirmed(configurationNumber);
    }
}
