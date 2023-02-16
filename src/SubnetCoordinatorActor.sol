// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

enum Status {
    Active,
    Inactive,
    Killed
}

struct SubnetID {
    string parent;
    address actor;
}

struct Subnet {
    SubnetID id;
    uint256 stake;
    mapping(uint256 => CrossMsg) topDownMsgs;
    uint256 nonce;
    uint256 circSupply;
    Status status;
    Checkpoint prevCheckpoint;
}

struct Checkpoint {
    CheckData data;
    bytes sig;
}

struct CheckData {
    SubnetID source;
    bytes tipSet;
    int256 epoch;
    bytes prevCheck; // Checkpoint
    ChildCheck[] children;
    CrossMsgMeta crossMsgs;
}

struct ChildCheck {
    SubnetID source;
    bytes[] checks;
}

struct CrossMsgMeta {
    bytes msgsCid;
    uint256 nonce;
    uint256 value;
    uint256 fee;
}

struct IPCAddress {
    SubnetID subnetId;
    address rawAddress;
}

struct StorableMsg {
    IPCAddress from;
    IPCAddress to;
    bytes4 method;
    bytes params;
    uint256 value;
    uint256 nonce;
}

struct CrossMsg {
    StorableMsg msg;
    bool wrapped;
}

struct CrossMsgs {
    CrossMsg[] msgs;
}

struct PostBoxItem {
    CrossMsg crossMsg;
    address[] owners;
}

uint constant DEFAULT_CHECKPOINT_PERIOD = 10;

contract SubnetCoordinatorActor {
    /// @notice ID of the current network
    SubnetID private networkName;

    /// @notice Number of active subnets spawned from this one
    uint256 private totalSubnets;

    /// @notice Minimum stake required to create a new subnet
    uint256 private minStake;
    
    /// @notice List of subnets
    /// SubnetID => Subnet
    mapping(bytes => Subnet) private subnets;

    /// @notice Checkpoint period in number of epochs for the subnet
    int256 private checkPeriod;

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

    constructor(string memory _networkName, int _checkpointPeriod) {}
}
