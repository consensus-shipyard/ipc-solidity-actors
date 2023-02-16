// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
interface ISubnetActor {
    
    // It expects as `value` the amount of collateral the
    // source wants to stake to become part of the subnet.
    // It triggers all check to determine if the source is eligible
    // to become part of the subnet, and must propagate an `AddCollateral` message
    // to the SCA to trigger the registration.
    //
    // Join is also responsible to send a `Register` message to the SCA
    // whenever the `CollateralThreshold` is reached. This function can also
    // be used to AddCollateral for the subnet in the SCA. Additional
    // checks for this operation may be included. As a result of the
    // execution an `AddCollateral` message must be sent to the SCA
    // including the added collateral.
    //
    // - methodNum: 2
    // - allowed callers: any account.
    // - impacted state: increases `TotalCollateral` with the `value` provided
    // in the message and updates the `Collateral` for the source of the message.
    // It updates the `Status` of the subnet
    // - side-effect message triggered:
    //    - Register() to SCA `TotalCollateral > CollateralThreshold` and subnet
    //    not registered
    //    - AddCollateral() to SCA including the amount of collateral included
    //    in the value of the message.
    // - invariants:
    //    - `Status` is `Active` iff `TotalColateral > CollateralThreshold`.
    function Join() external;
    
    // Called by participants that want to leave the subnet. It triggers all
    // the checks to see if the source is eligible to leave the subnet.
    // This function must propagate a `ReleaseCollateral` message to the SCA.
    // The SCA will then release the corresponding stake of the validator in
    // a message to the subnet actor so the subnet actor can trigger a message
    // returning the funds to the leaving validtor.
    //
    // - methodNum: 3
    // - allowed callers: any validator with some collateral in the subnet.
    // - impacted state: reduces the `TotalCollateral` with the `value` provided
    // in the message and updates the `Collateral` for the source of the message.
    // It updates the `Status` of the subnet
    // - side-effect message triggered:
    //    - ReleaseCollateral() to SCA including the amount of collateral included
    //    in the value of the message.
    //    - Send() to the source of the message returning to the validator address
    //    the corresponding amount of tokens determined by the leaving policy.
    // - invariants:
    //    - `Status` is `Active` iff `TotalColateral > CollateralThreshold`.
    function Leave() external;
    
    // Kill performs all the sanity-checks required before completely
    // killing (e.g. check that all validators have released
    // their stake, or that there are no user-funds left in the subnet's
    // state). It must propagate a `Kill` message to the SCA
    // to unregister the subnet from the hierarchy, making it no longer
    // discoverable.
    //
    // - methodNum: 4
    // - allowed callers: any account
    // - impacted state: It sets the `Status` of the subnet to killed.
    // - side-effect message triggered:
    //    - ReleaseCollateral() to SCA including the amount of collateral included
    //    in the value of the message.
    //    - Send() to the source of the message returning to the validator address
    //    the corresponding amount of tokens determined by the leaving policy.
    function Kill() external;
    
    // SubmitCheckpoint is called by validators looking to submit a
    // signed checkpoint for propagation. This function performs all the
    // subnet-specific checks required for the final commitment of the
    // checkpoint in the SCA (e.g. in the reference implementation of
    // the SubnetActor, SubmitCheckpoints waits for more than 2/3 of the validators
    // to sign a valid checkpoint to propagate it to the SCA).
    //
    // This function must propagate a `CommitChildCheckpoint` message to the SCA
    // to commit the checkpoint.
    //
    // - methodNum: 5
    // - allowed callers: any validator with some collateral in the subnet.
    // - impacted state: It updates `CheckpointVotes` with the checkpoint and
    //   address of the validator submitting the checkpoint. It also updates
    //   `Checkpoints` if the signature policy to commit a checkpoint is fulfilled
    //   (+2/3 votes in the reference implementation).
    // - side-effect message triggered:
    //    - CommitChildCheckpoint() to SCA including the checkpoint that fulfilled
    //      the acceptance policy (e.g. +2/3 votes from validators)
    function SubmitCheckpoint(bytes32 checkpoint) external;
    
    // CheckEquivocation is called by the SCA to perform consensus-specific
    // checks when an agreement equivocation is reported. It receives as input
    // the chain of the last `finality_delay` blocks including the invalid
    // blocks and the chain with what is supposed to be the valid block.
    //
    // - methodNum: 6
    // - allowed callers: any account
    // - impacted state: none
    // - side-effect message triggered: none
    function CheckEquivocation(bytes[] calldata valid, bytes[] calldata invalid) external;
}