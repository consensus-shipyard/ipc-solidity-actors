// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./structs/Postbox.sol";
import "./enums/Status.sol";
import "./interfaces/IGateway.sol";
import "./interfaces/ISubnetActor.sol";
import "./lib/StorableMsgHelper.sol";
import "./lib/SubnetIDHelper.sol";
import "./lib/CheckpointMappingHelper.sol";
import "./lib/CheckpointHelper.sol";
import "./lib/StorableMsgHelper.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/utils/Address.sol";
import "forge-std/console.sol";
/// @title Gateway Contract
/// @author LimeChain team
contract Gateway is IGateway, ReentrancyGuard {
    using Address for address payable;
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for Checkpoint;
    using CheckpointMappingHelper for mapping(int64 => Checkpoint);
    using StorableMsgHelper for StorableMsg;

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
    mapping(bytes32 => Subnet) public subnets;

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

    /// epoch => SubnetID => [childIndex, exists(0 - no, 1 - yes)]
    mapping(int64 => mapping(bytes32 => uint256[2])) internal children;
    /// epoch => SubnetID => check => exists
    mapping(int64 => mapping(bytes32 => mapping(bytes32 => bool)))
        internal checks;

    modifier isRegistered() {
        (bool registered, ) = getSubnet(msg.sender);
        require(registered, "subnet is not registered");
        _;
    }

    constructor(address[] memory path, int64 checkpointPeriod) {
        networkName = SubnetID(path);
        minStake = MIN_COLLATERAL_AMOUNT;
        checkPeriod = checkpointPeriod > DEFAULT_CHECKPOINT_PERIOD
            ? checkpointPeriod
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

    function addStake() external payable isRegistered {
        require(msg.value > 0, "no stake to add");

        (, Subnet storage subnet) = getSubnet(msg.sender);
        subnet.stake += msg.value;
    }

    function releaseStake(uint amount) external nonReentrant isRegistered {
        require(amount > 0, "no funds to release in params");

        (, Subnet storage subnet) = getSubnet(msg.sender);
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

        payable(subnet.id.getActor()).sendValue(amount);
    }

    function kill() external isRegistered {
        (, Subnet storage subnet) = getSubnet(msg.sender);
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

        delete subnets[subnet.id.toHash()];

        payable(msg.sender).sendValue(stake);
    }

    function commitChildCheck(
        Checkpoint calldata commit
    ) external isRegistered returns (uint fee) {
        (, Subnet storage subnet) = getSubnet(msg.sender);
        require(
            commit.data.source.getActor() == msg.sender,
            "source in checkpoint doesn't belong to subnet"
        );

        require(
            subnet.status == Status.Active,
            "can't commit checkpoint for an inactive subnet"
        );

        require(
            subnet.prevCheckpoint.data.epoch <= commit.data.epoch,
            "checkpoint being committed belongs to the past"
        );
        if (commit.data.prevHash != bytes32(0)) {
            require(
                subnet.prevCheckpoint.toHash() == commit.data.prevHash,
                "previous checkpoint not consistent with previous one"
            );
        }

        // cross message
        if (commit.hasCrossMsgMeta()) {
            if (commit.data.crossMsgs.msgs.length > 0) {
                bottomUpMsgMeta[bottomUpNonce] = commit.data.crossMsgs;
                bottomUpMsgMeta[bottomUpNonce].nonce = bottomUpNonce;
                bottomUpNonce += 1;
            }

            require(
                subnet.circSupply >= commit.data.crossMsgs.value,
                "wtf! we can't release funds below circ, supply. something went really wrong"
            );

            subnet.circSupply -= commit.data.crossMsgs.value;
            fee = commit.data.crossMsgs.fee;
        }

        (
            bool checkpointExists,
            int64 currentEpoch,
            Checkpoint storage checkpoint
        ) = checkpoints.getCheckpointPerEpoch(block.number, checkPeriod);

        // create checkpoint if not exists
        if (checkpointExists == false) {
            checkpoint.data.source = networkName;
            checkpoint.data.epoch = currentEpoch;
        }

        bytes32 commitSource = commit.data.source.toHash();
        bytes32 commitData = commit.toHash();

        uint[2] memory child = children[currentEpoch][commitSource];
        uint childIndex = child[0]; // index at checkpoint.data.children for the given subnet
        bool childExists = child[1] == 1; // 0 - no, 1 - yes
        bool childCheckExists = checks[currentEpoch][commitSource][commitData];

        require(
            childCheckExists == false,
            "child checkpoint being committed already exists"
        );

        if (childExists == false) {
            checkpoint.data.children.push(
                ChildCheck({
                    source: commit.data.source,
                    checks: new bytes32[](0)
                })
            );
            childIndex = checkpoint.data.children.length - 1;
        }

        checkpoint.data.children[childIndex].checks.push(commitData);

        children[currentEpoch][commitSource][0] = childIndex;
        children[currentEpoch][commitSource][1] = 1;
        checks[currentEpoch][commitSource][commitData] = true;

        subnet.prevCheckpoint = commit;

        if (fee > 0) {
            payable(msg.sender).functionCallWithValue(
                abi.encodeWithSignature("reward()"),
                fee
            );
        }
    }

    function fund(bytes memory subnetId) external {
        revert("MethodNotImplemented");
    }

    function release() external {
        revert("MethodNotImplemented");
    }

    function sendCross(
        SubnetID memory destination,
        CrossMsg memory crossMsg
    ) external payable isRegistered {
        require(destination.route.length > 0, "no destination for cross-message explicitly set");
        require(!destination.equals(networkName), "destination is the current network, you are better off with a good ol' message, no cross needed") ;
        require(crossMsg.message.value == msg.value, "the funds in cross-msg params are not equal to the ones sent in the message");
        require(crossMsg.message.to.rawAddress != address(0), "invalid to addr");
        require(msg.value > CROSS_MSG_FEE, "not enough gas to pay cross-message");

        crossMsg.message.to = IPCAddress(destination, crossMsg.message.to.rawAddress);
        crossMsg.message.from = IPCAddress(networkName, msg.sender);

        uint256 balance = msg.value - CROSS_MSG_FEE;

        (bool burn, uint256 topDownFee) = _commitCrossMessage(crossMsg, CROSS_MSG_FEE);

        _crossMsgSideEffects(crossMsg, burn, topDownFee);
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

    function _commitCrossMessage(
        CrossMsg memory crossMessage,
        uint256 fee
    ) internal returns (bool burn, uint256 topDownFee) {
        SubnetID memory to = crossMessage.message.to.subnetId;
        require(to.route.length > 0, "error getting subnet from msg");
        require(
            !crossMessage.message.to.subnetId.equals(networkName),
            "should already be committed"
        );

        if(crossMessage.message.applyType(networkName) == IPCMsgType.BottomUp) {
            console.log("bottom up");
            SubnetID memory from = crossMessage.message.from.subnetId;
            console.log("from: %s", from.toString());
            require(from.route.length > 0, "error getting subnet from msg");
            SubnetID memory nearestCommonParent = to.commonParent(from);
            console.log("nearestCommonParent: %s", nearestCommonParent.toString());
            if(nearestCommonParent.equals(networkName)) {
                console.log('nearestCommonParent.equals(networkName)');
                topDownFee = fee;
                _commitTopDownMsg(crossMessage);
            } else {
                console.log('not nearestCommonParent.equals(networkName)');
                burn = crossMessage.message.value > 0;
                _commitBottomUpMsg(crossMessage, fee, _getCurrentEpoch());
            }
        } else if(crossMessage.message.applyType(networkName) == IPCMsgType.TopDown) {
            console.log("top down");
            appliedTopDownNonce += 1;
            _commitTopDownMsg(crossMessage);
        } 
    }

    function _commitTopDownMsg(CrossMsg memory crossMessage) internal {
        StorableMsg memory storableMsg = crossMessage.message;
        SubnetID memory to  = storableMsg.to.subnetId;
        SubnetID memory subId = networkName.down(to);
        console.log("networkName: ", networkName.toString());
        console.log("to: ", to.toString());
        console.log("subId: ", subId.toString());
        require(subId.route.length > 0, "couldn't compute the next subnet in route");
        (bool found, Subnet storage subnet) = getSubnet(subId.getActor());
        require(found, "subnet not found");
        crossMessage.message.nonce = subnet.nonce;
        subnet.topDownMsgs.push(crossMessage);
        subnet.nonce += 1;
        subnet.circSupply += crossMessage.message.value;
    }
    
    function _commitBottomUpMsg(
        CrossMsg memory crossMessage,
        uint256 fee,
        int64 epoch
    ) internal {
        (,,Checkpoint storage checkpoint ) = checkpoints.getCheckpointPerEpoch(block.number, checkPeriod);
        CrossMsgMeta storage meta = checkpoint.data.crossMsgs;
        meta.msgs.push(crossMessage);
        meta.value += crossMessage.message.value + fee;
        meta.fee += fee;
        nonce += 1;
    }

    function _crossMsgSideEffects(CrossMsg memory crossMsg, bool burn, uint256 fee) internal nonReentrant {
        console.log("crossMsgSideEffects");
        if(burn)
            console.log("burning funds");
            payable(BURNT_FUNDS_ACTOR).sendValue(crossMsg.message.value);
        if(fee == 0) return;
        console.log("fee: ", fee);
        
        SubnetID memory down = networkName.down(crossMsg.message.to.subnetId);
        console.log("distribute network: ", down.toString());
        console.log("distribute actor: ", down.getActor());
        if(down.route.length == 0 || down.getActor() == address(0)) return;

        payable(down.getActor()).sendValue(fee);
    }

    function _getCurrentEpoch() internal view returns (int64 epoch) {
        epoch = (int64(uint64(block.number)) / checkPeriod) * checkPeriod;
    }

    function getSubnet(
        address actor
    ) internal view returns (bool found, Subnet storage subnet) {
        SubnetID memory subnetId = networkName.setActor(actor);

        subnet = subnets[subnetId.toHash()];
        found = subnet.id.route.length > 0;
    }
}
