// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./structs/Postbox.sol";
import "./enums/Status.sol";
import "./interfaces/ISubnetCoordinatorActor.sol";

contract SubnetCoordinatorActor is ISubnetCoordinatorActor {
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint256 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint256 constant MAX_NONCE = type(uint256).max;

    /// @notice ID of the current network
    SubnetID public networkName;

    /// @notice Number of active subnets spawned from this one
    uint64 public totalSubnets;

    /// @notice Minimum stake required to create a new subnet
    uint256 public minStake;

    /// @notice List of subnets
    /// SubnetID => Subnet
    mapping(bytes => Subnet) public subnets;

    /// @notice Checkpoint period in number of epochs for the subnet
    uint64 public checkPeriod;

    /// @notice Checkpoint templates in the SCA per epoch
    mapping(uint256 => Checkpoint) public checkpoints;

    /// @notice Stores information about the list of messages and child msgMetas being propagated in checkpoints to the top of the hierarchy.
    /// FIXME: refactor with custom getter and make it private?
    mapping(bytes => CrossMsg[]) public checkMsgRegistry;

    uint256 public lastPostboxId;
    /// @notice Postbox keeps track for an EOA of all the cross-net messages triggered by
    /// an actor that need to be propagated further through the hierarchy.
    /// postbox id => PostBoxItem
    mapping(uint256 => PostBoxItem) public postbox;

    /// @notice Latest nonce of a cross message sent from subnet.
    uint256 public nonce;

    /// @notice Nonce of bottom-up messages for msgMeta received from checkpoints.
    /// This nonce is used to mark with a nonce the metadata about cross-net
    /// messages received in checkpoints. This is used to order the
    /// bottom-up cross-net messages received through checkpoints.
    uint256 public bottomUpNonce;

    /// @notice Queue of bottom-up cross-net messages to be applied.
    /// bottom up nonce => CrossMsgMeta
    mapping(uint256 => CrossMsgMeta) public bottomUpMsgMeta;

    /// @notice AppliedNonces keep track of the next nonce of the message to be applied.
    /// This prevents potential replay attacks.
    uint256 public appliedBottomUpNonce;
    uint256 public appliedTopDownNonce;

    constructor(string memory _networkName, uint64 _checkpointPeriod) {
        networkName = SubnetID(_networkName, address(0));
        minStake = MIN_COLLATERAL_AMOUNT;
        checkPeriod = _checkpointPeriod > DEFAULT_CHECKPOINT_PERIOD
            ? _checkpointPeriod
            : DEFAULT_CHECKPOINT_PERIOD;
        appliedBottomUpNonce = MAX_NONCE;
    }

    /// Register is called by subnet actors to put the required collateral
    /// and register the subnet to the hierarchy.
    function register() external {
        revert("MethodNotImplemented");
    }

    /// AddStake adds stake to the collateral of a subnet.
    function addStake() external {
        revert("MethodNotImplemented");
    }

    /// Release stake recovers some collateral of the subnet
    function releaseStake(uint amount) external {
        revert("MethodNotImplemented");
    }

    // Kill propagates the kill signal from a subnet actor to unregister it from th
    /// hierarchy.
    function kill() external {
        revert("MethodNotImplemented");
    }

    /// CommitChildCheck propagates the commitment of a checkpoint from a child subnet,
    /// process the cross-messages directed to the subnet.
    function commitChildCheck(bytes memory checkpoint) external {
        revert("MethodNotImplemented");
    }

    /// Fund injects new funds from an account of the parent chain to a subnet.
    ///
    /// This functions receives a transaction with the FILs that want to be injected in the subnet.
    /// - Funds injected are frozen.
    /// - A new fund cross-message is created and stored to propagate it to the subnet. It will be
    /// picked up by miners to include it in the next possible block.
    /// - The cross-message nonce is updated
    function fund(bytes memory subnetId) external {
        revert("MethodNotImplemented");
    }

    /// Release creates a new check message to release funds in parent chain
    ///
    /// This function burns the funds that will be released in the current subnet
    /// and propagates a new checkpoint message to the parent chain to signal
    /// the amount of funds that can be released for a specific address.
    function release() external {
        revert("MethodNotImplemented");
    }

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
    function sendCross(
        bytes memory toSubnetId,
        bytes memory crossMsg
    ) external {
        revert("MethodNotImplemented");
    }

    /// ApplyMessage triggers the execution of a cross-subnet message validated through the consensus.
    ///
    /// This function can only be triggered using `ApplyImplicitMessage`, and the source needs to
    /// be the SystemActor. Cross messages are applied similarly to how rewards are applied once
    /// a block has been validated. This function:
    /// - Determines the type of cross-message.
    /// - Performs the corresponding state changes.
    /// - And updated the latest nonce applied for future checks.
    function applyMessage(bytes memory crossMsg) external {
        revert("MethodNotImplemented");
    }

    /// Whitelist a series of addresses as propagator of a cross net message.
    /// This is basically adding this list of addresses to the `PostBoxItem::owners`.
    /// Only existing owners can perform this operation.
    function whitelistPropagator(
        uint256 postboxId,
        address[] memory owners
    ) external {
        revert("MethodNotImplemented");
    }

    function propagate(uint256 postboxId) external {
        revert("MethodNotImplemented");
    }

    /// Commit the cross message to storage. It outputs a flag signaling
    /// if the committed messages was bottom-up and some funds need to be
    /// burnt or if a top-down message fee needs to be distributed.
    function commitCrossMessage(
        bytes memory crossMessage,
        uint256 feeAmount
    ) external {
        revert("MethodNotImplemented");
    }
}
