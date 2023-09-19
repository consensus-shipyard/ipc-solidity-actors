// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {SubnetID, IPCAddress} from "./Subnet.sol";

/// @notice The parent finality for IPC parent at certain height.
struct ParentFinality {
    uint256 height;
    bytes32 blockHash;
}

/// @title BottomUpCheckpoint struct
/// @author LimeChain team
struct BottomUpCheckpoint {
    SubnetID source;
    uint64 epoch;
    uint256 fee;
    CrossMsg[] crossMsgs;
    ChildCheck[] children;
    bytes32 prevHash;
    bytes proof;
}

/// @notice A bottom-up checkpoint struct.
// TODO: Remove old BottomUpCheckpoint and update all the codebase.
struct BottomUpCheckpointNew {
    /// @dev Child subnet ID, for replay protection from other subnets where the exact same validators operate.
    /// Alternatively it can be appended to the hash before signing, similar to how we use the chain ID.
    SubnetID subnetID;
    /// @dev The height of the child subnet at which this checkpoint was cut.
    /// Has to follow the previous checkpoint by bottom_up_checkpoint_period
    uint64 blockHeight;
    /// @dev The ID of the validator set which is going to sign the next checkpoint.
    /// This one expected to be signed by the ID reported in the previous checkpoint.
    /// 0 could mean "no change".
    uint64 nextConfigurationNumber;
    /// @dev Some kind of hash over the bottom-up messages.
    /// By not including cross messages here directly, we can be compatible with IPLD Resolver based
    /// approach where the messages are fetched with Bitswap and provided by Fendermint, or the full-fat
    /// approach we need with Lotus, where the messages are part of the relayed transaction.
    bytes32 crossMessagesHash;
}

struct TopDownCheckpoint {
    uint64 epoch;
    CrossMsg[] topDownMsgs;
}

struct ChildCheck {
    SubnetID source;
    bytes32[] checks;
}

/**
 * @dev The goal of `wrapped` flag is to signal that a cross-net message should be sent as-is without changes to the destination.
 *
 * IMPORTANT: This is not currently used but it is a basic primitive required for atomic execution.
 */
struct CrossMsg {
    StorableMsg message;
    bool wrapped;
}

struct StorableMsg {
    IPCAddress from;
    IPCAddress to;
    uint256 value;
    uint64 nonce;
    bytes4 method;
    bytes params;
}
