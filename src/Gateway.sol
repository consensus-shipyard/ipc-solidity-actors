// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./structs/Postbox.sol";
import "./enums/Status.sol";
import "./interfaces/IGateway.sol";
import "./interfaces/ISubnetActor.sol";
import "./lib/StorableMsgHelper.sol";
import "./lib/SubnetIDHelper.sol";

import "openzeppelin-contracts/security/ReentrancyGuard.sol";

contract Gateway is IGateway , ReentrancyGuard {

    using SubnetIDHelper for SubnetID;

    int64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint64 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant MAX_NONCE = type(uint64).max;

    /// @notice ID of the current network
    SubnetID private networkName;

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
    mapping(uint64 => PostBoxItem) private postbox;

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

    constructor(address[] memory _path, int64 _checkpointPeriod) {
        networkName = SubnetID(_path);
        minStake = MIN_COLLATERAL_AMOUNT;
        checkPeriod = _checkpointPeriod > DEFAULT_CHECKPOINT_PERIOD
            ? _checkpointPeriod
            : DEFAULT_CHECKPOINT_PERIOD;
        appliedBottomUpNonce = MAX_NONCE;
    }

    function getNetworkName() external view returns (SubnetID memory) {
        return networkName;
    }

    function register() external payable {
        require(
            msg.value >= minStake,
            "call to register doesn't include enough funds"
        );

        (bool registered, Subnet storage subnet) = getSubnet(msg.sender);

        require(registered == false, "subnet is already registered");


        subnet.id = networkName.setActor(msg.sender);
        subnet.stake = msg.value;
        subnet.status = Status.Active;
        subnet.nonce = 0;
        subnet.circSupply = 0;

        totalSubnets += 1;
    }

    function addStake() external payable {
        require(msg.value > 0, "no stake to add");

        (bool registered, Subnet storage subnet) = getSubnet(msg.sender);

        require(registered, "subnet is not registered");

        subnet.stake += msg.value;
    }

    function releaseStake(uint amount) external {
        require(amount > 0, "no funds to release in params");

        (bool registered, Subnet storage subnet) = getSubnet(msg.sender);

        require(registered, "subnet is not registered");
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

        (bool released, ) = payable(subnet.id.getActor()).call{value: amount}("");
        require(released, "failed to release stake");
    }

    function kill() external {
        (bool registered, Subnet storage subnet) = getSubnet(msg.sender);

        require(registered, "subnet is not registered");
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

        delete subnets[abi.encode(subnet.id)];

        (bool killed, ) = payable(msg.sender).call{value: stake}("");
        require(killed, "failed to kill subnet");
    }

    function commitChildCheck(
        Checkpoint calldata commit
    ) external returns (uint) {
        require(
            commit.data.source.getActor() == msg.sender,
            "source in checkpoint doesn't belong to subnet"
        );

        (bool registered, Subnet storage subnet) = getSubnet(msg.sender);

        require(registered, "subnet is not registered");

        require(
            subnet.status == Status.Active,
            "can't commit checkpoint for an inactive subnet"
        );

        require(
            subnet.prevCheckpoint.data.epoch <= commit.data.epoch,
            "checkpoint being committed belongs to the past"
        );
        if(commit.data.prevHash != bytes32(0)) {
            require(
                keccak256(abi.encode(subnet.prevCheckpoint.data)) ==
                    commit.data.prevHash,
                "previous checkpoint not consistent with previous one"
            );
        }

        int64 epoch = (int64(uint64(block.number)) / checkPeriod + 1) *
            checkPeriod;

        Checkpoint storage checkpoint = checkpoints[epoch];

        uint fee;
        // cross message
        if (
            keccak256(abi.encode(commit.data.crossMsgs.msgs)) !=
            keccak256(new bytes(0))
        ) {
            bottomUpMsgMeta[bottomUpNonce] = commit.data.crossMsgs;
            bottomUpMsgMeta[bottomUpNonce].nonce = bottomUpNonce;
            bottomUpNonce += 1;

            subnet.circSupply -= commit.data.crossMsgs.value;
            fee = commit.data.crossMsgs.fee;
        }

        uint foundIndex;
        bool found;

        ChildCheck[] memory cpChildChecks = checkpoint.data.children;
        for (
            uint childIndex = 0;
            childIndex < cpChildChecks.length;
            childIndex++
        ) {
            ChildCheck memory childCheck = cpChildChecks[childIndex];
            if (
                keccak256(abi.encode(childCheck.source)) ==
                keccak256(abi.encode(commit.data.source))
            ) {
                for (
                    uint checkIndex = 0;
                    checkIndex < childCheck.checks.length;
                    checkIndex++
                ) {
                    require(
                        keccak256(childCheck.checks[checkIndex]) ==
                            keccak256(abi.encode(commit.data)),
                        "child checkpoint being committed already exists"
                    );
                }

                found = true;
                foundIndex = childIndex;
                break;
            }
        }

        if (!found) {
            foundIndex = cpChildChecks.length;
            checkpoint.data.children[foundIndex].source = commit.data.source;
        }

        checkpoint.data.children[foundIndex].checks.push(
            abi.encode(commit.data)
        );

        subnet.prevCheckpoint = commit;

        return fee;
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

    function getSubnet(
        address _actor
    ) internal view returns (bool found, Subnet storage subnet) {
        SubnetID memory subnetId = networkName.setActor(_actor);
        bytes memory subnetIdBytes = abi.encode(subnetId);

        subnet = subnets[subnetIdBytes];
        found = keccak256(subnetIdBytes) == keccak256(abi.encode(subnet.id));
    }
}
