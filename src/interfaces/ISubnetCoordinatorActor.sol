
interface ISubnetCoordinatorActor {
    // Register expects as source the address of the subnet actor of
    // the subnet that wants to be registered. The message's `value`
    // is the subnet's collateral and must exceed the `CollateralThreshold`.
    // This functions activates the subnet. From then on, other
    // subnets in the system are allowed to interact with it and the
    // subnet can start commtting its checkpoints.
    //
    // - methodNum: 2
    // - allowed callers: subnet actor addresses.
    // - impacted state: It updates `TotalSubnets` and initializes
    // a new `Active` subnet in the `Subnets` HAMT.
    // - side-effect message triggered: none
    function Register() external;

    // AddCollateral expects as source the address of the subnet actor
    // for which the collateral wants to be added.  Its `value` should
    // include the amount of collateral to be added for the subnet.
    //
    // - methodNum: 3
    // - allowed callers: subnet actor addresses.
    // - impacted state: Updates the value of `Collateral` for the
    //   subnet that called the method.
    // - side-effect message triggered: none
    function AddCollateral() external;

    // ReleaseCollateral expects as source the address of the subnet actor
    // for which the collateral should be released. It triggers a transfer message
    // to the subnet actor returning the corresponding collateral.
    //
    // - methodNum: 4
    // - allowed callers: subnet actor addresses.
    // - impacted state: Updates the value of `Collateral` for the
    //   subnet that initiated the message call.
    // - side-effect message triggered:
    //    - Send() message to the subnet actor that called the method including
    //    the amount of collateral released in its `value`
    function ReleaseCollateral(uint256 _tokenAmount) external;

    // Kill expects as source the address of the subnet actor to be killed.
    // This function can only be executed if no collateral or circulating
    // supply is left for the subnet (i.e. balance = 0).
    //
    // - methodNum: 5
    // - allowed callers: subnet actor addresses.
    // - impacted state: Removes the subnet information for the subnet that
    //   called the method from the `Subnets` HAMT, and decrements `TotalSubnets`.
    // - side-effect message triggered: none
    // - invariants: The total balance of native tokens of a killed subnet should be zero·
    function Kill() external;

    // CommitChildCheckpoint expects as source the address of the subnet actor for which the
    // checkpoint is being committed. The function performs some basic checks
    // to ensure that checkpoint is valid and it persist it in the SCA state.
    //
    // - methodNum: 6
    // - allowed callers: subnet actor addresses.
    // - impacted state: Updates `Checkpoint` including in the checkpoint template
    //  for the current window the CID of the child checkpoint committed, and any outstanding
    //  `CrossMsgMeta` to be propagated further. It updates
    //  `Subnet.PrevCheckpoint` for the subnet calling the method. It adds new top-down or
    //  bottom-up messages to `Subnet.TopDownMsgs` and `BottomUpMsgMeta`, respectively.
    // - side-effect message triggered: none
    // - invariants:
    //   - The checkpoint is only accepted if `Subnet.PrevCheckpoint` and
    //    `Checkpoint.Epoch > Subnet.PreviousCheckpoint.Epoch` and `Subnet.Status = Active`
    //   - For bottom-up messages to be propagated, `sum(CrossMsgsMeta.Value) < Subnet.CircSupply`.
    // function CommitChildCheckpoint(ch Checkpoint)

    // Fund can be called by any user in a subnet and it injects
    // the `value` of native tokens included in the message to the source's address in
    // the child subnet given as argument.
    //
    // - methodNum: 7
    // - allowed callers: any account
    // - impacted state: Append the fund message to the `TopDownMsgs` of the Subnet. Update
    //   of `CircSupply` for the subnet specified as parameter in the method.
    // - side-effect message triggered:
    //   - ResolvePubKey() message to the address of account actor that called this method.
    // Fund(SubnetID)

    // Release can be called by any user in a subnet to release the amount
    // of native tokens included in `value` from its own address in the
    // subnet to the address in the parent.
    //
    // - methodNum: 8
    // - allowed callers: any account
    // - impacted state: Update `Checkpoint` to include in its `CrossMsgMeta` a
    //  `CrossMsgs` with this new release message and an updated `Value`.
    //  It also triggers an update of `CheckMsgsRegistry` with the updated `CrossMsgs`.
    // - side-effect message triggered:
    //   - ResolvePubKey() message to the address of account actor that called this method.
    //   - Send() message to the `BURNT_ACTOR` address with the `Value` included in the message
    //    to be burnt.
    // Release()

    // SendCross can be called by any user in the subnet to send
    // an arbitrary cross-net message to any other subnet in
    // the hierarchy.
    //
    // - methodNum: 9
    // - allowed callers: any account
    // - impacted state:
    //  - If Bottom-up message: update `Checkpoint` to include in its `CrossMsgMeta` a
    //  `CrossMsgs` with this new release message and an updated `Value`.
    //  It also triggers an update of `CheckMsgsRegistry` with the updated `CrossMsgs`.
    //  - If top-down message: Append the message to the `TopDownMsgs` of the next child subnet
    //  in the path. Update of `CircSupply` for the subnet specified as parameter in the method.
    // - side-effect message triggered:
    //   - ResolvePubKey() message to the address of account actor that called this method.
    //   - If bottom-up message: Send() message to the `BURNT_ACTOR` address with the
    //  `Value` included in the message to be burnt.
    // SendCross(msg CrossMsgParams)

    // ApplyMessage can only be called as an `ImplicitMessage` by
    // the `SystemActor` and is used to perform the execution of a
    // of cross-net messages in the subnet.
    //
    // This method is called when a cross-net message is found in a
    // validated block and needs to be executed.
    // - It determines the type of cross-net message
    // - It executes the message and trigger the corresponding state changes.
    // - And it updates the latest nonce applied for the type of message.
    //
    // - methodNum: 10
    // - allowed callers: system actor address (executed implicitly)
    // - impacted state:
    //   - If bottom-up message: Increment `AppliedBottomUpNonce` and update
    //     `TopDownMsgs` of the next child subnet in the path
    //     if the message need to be propagated further down.
    //   - If top-down message: Increment `AppliedBottomUpNonce` and update
    //     `TopDownMsgs` of the next child subnet in the path
    // - side-effect message triggered:
    //   - If message directed to current network: Send() the message being executed
    //   to the right address.
    //   - If top-down message: SubnetMint() to reward actor to mint new funds to
    //    be sent to the right address when executed.
    // - invariants:
    //   - A top-down message can only be executed if its nonce is `AppliedTopDownNonce+1`.
    //   - A bottom-up message can only be executed if its nonce is `AppliedBottomUpNonce ||
    //     AppliedBottomUpNonce+1`
    //    value
    // ApplyMessage(msg CrossMsgParams)

    // InitAtomicExec can be called by users to initiate an
    // atomic execution with some other subnet.
    //
    // - methodNum: 11
    // - allowed callers: any account
    // - impacted state: Update `AtomicExecRegistry` with the new execution
    // - side-effect message triggered:
    // InitAtomicExec(params AtomicExecParams)

    // SubmitAtomicExec has to be called by all participants in an
    // atomic execution to submit their results and trigger the
    // propagation of the output (or the abortion) of the execution
    // to the corresponding subnets.
    //
    // - methodNum: 12
    // - allowed callers: any account involved in the atomic execution
    // - impacted state: Update `AtomicExecRegistry` with the new
    //  output provided, and any required update to the `ExecState`.
    //  If the execution succeeds or is aborted a new message is
    //  appended to the `TopDownMsgs` of all the subnets involved.
    // - side-effect message triggered: none
    // - invariants:
    //   - All outputs should match and lead to the same CID for the
    //   execution to succeed and it shouldn't have been aborted.
    // SubmitAtomicExec(submit SubmitExecParams)

    // ReportMisbehavior is used to report a misbehavior from one
    // of the child subnets of the current network. This function
    // can send additional messages to the
    // `CheckEquivocation` method of the correponding subnet actor
    // to perform checks over the proof of misbehavior.
    // If the proof succeeds, the collateral for the subnet is slashed.
    //
    // - methodNum: 13
    // - allowed callers: any account
    // - impacted state:
    // - side-effect message triggered:
    // ReportMisbehavior(SubnetID, invalid []Block, valid []Block)

    // Save can be used by any user of the subnet to trigger the persistence
    // of the state of the subnet in any storage system (IPFS, Filecion, etc.).
    // This method returns the CID and URI to retrieve the snapshot. It also keeps
    // in the SCA state a map of all the available snapshot and the latest epoch they
    // persist.
    //
    // NOTE1: This method is WIP and the interface may suffer changes in
    // the future. Once FVM has native support for starting deals on-chain,
    // the actor should be able to handle the full end-to-end storage of the
    // snapshot.
    // NOTE2: We are considering the implementation of a protocol that performs
    // the storage of incremental snapshots.
    //
    // - methodNum: 13
    // - allowed callers: any account
    // - impacted state:
    // - side-effect message triggered:
    // Save() (Cid, URI)
}