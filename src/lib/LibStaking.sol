// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {IGateway} from "../interfaces/IGateway.sol";
import {LibSubnetActorStorage, SubnetActorStorage} from "./LibSubnetActorStorage.sol";
import {StakingReleaseQueue, StakingChangeSet, StakingChange, StakingOperation, StakingRelease, ValidatorSet, AddressStakingReleases} from "../structs/Subnet.sol";
import {WithdrawExceedingCollateral, CannotConfirmFutureChanges, NoCollateralToWithdraw} from "../errors/IPCErrors.sol";

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

library LibAddressStakingReleases {
    /// @notice Add new release to the storage. Caller makes sure the release.releasedAt is ordered
    /// @notice in ascending order. This method does not do checks on this.
    function push(AddressStakingReleases storage self, StakingRelease memory release) internal {
        uint16 length = self.length;
        uint16 nextIdx = self.startIdx + length;

        self.releases[nextIdx] = release;
        self.length = length + 1;
    }

    /// @notice Perform compaction on releases, i.e. aggregates the amount that can be released
    /// @notice and removes them from storage. Returns the total amount to release and the new
    /// @notice number of pending releases after compaction.
    function compact(AddressStakingReleases storage self) internal returns (uint256, uint16) {
        uint16 length = self.length;
        if (self.length == 0) {
            revert NoCollateralToWithdraw();
        }

        uint16 i = self.startIdx;
        uint16 newLength = length;
        uint256 amount = 0;
        while (i < length) {
            StakingRelease memory release = self.releases[i];

            // releases are ordered ascending by releaseAt, no need to check
            // further as they will still be locked.
            if (release.releaseAt > block.number) {
                break;
            }

            amount += release.amount;
            delete self.releases[i];

            unchecked {
                i++;
                newLength--;
            }
        }

        self.startIdx = i;
        self.length = newLength;

        return (amount, newLength);
    }
}

/// The util library for `StakingReleaseQueue`
library LibStakingRelaseQueue {
    using LibAddressStakingReleases for AddressStakingReleases;

    event NewCollateralRelease(address validator, uint256 amount, uint256 releaseBlock);

    function setLockDuration(StakingReleaseQueue storage self, uint256 blocks) internal {
        self.lockingDuration = blocks;
    }

    /// @notice Set the amount and time for release collateral
    function addNewRelease(StakingReleaseQueue storage self, address validator, uint256 amount) internal {
        uint256 releaseAt = block.number + self.lockingDuration;
        StakingRelease memory release = StakingRelease({releaseAt: releaseAt, amount: amount});

        self.releases[validator].push(release);

        emit NewCollateralRelease({validator: validator, amount: amount, releaseBlock: releaseAt});
    }

    /// @notice Validator claim the available collateral that are released
    function claim(StakingReleaseQueue storage self, address validator) internal {
        (uint256 amount, uint16 newLength) = self.releases[validator].compact();

        if (newLength == 0) {
            delete self.releases[validator];
        }

        SubnetActorStorage storage s = LibSubnetActorStorage.appStorage();
        IGateway(s.ipcGatewayAddr).releaseStake(amount);
    }
}

/// The util library for `ValidatorSet`
library LibValidatorSet {
    /// @notice Get the confirmed collateral of the validator.
    function getConfirmedCollateral(
        ValidatorSet storage validators,
        address validator
    ) internal view returns (uint256 collateral) {
        collateral = validators.validators[validator].confirmedCollateral;
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

    function confirmDeposit(ValidatorSet storage validators, address validator, uint256 amount) internal {
        validators.validators[validator].confirmedCollateral += amount;
    }

    function confirmWithdraw(ValidatorSet storage validators, address validator, uint256 amount) internal {
        validators.validators[validator].confirmedCollateral -= amount;
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
                s.validatorSet.confirmWithdraw(validator, amount);
                s.releaseQueue.addNewRelease(validator, amount);
            } else {
                s.validatorSet.confirmDeposit(validator, amount);
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
