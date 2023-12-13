// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

/// @title Pausable Library
/// @notice Abstract contract that enables contract to pause marked operations
abstract contract Pausable {
    bytes32 private constant NAMESPACE = keccak256("pausable.lib.diamond.storage");

    struct PausableStorage {
        bool paused;
    }

    error AlreadyPaused();

    modifier whenNotPaused() {
        PausableStorage storage s = pausableStorage();
        if (s.paused) revert AlreadyPaused();
        _;
    }

    /// @notice sets if to pause the contract
    function isPausabled() external view returns(bool) {
        PausableStorage storage s = pausableStorage();
        return s.paused;
    }

    /// @notice sets if to pause the contract
    function setPausable(bool paused) internal {
        PausableStorage storage s = pausableStorage();
        s.paused = paused;
    }

    /// @notice get the storage slot
    function pausableStorage() private pure returns (PausableStorage storage ds) {
        bytes32 position = NAMESPACE;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            ds.slot := position
        }
        return ds;
    }
}
