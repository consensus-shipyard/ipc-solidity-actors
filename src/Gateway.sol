// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./structs/Postbox.sol";
import "./enums/Status.sol";
import "./interfaces/IGateway.sol";
import "./interfaces/ISubnetActor.sol";

contract Gateway is IGateway {
    int64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint64 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant MAX_NONCE = type(uint64).max;

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
    int64 public checkPeriod;

    /// @notice Checkpoint templates in the SCA per epoch
    mapping(int64 => Checkpoint) public checkpoints;

    /// @notice Stores information about the list of messages and child msgMetas being propagated in checkpoints to the top of the hierarchy.
    /// FIXME: refactor with custom getter and make it private?
    mapping(bytes => CrossMsg[]) public checkMsgRegistry;

    uint256 public lastPostboxId;
    /// @notice Postbox keeps track for an EOA of all the cross-net messages triggered by
    /// an actor that need to be propagated further through the hierarchy.
    /// postbox id => PostBoxItem
    mapping(uint256 => PostBoxItem) public postbox;

    /// @notice Latest nonce of a cross message sent from subnet.
    uint64 public nonce;

    /// @notice Nonce of bottom-up messages for msgMeta received from checkpoints.
    /// This nonce is used to mark with a nonce the metadata about cross-net
    /// messages received in checkpoints. This is used to order the
    /// bottom-up cross-net messages received through checkpoints.
    uint64 public bottomUpNonce;

    /// @notice Queue of bottom-up cross-net messages to be applied.
    /// bottom up nonce => CrossMsgMeta
    mapping(uint64 => CrossMsgMeta) public bottomUpMsgMeta;

    /// @notice AppliedNonces keep track of the next nonce of the message to be applied.
    /// This prevents potential replay attacks.
    uint64 public appliedBottomUpNonce;
    uint64 public appliedTopDownNonce;

    constructor(string memory _networkName, int64 _checkpointPeriod) {
        networkName = SubnetID(_networkName, address(0));
        minStake = MIN_COLLATERAL_AMOUNT;
        checkPeriod = _checkpointPeriod > DEFAULT_CHECKPOINT_PERIOD
            ? _checkpointPeriod
            : DEFAULT_CHECKPOINT_PERIOD;
        appliedBottomUpNonce = MAX_NONCE;
    }

    function register() external payable {
        require(
            msg.value >= minStake,
            "call to register doesn't include enough funds"
        );

        SubnetID memory subnetId = SubnetID(networkName.parent, msg.sender);
        bytes memory subnetIdBytes = abi.encode(subnetId);

        Subnet storage subnet = subnets[subnetIdBytes];

        require(
            keccak256(subnetIdBytes) != keccak256(abi.encode(subnet.id)),
            "subnet is already registered"
        );

        subnet.id = subnetId;
        subnet.stake = msg.value;
        subnet.status = Status.Active;
        subnet.nonce = 0;
        subnet.circSupply = 0;

        totalSubnets += 1;
    }

    function addStake() external payable {
        require(msg.value > 0, "no stake to add");

        SubnetID memory subnetId = SubnetID(networkName.parent, msg.sender);
        bytes memory subnetIdBytes = abi.encode(subnetId);

        Subnet storage subnet = subnets[subnetIdBytes];

        require(
            keccak256(subnetIdBytes) == keccak256(abi.encode(subnet.id)),
            "subnet is not registered"
        );

        subnet.stake += msg.value;
    }

    function releaseStake(uint amount) external {
        require(amount > 0, "no funds to release in params");

        SubnetID memory subnetId = SubnetID(networkName.parent, msg.sender);
        bytes memory subnetIdBytes = abi.encode(subnetId);

        Subnet storage subnet = subnets[subnetIdBytes];

        require(
            keccak256(subnetIdBytes) == keccak256(abi.encode(subnet.id)),
            "subnet is not registered"
        );
        require(
            subnet.stake >= amount,
            "subnet actor not allowed to release so many funds"
        );
        require(
            address(this).balance >= amount,
            "something went really wrong! the actor doesn't have enough balance to release"
        );

        subnet.stake -= amount;

        if (subnet.stake < minStake) {
            subnet.status = Status.Inactive;
        }

        (bool released, ) = payable(subnet.id.actor).call{value: amount}("");
        require(released, "failed to release stake");
    }

    function kill() external {
        SubnetID memory subnetId = SubnetID(networkName.parent, msg.sender);
        bytes memory subnetIdBytes = abi.encode(subnetId);

        Subnet storage subnet = subnets[subnetIdBytes];

        require(
            keccak256(subnetIdBytes) == keccak256(abi.encode(subnet.id)),
            "subnet is not registered"
        );
        require(
            address(this).balance >= subnet.stake,
            "something went really wrong! the actor doesn't have enough balance to release"
        );
        require(
            subnet.circSupply == 0,
            "cannot kill a subnet that still holds user funds in its circ. supply"
        );

        uint256 stake = subnet.stake;

        totalSubnets -= 1;

        delete subnets[subnetIdBytes];

        (bool killed, ) = payable(msg.sender).call{value: stake}("");
        require(killed, "failed to kill subnet");
    }

    function commitChildCheck(Checkpoint calldata checkpoint) external {

    }

    function fund(bytes memory subnetId) external {
        revert("MethodNotImplemented");
    }

    function release() external {
        revert("MethodNotImplemented");
    }

    function sendCross(
        bytes memory toSubnetId,
        bytes memory crossMsg
    ) external {
        revert("MethodNotImplemented");
    }

    function applyMessage(bytes memory crossMsg) external {
        revert("MethodNotImplemented");
    }

    function whitelistPropagator(
        uint256 postboxId,
        address[] memory owners
    ) external {
        revert("MethodNotImplemented");
    }

    function propagate(uint256 postboxId) external {
        revert("MethodNotImplemented");
    }

    function commitCrossMessage(
        bytes memory crossMessage,
        uint256 feeAmount
    ) external {
        revert("MethodNotImplemented");
    }
}
