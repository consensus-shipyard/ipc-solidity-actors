// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {LibValidatorSet} from "../LibStaking.sol";
import {ValidatorSet} from "../../structs/Subnet.sol";
import {PQ, LibPQ} from "./LibPQ.sol";

struct MinPQ {
    PQ inner;
}

/// The min index priority queue for staking
library LibMinPQ {
    using LibPQ for PQ;
    using LibValidatorSet for ValidatorSet;

    function getSize(MinPQ storage self) internal view returns (uint16) {
        return self.inner.size;
    }

    function contains(MinPQ storage self, address validator) internal view returns (bool) {
        return self.inner.contains(validator);
    }

    /// @notice Insert the validator address into this PQ.
    /// NOTE that caller should ensure the valdiator is not already in the queue.
    function insert(MinPQ storage self, ValidatorSet storage validators, address validator) internal {
        uint16 size = self.inner.size + 1;

        self.inner.addressToPos[validator] = size;
        self.inner.posToAddress[size] = validator;

        self.inner.size = size;

        uint256 confirmedCollateral = validators.getConfirmedCollateral(validator);
        swim(self, validators, size, confirmedCollateral);
    }

    /// @notice Pop the minimal value in the priority queue.
    /// NOTE that caller should ensure the queue is not empty!
    function pop(MinPQ storage self, ValidatorSet storage validators) internal {
        uint16 size = self.inner.size;

        self.inner.exchange(1, size);

        self.inner.size = size - 1;
        self.inner.del(size);

        uint256 value = self.inner.getCollateral(validators, 1);
        sink(self, validators, 1, value);
    }

    /// @notice Reheapify the heap when the collateral of a key has increased.
    /// NOTE that caller should ensure the queue is not empty.
    function increaseReheapify(
        MinPQ storage self,
        ValidatorSet storage validators,
        address validator,
        uint256 value
    ) internal {
        uint16 pos = self.inner.addressToPos[validator];
        sink(self, validators, pos, value);
    }

    /// @notice Reheapify the heap when the collateral of a key has decreased.
    /// NOTE that caller should ensure the queue is not empty.
    function descreaseReheapify(
        MinPQ storage self,
        ValidatorSet storage validators,
        address validator,
        uint256 value
    ) internal {
        uint16 pos = self.inner.addressToPos[validator];
        sink(self, validators, pos, value);
    }

    /// @notice Get the minimal value in the priority queue.
    /// NOTE that caller should ensure the queue is not empty!
    function min(MinPQ storage self, ValidatorSet storage validators) internal view returns (address, uint256) {
        address addr = self.inner.posToAddress[1];
        uint256 collateral = validators.getConfirmedCollateral(addr);
        return (addr, collateral);
    }

    /***************************************************************************
     * Heap internal helper functions, should not be called by external functions
     ****************************************************************************/
    function swim(MinPQ storage self, ValidatorSet storage validators, uint16 pos, uint256 value) internal {
        uint16 parentPos;
        uint256 parentCollateral;

        while (pos > 1) {
            parentPos = pos / 2;
            parentCollateral = self.inner.getCollateral(validators, parentPos);

            // parent collateral is not more than that of the current child, heap condition met.
            if (!firstValueLarger(parentCollateral, value)) {
                break;
            }

            self.inner.exchange(parentPos, pos);
            pos = parentPos;
        }
    }

    function sink(MinPQ storage self, ValidatorSet storage validators, uint16 pos, uint256 value) internal {
        uint16 childPos = pos * 2;
        bool firstLarger = false;
        uint256 childCollateral = 0;

        uint16 size = self.inner.size;

        while (childPos <= size) {
            if (childPos < size) {
                // select the min of the two children
                (firstLarger, childCollateral) = firstPosLarger(self, validators, childPos, childPos + 1);
                if (firstLarger) {
                    // this means the next child is actually smaller
                    childPos += 1;
                }
            } else {
                childCollateral = self.inner.getCollateral(validators, childPos);
            }

            // parent, current idx, is not more than its two children, min heap condition is met.
            if (!firstValueLarger(value, childCollateral)) {
                break;
            }

            self.inner.exchange(childPos, pos);
            pos = childPos;
            childPos = pos * 2;
        }
    }

    /// @notice Get the larger index of pos1 and pos2.
    function firstPosLarger(
        MinPQ storage self,
        ValidatorSet storage validators,
        uint16 pos1,
        uint16 pos2
    ) internal view returns (bool, uint256) {
        uint256 value1 = self.inner.getCollateral(validators, pos1);
        uint256 value2 = self.inner.getCollateral(validators, pos2);

        if (firstValueLarger(value1, value2)) {
            return (true, value1);
        }
        return (false, value2);
    }

    function firstValueLarger(uint256 v1, uint256 v2) internal pure returns (bool) {
        return v1 > v2;
    }
}
