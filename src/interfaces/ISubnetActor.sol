// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {BottomUpCheckpoint, CrossMsg} from "../structs/Checkpoint.sol";
import {FvmAddress} from "../structs/FvmAddress.sol";

/// @title Subnet Actor interface
/// @author LimeChain team
interface ISubnetActor {
    /// Called by peers looking to join a subnet.
    ///
    /// It implements the basic logic to onboard new peers to the subnet.
    function join(string calldata networkAddr, FvmAddress calldata workerAddr) external payable;

    /// Called by peers looking to leave a subnet.
    function leave() external;

    /// Unregister the subnet from the hierarchy, making it no longer discoverable.
    function kill() external;

    /// Tracks the accumulated rewards for each validator.
    function reward(uint256 amount) external;

    /// Executes the checkpoint if it is valid.
    /// It triggers the commitment of the checkpoint, 
    /// the execution of related cross-net messages, 
    /// and any other side-effects that need to be triggered
    /// by the checkpoint
    function submitCheckpoint(
        address[] calldata signatories,
        BottomUpCheckpoint calldata checkpoint,
        bytes calldata signatures,
        CrossMsg[] calldata messages
    ) external;
}
