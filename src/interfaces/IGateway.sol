// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Checkpoint.sol";
import "../structs/Subnet.sol";

/// @title Gateway interface
/// @author LimeChain team
interface IGateway {
    /// Register is called by subnet actors to put the required collateral
    /// and register the subnet to the hierarchy.
    function register() external payable;

    /// AddStake adds stake to the collateral of a subnet.
    function addStake() external payable;

    /// Release stake recovers some collateral of the subnet
    function releaseStake(uint amount) external;

    // Kill propagates the kill signal from a subnet actor to unregister it from th
    /// hierarchy.
    function kill() external;

    /// CommitChildCheck propagates the commitment of a checkpoint from a child subnet,
    /// process the cross-messages directed to the subnet.
    function commitChildCheck(Checkpoint memory checkpoint)
        external
        returns (uint);

    /// SendCross sends an arbitrary cross-message to other subnet in the hierarchy.
    ///
    /// If the message includes any funds they need to be burnt (like in Release)
    /// before being propagated to the corresponding subnet.
    /// The circulating supply in each subnet needs to be updated as the message passes through them.
    ///
    /// Params expect a raw message without any subnet context (the IPC address is
    /// included in the message by the actor). Only actors are allowed to send arbitrary
    /// cross-messages as a side-effect of their execution. For plain token exchanges
    /// fund and release have to be used.
    function sendCross(SubnetID memory destination, CrossMsg memory crossMsg)
        external
        payable;
}
