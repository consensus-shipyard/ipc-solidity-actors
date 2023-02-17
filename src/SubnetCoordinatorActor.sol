// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./structs/Checkpoint.sol";
import "./structs/Postbox.sol";
import "./enums/Status.sol";

contract SubnetCoordinatorActor {
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint256 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint256 constant MAX_NONCE = type(uint256).max;

    /// @notice ID of the current network
    SubnetID private networkName;

    /// @notice Number of active subnets spawned from this one
    uint64 private totalSubnets;

    /// @notice Minimum stake required to create a new subnet
    uint256 private minStake;

    /// @notice List of subnets
    /// SubnetID => Subnet
    mapping(bytes => Subnet) private subnets;

    /// @notice Checkpoint period in number of epochs for the subnet
    uint64 private checkPeriod;

    /// @notice Checkpoint templates in the SCA per epoch
    mapping(int256 => Checkpoint) private checkpoints;

    /// @notice Stores information about the list of messages and child msgMetas being propagated in checkpoints to the top of the hierarchy.
    /// CrossMsgs => CrossMsgs
    mapping(bytes => CrossMsgs) private checkMsgRegistry;

    uint256 private lastPostboxId;
    /// @notice Postbox keeps track for an EOA of all the cross-net messages triggered by
    /// an actor that need to be propagated further through the hierarchy.
    /// postbox id => PostBoxItem
    mapping(uint256 => PostBoxItem) private postbox;

    /// @notice Latest nonce of a cross message sent from subnet.
    uint256 private nonce;

    /// @notice Nonce of bottom-up messages for msgMeta received from checkpoints.
    /// This nonce is used to mark with a nonce the metadata about cross-net
    /// messages received in checkpoints. This is used to order the
    /// bottom-up cross-net messages received through checkpoints.
    uint256 private bottomUpNonce;

    /// @notice Queue of bottom-up cross-net messages to be applied.
    /// bottom up nonce => CrossMsgMeta
    mapping(uint256 => CrossMsgMeta) private bottomUpMsgMeta;

    /// @notice AppliedNonces keep track of the next nonce of the message to be applied.
    /// This prevents potential replay attacks.
    uint256 private appliedBottomUpNonce;
    uint256 private appliedTopDownNonce;

    constructor(string memory _networkName, uint64 _checkpointPeriod) {
        networkName = SubnetID(_networkName, address(0));
        minStake = MIN_COLLATERAL_AMOUNT;
        checkPeriod = _checkpointPeriod > DEFAULT_CHECKPOINT_PERIOD
            ? _checkpointPeriod
            : DEFAULT_CHECKPOINT_PERIOD;
        appliedBottomUpNonce = MAX_NONCE;
    }
}
