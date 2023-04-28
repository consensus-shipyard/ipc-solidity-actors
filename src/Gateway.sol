// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./enums/Status.sol";
import "./interfaces/IGateway.sol";
import "./interfaces/ISubnetActor.sol";
import "./lib/SubnetIDHelper.sol";
import "./lib/CheckpointMappingHelper.sol";
import "./lib/CheckpointHelper.sol";
import "./lib/AccountHelper.sol";
import "./lib/CrossMsgHelper.sol";
import "./lib/StorableMsgHelper.sol";
import "fevmate/utils/FilAddress.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "openzeppelin-contracts/utils/Address.sol";

/// @title Gateway Contract
/// @author LimeChain team
contract Gateway is IGateway, ReentrancyGuard {
    using FilAddress for address;
    using FilAddress for address payable;
    using AccountHelper for address;
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using CheckpointHelper for BottomUpCheckpoint;
    using CheckpointHelper for TopDownCheckpoint;
    using CheckpointMappingHelper for mapping(uint64 => BottomUpCheckpoint);
    using StorableMsgHelper for StorableMsg;
    using EnumerableSet for EnumerableSet.AddressSet;

    uint8 constant MIN_CHECKPOINT_PERIOD = 10;
    uint256 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint256 constant INITIAL_VALIDATOR_FUNDS = 1 ether;

    /// @notice path to the current network
    SubnetID private networkName;

    /// @notice Number of active subnets spawned from this one
    uint64 public totalSubnets;

    /// @notice Minimum stake required to create a new subnet
    uint256 public minStake;

    /// @notice List of subnets
    /// SubnetID => Subnet
    mapping(bytes32 => Subnet) public subnets;

    /// @notice bottom-up period in number of epochs for the subnet
    uint64 public bottomUpCheckPeriod;

    /// @notice Postbox keeps track of all the cross-net messages triggered by
    /// an actor that need to be propagated further through the hierarchy.
    /// cross-net message id => CrossMsg
    mapping(bytes32 => CrossMsg) public postbox;

    /// @notice cross-net message id => set of owners
    mapping(bytes32 => mapping(address => bool)) public postboxHasOwner;

    /// @notice top-down period in number of epochs for the subnet
    uint64 public topDownCheckPeriod;

    /// @notice BottomUpCheckpoints in the GW per epoch
    mapping(uint64 => BottomUpCheckpoint) public bottomUpCheckpoints;

    /// @notice nonce for top-down messages
    uint64 public topDownNonce;

    /// @notice nonce for bottom-up messages
    uint64 public bottomUpNonce;

    /// @notice AppliedNonces keep track of the next nonce of the message to be applied.
    /// This prevents potential replay attacks.
    uint64 public appliedBottomUpNonce;
    uint64 public appliedTopDownNonce;

    /// @notice fee amount charged per cross message
    uint256 public crossMsgFee;

    /// @notice List of validators for top-down messages
    EnumerableSet.AddressSet private validators;

    /// @notice how many votes of the total each validator has. Used as a proportion of the whole
    mapping(address => uint256) validatorWeights;

    /// @notice total votes of all validators
    uint256 totalWeight;

    /// @notice percent approvals needed to reach consensus
    uint8 public majorityPercentage;

    /// @notice last executed epoch after voting
    uint64 lastVotingExecutedEpoch;

    /// @notice number of votes for a top-down checkpoint commitment
    mapping(bytes32 => uint256) private commitVoteAmount;

    /// @notice weather or not a validator has voted on certain commitment
    mapping(bytes32 => mapping(address => bool))
        private hasValidatorVotedForCommit;

    /// @notice epoch => SubnetID => [childIndex, exists(0 - no, 1 - yes)]
    mapping(uint64 => mapping(bytes32 => uint256[2])) internal children;

    /// @notice epoch => SubnetID => check => exists
    mapping(uint64 => mapping(bytes32 => mapping(bytes32 => bool)))
        internal checks;

    bool initialized = false;

    modifier signableOnly() {
        require(msg.sender.isAccount(), "the caller is not an account");
        _;
    }

    modifier hasFee() {
        require(msg.value > crossMsgFee, "not enough gas to pay cross-message");
        _;
    }

    struct ConstructorParams {
        SubnetID networkName;
        uint64 bottomUpCheckPeriod;
        uint64 topDownCheckPeriod;
        uint256 msgFee;
        uint8 majorityPercentage;
    }

    constructor(ConstructorParams memory params) {
        require(params.majorityPercentage <= 100);
        networkName = params.networkName;
        minStake = MIN_COLLATERAL_AMOUNT;
        bottomUpCheckPeriod = params.bottomUpCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.bottomUpCheckPeriod;
        topDownCheckPeriod = params.topDownCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.topDownCheckPeriod;
        crossMsgFee = params.msgFee;
        majorityPercentage = params.majorityPercentage;
        if (networkName.isRoot()) initialized = true;
    }

    function getSubnetTopDownMsgsLength(
        SubnetID memory subnetId
    ) external view returns (uint) {
        (, Subnet storage subnet) = _getSubnet(subnetId);

        return subnet.topDownMsgs.length;
    }

    function getSubnetTopDownMsg(
        SubnetID memory subnetId,
        uint index
    ) external view returns (CrossMsg memory) {
        (, Subnet storage subnet) = _getSubnet(subnetId);

        return subnet.topDownMsgs[index];
    }

    function getNetworkName() external view returns (SubnetID memory) {
        return networkName;
    }

    /// @notice register a subnet in the gateway. called by a subnet when it reaches the treshold stake
    function register() external payable {
        require(
            msg.value >= minStake,
            "call to register doesn't include enough funds"
        );

        SubnetID memory subnetId = networkName.createSubnetId(msg.sender);

        (bool registered, Subnet storage subnet) = _getSubnet(subnetId);

        require(registered == false, "subnet is already registered");

        subnet.id = subnetId;
        subnet.stake = msg.value;
        subnet.status = Status.Active;
        subnet.topDownNonce = 0;
        subnet.circSupply = 0;

        totalSubnets += 1;
    }

    /// @notice addStake - add collateral for an existing subnet
    function addStake() external payable {
        require(msg.value > 0, "no stake to add");

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        require(registered, "subnet is not registered");

        subnet.stake += msg.value;
    }

    /// @notice release collateral for an existing subnet
    function releaseStake(uint amount) external nonReentrant {
        require(amount > 0, "no funds to release in params");

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

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

        payable(subnet.id.getActor()).sendValue(amount);
    }

    /// @notice kill an existing subnet. It's balance must be empty
    function kill() external {
        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

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

        delete subnets[subnet.id.toHash()];

        payable(msg.sender).sendValue(stake);
    }

    /// @notice submit a checkpoint in the gateway. Called from a subnet once the checkpoint is voted for and reaches majority
    function commitChildCheck(BottomUpCheckpoint calldata commit) external {
        require(initialized, "not initialized");

        require(
            commit.source.getActor().normalize() == msg.sender,
            "source in checkpoint doesn't belong to subnet"
        );

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        require(registered, "subnet is not registered");

        require(
            subnet.status == Status.Active,
            "can't commit checkpoint for an inactive subnet"
        );

        require(
            subnet.prevCheckpoint.epoch + bottomUpCheckPeriod == commit.epoch,
            "wrong epoch set for checkpoint"
        );

        if (commit.prevHash != EMPTY_HASH) {
            require(
                subnet.prevCheckpoint.toHash() == commit.prevHash,
                "previous checkpoint not consistent with previous one"
            );
        }

        (
            bool checkpointExists,
            uint64 currentEpoch,
            BottomUpCheckpoint storage checkpoint
        ) = bottomUpCheckpoints.getCheckpointPerEpoch(
                block.number,
                bottomUpCheckPeriod
            );

        // create checkpoint if not exists
        if (checkpointExists == false) {
            checkpoint.source = networkName;
            checkpoint.epoch = currentEpoch;
        }

        bytes32 commitSource = commit.source.toHash();
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
            checkpoint.children.push(
                ChildCheck({source: commit.source, checks: new bytes32[](0)})
            );
            childIndex = checkpoint.children.length - 1;
        }

        checkpoint.children[childIndex].checks.push(commitData);

        children[currentEpoch][commitSource][0] = childIndex;
        children[currentEpoch][commitSource][1] = 1;
        checks[currentEpoch][commitSource][commitData] = true;

        uint256 totaValue = 0;
        for (uint i = 0; i < commit.crossMsgs.length; ) {
            totaValue += commit.crossMsgs[i].message.value;
            unchecked {
                ++i;
            }
        }

        totaValue += commit.fee + checkpoint.fee; // add fee that is already in checkpoint as well. For example from release message interacting with the same checkpoint

        bottomUpNonce += commit.crossMsgs.length > 0 ? 1 : 0;

        require(
            subnet.circSupply >= totaValue,
            "wtf! we can't release funds below circ, supply. something went really wrong"
        );

        subnet.circSupply -= totaValue;

        subnet.prevCheckpoint = commit;

        _applyMessages(commit.crossMsgs);

        _distributeRewards(msg.sender, commit.fee);
    }

    /// @notice fund - commit a top-down message releasing funds in a child subnet. There is an associated fee that gets distributed to validators in the subnet as well
    /// @param subnetId - subnet to fund
    function fund(
        SubnetID calldata subnetId
    ) external payable signableOnly hasFee {
        CrossMsg memory crossMsg = CrossMsgHelper.createFundMsg(
            subnetId,
            msg.sender,
            msg.value - crossMsgFee
        );

        // commit top-down message.
        _commitTopDownMsg(crossMsg);

        _distributeRewards(subnetId.getActor(), crossMsgFee);
    }

    function release() external payable signableOnly hasFee {
        CrossMsg memory crossMsg = CrossMsgHelper.createReleaseMsg(
            networkName,
            msg.sender,
            msg.value - crossMsgFee
        );

        _commitBottomUpMsg(crossMsg);
    }

    function setMembership(
        address[] memory validatorsToSet,
        uint256[] memory weights
    ) external {
        require(msg.sender.isSystemActor(), "caller not the system actor");
        require(
            validatorsToSet.length == weights.length,
            "number of validators is not equal to the number of validator weights"
        );

        uint64 currentEpoch = (uint64(block.number) / topDownCheckPeriod) *
            topDownCheckPeriod;
        for (uint i = 0; i < validatorsToSet.length; ) {
            validators.add(validatorsToSet[i]);
            validatorWeights[validatorsToSet[i]] = weights[i];
            totalWeight += weights[i];

            // initial validators need to be conveniently funded with at least
            // 1 FIL for them to be able to commit the first few top-down messages.
            // They should use this FIL to fund their own addresses in the subnet
            // so they can keep committing top-down messages. If they don't do this,
            // they won't be able to send cross-net messages in their subnet.
            // Funds are only distributed in child subnets, where top-down checkpoints need
            // to be committed. This doesn't apply to the root.
            // TODO: Once account abstraction is conveniently supported, there will be
            // no need for this initial funding of validators.
            if (currentEpoch == 1 && !networkName.isRoot())
                payable(validatorsToSet[i]).sendValue(INITIAL_VALIDATOR_FUNDS);

            unchecked {
                ++i;
            }
        }
    }

    function initGenesisEpoch(uint64 genesisEpoch) external {
        require(msg.sender.isSystemActor(), "caller not the system actor");
        require(initialized == false, "subnet already initialized");

        lastVotingExecutedEpoch = genesisEpoch;
        initialized = true;
    }

    function submitTopDownCheckpoint(
        TopDownCheckpoint memory checkpoint
    ) external signableOnly {
        require(initialized, "not initialized");
        require(validators.contains(msg.sender), "not validator");

        require(
            lastVotingExecutedEpoch + topDownCheckPeriod == checkpoint.epoch,
            "epoch in checkpoint doesn't correspond with a signing window"
        );

        bytes32 commitHash = checkpoint.toHash();

        require(
            !hasValidatorVotedForCommit[commitHash][msg.sender],
            "validator has already voted the checkpoint"
        );

        hasValidatorVotedForCommit[commitHash][msg.sender] = true;

        commitVoteAmount[commitHash] += validatorWeights[msg.sender];
        bool hasMajority = commitVoteAmount[commitHash] * 100 >
            totalWeight * majorityPercentage;
        if (hasMajority == false) return;
        lastVotingExecutedEpoch = checkpoint.epoch;
        commitVoteAmount[commitHash] = 0;

        //only execute the messages and update the last executed checkpoint when we have majority
        _applyMessages(checkpoint.topDownMsgs);
    }

    /// @notice sends an arbitrary cross message from the current subnet to a destination subnet.
    /// @param destination - destination subnet
    /// @param crossMsg - message to send
    function sendCross(
        SubnetID memory destination,
        CrossMsg memory crossMsg
    ) external payable signableOnly hasFee {
        require(
            destination.equals(networkName) == false,
            "destination is the current network, you are better off with a good ol' message, no cross needed"
        );
        require(
            crossMsg.message.value == msg.value,
            "the funds in cross-msg params are not equal to the ones sent in the message"
        );
        require(
            crossMsg.message.to.rawAddress != address(0),
            "invalid to addr"
        );

        // we disregard the "to" of the message. the caller is the one set as the "from" of the message.
        crossMsg.message.to.subnetId = destination;
        crossMsg.message.from.subnetId = networkName;
        crossMsg.message.from.rawAddress = msg.sender;

        // commit cross-message for propagation
        (bool shouldBurn, bool shouldDistributeRewards) = _commitCrossMessage(
            crossMsg
        );

        _crossMsgSideEffects(crossMsg, shouldBurn, shouldDistributeRewards);
    }

    /// @notice whitelist a series of addresses as propagator of a cross net message
    /// @param msgCid - the cid of the cross-net message
    /// @param owners - list of addresses to be added as owners
    function whitelistPropagator(
        bytes32 msgCid,
        address[] calldata owners
    ) external {
        require(postboxHasOwner[msgCid][msg.sender], "not owner");

        CrossMsg storage crossMsg = postbox[msgCid];

        require(crossMsg.isEmpty() == false, "postbox item does not exist");

        // update postbox with the new owners
        for (uint256 i = 0; i < owners.length; ) {
            address owner = owners[i];

            if (postboxHasOwner[msgCid][owner] == false) {
                postboxHasOwner[msgCid][owner] = true;
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice propagates the populated cross net message for the given cid
    /// @param msgCid - the cid of the cross-net message
    function propagate(bytes32 msgCid) external payable {
        require(
            msg.value >= crossMsgFee,
            "not enough gas to pay cross-message"
        );
        require(postboxHasOwner[msgCid][msg.sender], "not owner");

        CrossMsg storage crossMsg = postbox[msgCid];

        require(crossMsg.isEmpty() == false, "postbox item does not exist");

        (bool shouldBurn, bool shouldDistributeRewards) = _commitCrossMessage(
            crossMsg
        );

        _crossMsgSideEffects(crossMsg, shouldBurn, shouldDistributeRewards);

        delete postbox[msgCid];

        uint256 feeRemainder = msg.value - crossMsgFee;

        if (feeRemainder > 0) {
            payable(msg.sender).sendValue(feeRemainder);
        }
    }

    /// @notice Commit the cross message to storage. It outputs a flag signaling
    /// if the committed messages was bottom-up and some funds need to be
    /// burnt or if a top-down message fee needs to be distributed.
    function _commitCrossMessage(
        CrossMsg memory crossMessage
    ) internal returns (bool shouldBurn, bool shouldDistributeRewards) {
        SubnetID memory to = crossMessage.message.to.subnetId;

        require(to.route.length > 0, "error getting subnet from msg");
        require(to.equals(networkName) == false, "should already be committed");

        SubnetID memory from = crossMessage.message.from.subnetId;
        IPCMsgType applyType = crossMessage.message.applyType(networkName);

        bool shouldCommitBottomUp;

        if (applyType == IPCMsgType.BottomUp) {
            shouldCommitBottomUp =
                to.commonParent(from).equals(networkName) == false;
        }

        if (shouldCommitBottomUp) {
            _commitBottomUpMsg(crossMessage);

            return (
                shouldBurn = crossMessage.message.value > 0,
                shouldDistributeRewards = false
            );
        }

        appliedTopDownNonce += applyType == IPCMsgType.TopDown ? 1 : 0;
        _commitTopDownMsg(crossMessage);

        return (shouldBurn = false, shouldDistributeRewards = true);
    }

    /// @notice transaction side-effects from the commitment of a cross-net message. It burns funds
    /// and propagates the corresponding rewards.
    function _crossMsgSideEffects(
        CrossMsg memory crossMsg,
        bool shouldBurn,
        bool shouldDistributeRewards
    ) internal {
        if (shouldBurn)
            payable(BURNT_FUNDS_ACTOR).sendValue(crossMsg.message.value);

        if (shouldDistributeRewards) {
            SubnetID memory toSubnetId = crossMsg.message.to.subnetId.down(
                networkName
            );

            if (
                toSubnetId.route.length == 0 ||
                toSubnetId.getActor() == address(0)
            ) return;

            _distributeRewards(toSubnetId.getActor(), crossMsgFee);
        }
    }

    /// @notice commit topdown messages for their execution in the subnet
    function _commitTopDownMsg(CrossMsg memory crossMessage) internal {
        SubnetID memory subnetId = crossMessage.message.to.subnetId.down(
            networkName
        );

        (bool registered, Subnet storage subnet) = _getSubnet(subnetId);

        require(registered, "couldn't compute the next subnet in route");

        crossMessage.message.nonce = subnet.topDownNonce;
        subnet.topDownNonce += 1;
        subnet.circSupply += crossMessage.message.value;
        subnet.topDownMsgs.push(crossMessage);
    }

    /// @notice commit bottomup messages for their execution in the subnet
    function _commitBottomUpMsg(CrossMsg memory crossMessage) internal {
        (, , BottomUpCheckpoint storage checkpoint) = bottomUpCheckpoints
            .getCheckpointPerEpoch(block.number, bottomUpCheckPeriod);

        crossMessage.message.nonce = bottomUpNonce;

        checkpoint.fee += crossMsgFee;
        checkpoint.crossMsgs.push(crossMessage);
        bottomUpNonce += 1;
    }

    /// @notice executes a cross message if its destination is the current network, otherwise adds it to the postbox to be propagated further
    function _applyMsg(
        CrossMsg memory crossMsg
    ) internal returns (bytes memory) {
        require(
            crossMsg.message.to.rawAddress != address(0),
            "error getting raw address from msg"
        );
        require(
            crossMsg.message.to.subnetId.route.length > 0,
            "error getting subnet from msg"
        );
        if (crossMsg.message.method == METHOD_SEND) {
            require(
                address(this).balance >= crossMsg.message.value,
                "not enough balance to mint new tokens as part of the cross-message"
            );
        }

        IPCMsgType applyType = crossMsg.message.applyType(networkName);

        // If the cross-message destination is the current network.
        if (crossMsg.message.to.subnetId.equals(networkName)) {
            if (applyType == IPCMsgType.BottomUp) {
                require(appliedBottomUpNonce == crossMsg.message.nonce);
                appliedBottomUpNonce += 1;
            }

            if (applyType == IPCMsgType.TopDown) {
                require(appliedTopDownNonce == crossMsg.message.nonce);
                appliedTopDownNonce += 1;
            }

            return crossMsg.execute();
        }

        // when the destination is not the current network we add it to the postbox for further propagation
        bytes32 cid = crossMsg.toHash();

        postbox[cid] = crossMsg;
        postboxHasOwner[cid][crossMsg.message.from.rawAddress] = true;

        return abi.encode(cid);
    }

    function _applyMessages(CrossMsg[] memory crossMsgs) internal {
        for (uint i = 0; i < crossMsgs.length; ) {
            if (i >= 1) {
                require(
                    crossMsgs[i].message.nonce <=
                        crossMsgs[i - 1].message.nonce,
                    "cross messages not ordered by nonce"
                );
            }
            _applyMsg(crossMsgs[i]);
            unchecked {
                ++i;
            }
        }
    }

    /// @notice distribute rewards to validators in child subnet
    function _distributeRewards(address to, uint256 amount) internal {
        if (amount == 0) return;

        Address.functionCallWithValue(
            to.normalize(),
            abi.encodeWithSignature("reward()"),
            amount
        );
    }

    function _getSubnet(
        address actor
    ) internal view returns (bool found, Subnet storage subnet) {
        SubnetID memory subnetId = networkName.createSubnetId(actor);

        return _getSubnet(subnetId);
    }

    function _getSubnet(
        SubnetID memory subnetId
    ) internal view returns (bool found, Subnet storage subnet) {
        subnet = subnets[subnetId.toHash()];
        found = subnet.id.route.length > 0;
    }
}
