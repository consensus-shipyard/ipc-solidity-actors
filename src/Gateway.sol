// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./structs/Checkpoint.sol";
import "./structs/EpochVoteSubmission.sol";
import "./enums/Status.sol";
import "./enums/VoteExecutionStatus.sol";
import "./interfaces/IGateway.sol";
import "./interfaces/ISubnetActor.sol";
import "./lib/SubnetIDHelper.sol";
import "./lib/CheckpointMappingHelper.sol";
import "./lib/CheckpointHelper.sol";
import "./lib/AccountHelper.sol";
import "./lib/CrossMsgHelper.sol";
import "./lib/StorableMsgHelper.sol";
import "./lib/EpochVoteSubmissionHelper.sol";
import "./lib/ExecutableQueueHelper.sol";
import "fevmate/utils/FilAddress.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "openzeppelin-contracts/utils/structs/EnumerableMap.sol";
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
    using ExecutableQueueHelper for ExecutableQueue;
    using EpochVoteSubmissionHelper for EpochVoteSubmission;

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
    // uint64 public appliedBottomUpNonce;
    uint64 public appliedTopDownNonce;

    /// @notice fee amount charged per cross message
    uint256 public crossMsgFee;

    /// @notice percent approvals needed to reach consensus
    uint8 public majorityPercentage;

    /// @notice last executed epoch after voting
    uint64 public lastVotingExecutedEpoch;

    /// @notice total votes of all validators
    uint256 public totalWeight;

    /// @notice List of validators and how many votes of the total each validator has for top-down messages
    // validatorNonce => validator => weight
    mapping(uint256 => mapping(address => uint256)) public validatorSet;

    /// @notice sequence number that uniquely identifies a validator set
    uint256 public validatorNonce;

    /// @notice number of votes for a top-down checkpoint commitment
    mapping(bytes32 => uint256) private commitVoteAmount;

    /// @notice weather or not a validator has voted on certain commitment
    mapping(bytes32 => mapping(address => bool))
        private hasValidatorVotedForCommit;

    /// @notice epoch => SubnetID => [childIndex, exists(0 - no, 1 - yes)]
    mapping(uint64 => mapping(bytes32 => uint256[2])) private children;

    /// @notice epoch => SubnetID => check => exists
    mapping(uint64 => mapping(bytes32 => mapping(bytes32 => bool)))
        private checks;

    bool initialized = false;

    uint64 public genesisEpoch;

    /// @notice contains voted submissions for a given epoch 
    mapping(uint64 => EpochVoteSubmission) public epochVoteSubmissions;

    /// @notice Contains the executable epochs that are ready to be executed, but has yet to be executed.
    /// This usually happens when previous submission epoch has not executed, but the next submission
    /// epoch is ready to be executed. Most of the time this should be empty
    ExecutableQueue public executableQueue;

    error NotSystemActor();
    error NotSignableAccount();
    error NotEnoughFee();
    error NotEnoughFunds();
    error NotEnoughFundsToRelease();
    error NotEnoughBalance();
    error NotInitialized();
    error NotValidator();
    error NotEnoughSubnetCircSupply();
    error NotEmptySubnetCircSupply();
    error NotRegisteredSubnet();
    error AlreadyRegisteredSubnet();
    error AlreadyInitialized();
    error AlreadyCommitedCheckpoint();
    error InconsistentPrevCheckpoint();
    error InvalidPostboxOwner();
    error InvalidCheckpointEpoch();
    error InvalidCheckpointSource();
    error InvalidCrossMsgNonce();
    error InvalidCrossMsgDestinationSubnet();
    error InvalidCrossMsgDestinationAddress();
    error InvalidCrossMsgsSortOrder();
    error CannotSendCrossMsgToItself();
    error SubnetNotActive();
    error PostboxNotExist();
    error ValidatorAlreadyVoted();

    modifier signableOnly() {
        if (msg.sender.isAccount() == false) revert NotSignableAccount();
        _;
    }

    modifier systemActorOnly() {
        if (msg.sender.isSystemActor() == false) revert NotSystemActor();
        _;
    }

    modifier hasFee() {
        if (msg.value <= crossMsgFee) revert NotEnoughFee();
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

    function initGenesisEpoch(uint64 _genesisEpoch) external systemActorOnly {
        if (initialized) revert AlreadyInitialized();

        genesisEpoch = _genesisEpoch;
        initialized = true;
    }

    /// @notice register a subnet in the gateway. called by a subnet when it reaches the treshold stake
    function register() external payable {
        if (msg.value < minStake) revert NotEnoughFunds();

        SubnetID memory subnetId = networkName.createSubnetId(msg.sender);

        (bool registered, Subnet storage subnet) = _getSubnet(subnetId);

        if (registered) revert AlreadyRegisteredSubnet();

        subnet.id = subnetId;
        subnet.stake = msg.value;
        subnet.status = Status.Active;
        subnet.genesisEpoch = block.number;

        totalSubnets += 1;
    }

    /// @notice addStake - add collateral for an existing subnet
    function addStake() external payable {
        if (msg.value <= 0) revert NotEnoughFunds();

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        if (registered == false) revert NotRegisteredSubnet();

        subnet.stake += msg.value;
    }

    /// @notice release collateral for an existing subnet
    function releaseStake(uint amount) external nonReentrant {
        if (amount == 0) revert NotEnoughFundsToRelease();

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        if (registered == false) revert NotRegisteredSubnet();
        if (subnet.stake < amount) revert NotEnoughFundsToRelease();
        if (address(this).balance < amount) revert NotEnoughBalance();

        subnet.stake -= amount;

        if (subnet.stake < minStake) {
            subnet.status = Status.Inactive;
        }

        payable(subnet.id.getActor()).sendValue(amount);
    }

    /// @notice kill an existing subnet. It's balance must be empty
    function kill() external {
        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        if (registered == false) revert NotRegisteredSubnet();
        if (address(this).balance < subnet.stake) revert NotEnoughBalance();
        if (subnet.circSupply > 0) revert NotEmptySubnetCircSupply();

        uint256 stake = subnet.stake;

        totalSubnets -= 1;

        delete subnets[subnet.id.toHash()];

        payable(msg.sender).sendValue(stake);
    }

    /// @notice submit a checkpoint in the gateway. Called from a subnet once the checkpoint is voted for and reaches majority
    function commitChildCheck(BottomUpCheckpoint calldata commit) external {
        if (initialized == false) revert NotInitialized();
        if (commit.source.getActor().normalize() != msg.sender) revert InvalidCheckpointSource();

        (bool registered, Subnet storage subnet) = _getSubnet(msg.sender);

        if (registered == false) revert NotRegisteredSubnet();
        if (subnet.status != Status.Active) revert SubnetNotActive();
        if (subnet.prevCheckpoint.epoch + bottomUpCheckPeriod != commit.epoch)
            revert InvalidCheckpointEpoch();
        if (
            commit.prevHash != EMPTY_HASH &&
            commit.prevHash != subnet.prevCheckpoint.toHash()
        ) revert InconsistentPrevCheckpoint();

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

        if (childCheckExists) revert AlreadyCommitedCheckpoint();

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

        if (subnet.circSupply < totaValue) revert NotEnoughSubnetCircSupply();

        subnet.circSupply -= totaValue;

        subnet.prevCheckpoint = commit;

        _applyBottomUpMessages(commit.source, commit.crossMsgs);

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

    /// @notice release method locks funds in the current subnet and sends a cross message up the hierarchy to the parent gateway to release the funds
    function release() external payable signableOnly hasFee {
        CrossMsg memory crossMsg = CrossMsgHelper.createReleaseMsg(
            networkName,
            msg.sender,
            msg.value - crossMsgFee
        );

        _commitBottomUpMsg(crossMsg);
    }

    function setMembership(
        address[] memory validators,
        uint256[] memory weights
    ) external systemActorOnly {
        require(
            validators.length == weights.length,
            "number of validators is not equal to the number of validator weights"
        );

        // invalidate the previous validator set
        validatorNonce++;
        totalWeight = 0;

        // setup the new validator set
        for (uint validatorIndex = 0; validatorIndex < validators.length; ) {
            address validatorAddress = validators[validatorIndex];
            uint256 validatorWeight = weights[validatorIndex];

            require(validatorWeight > 0, "validator's weight cannot be zero");

            validatorSet[validatorNonce][validatorAddress] = validatorWeight;

            totalWeight += validatorWeight;

            // initial validators need to be conveniently funded with at least
            // 1 FIL for them to be able to commit the first few top-down messages.
            // They should use this FIL to fund their own addresses in the subnet
            // so they can keep committing top-down messages. If they don't do this,
            // they won't be able to send cross-net messages in their subnet.
            // Funds are only distributed in child subnets, where top-down checkpoints need
            // to be committed. This doesn't apply to the root.
            // TODO: Once account abstraction is conveniently supported, there will be
            // no need for this initial funding of validators.
            if (block.number == 1 && !networkName.isRoot())
                payable(validatorAddress).sendValue(INITIAL_VALIDATOR_FUNDS);

            unchecked {
                ++validatorIndex;
            }
        }
    }

    function _deriveExecutionStatus(
        EpochVoteSubmission storage voteSubmission
    ) internal view returns (VoteExecutionStatus) {
        uint256 threshold = (totalWeight * majorityPercentage) / 100;
        uint256 mostVotedWeight = voteSubmission.getMostVotedWeight();

        // threshold not reached, require THRESHOLD to be surpassed, equality is not enough!
        if (voteSubmission.totalSubmissionWeight <= threshold) {
            return VoteExecutionStatus.ThresholdNotReached;
        }

        // consensus reached
        if (mostVotedWeight > threshold) {
            return VoteExecutionStatus.ConsensusReached;
        }

        // now the total submissions has reached the threshold, but the most submitted vote
        // has yet to reach the threshold, that means consensus has not reached.
        // we do a early termination check, to see if consensus will ever be reached.
        //
        // consider an example that consensus will never be reached:
        //
        // -------- | -------------------------|--------------- | ------------- |
        //     MOST_VOTED                 THRESHOLD     TOTAL_SUBMISSIONS  TOTAL_WEIGHT
        //
        // we see MOST_VOTED is smaller than THRESHOLD, TOTAL_SUBMISSIONS and TOTAL_WEIGHT, if
        // the potential extra votes any vote can obtain, i.e. TOTAL_WEIGHT - TOTAL_SUBMISSIONS,
        // is smaller than or equal to the potential extra vote the most voted can obtain, i.e.
        // THRESHOLD - MOST_VOTED, then consensus will never be reached, no point voting, just abort.
        if (
            threshold - mostVotedWeight >=
            totalWeight - voteSubmission.totalSubmissionWeight
        ) {
            return VoteExecutionStatus.RoundAbort;
        }

        return VoteExecutionStatus.ReachingConsensus;
    }

    /// @notice marks the submission as executed, removes it from the queue if exist and retuns the most voted submission
    function _markSubmissionExecuted(EpochVoteSubmission storage voteSubmission) internal returns(TopDownCheckpoint storage mostVotedSubmission){
        mostVotedSubmission = voteSubmission.getMostVotedSubmission();

        // most voted submission is empty, so do nothing
        if (mostVotedSubmission.isEmpty()) return mostVotedSubmission;

        if (executableQueue.contains(mostVotedSubmission.epoch)) {
            require(mostVotedSubmission.epoch == executableQueue.first(), "epoch not the next executable epoch queue");

            // remove the current checkpoint epoch from the queue
            executableQueue.pop();
        }

        // update the last executed epoch
        lastVotingExecutedEpoch = mostVotedSubmission.epoch;
    }

    function submitTopDownCheckpoint(
        TopDownCheckpoint calldata checkpoint
    ) external signableOnly {
        uint256 validatorWeight = validatorSet[validatorNonce][msg.sender];


        if (initialized == false) revert NotInitialized();
        if (validatorWeight == 0) revert NotValidator();
        require(checkpoint.epoch > lastVotingExecutedEpoch, "epoch already executed");
        require(checkpoint.epoch > genesisEpoch && (checkpoint.epoch - genesisEpoch) % topDownCheckPeriod == 0, "epoch not votable");

        EpochVoteSubmission storage voteSubmission = epochVoteSubmissions[checkpoint.epoch];

        require(voteSubmission.submitters[voteSubmission.nonce][msg.sender] == false, "validator has already voted");

        // submit the vote
        voteSubmission.submitVote(checkpoint, msg.sender, validatorWeight);

        VoteExecutionStatus status = _deriveExecutionStatus(voteSubmission);

        TopDownCheckpoint memory submissionToExecute;
        
        if (status == VoteExecutionStatus.ConsensusReached) {
            uint64 currentVotingExecutableEpoch = lastVotingExecutedEpoch + topDownCheckPeriod;
            if (currentVotingExecutableEpoch == checkpoint.epoch) {
                
                submissionToExecute = _markSubmissionExecuted(voteSubmission);
            } else {
                // there are pending epochs to be executed, just store the submission and skip execution
                executableQueue.push(checkpoint.epoch);
            }
        } else if (status == VoteExecutionStatus.RoundAbort) {
            // abort the current round and reset the submission data.
            voteSubmission.reset();
        }

        // there is no execution for the current submission, so get the next executable epoch from the queue
        if (submissionToExecute.topDownMsgs.length == 0) {
            uint64 nextExecutableEpoch = executableQueue.first();
            uint64 nextVotingExecutableEpoch = lastVotingExecutedEpoch + topDownCheckPeriod;

            // make sure the next executable epoch exist and is valid
            if (nextExecutableEpoch > 0 && nextExecutableEpoch <= nextVotingExecutableEpoch) {
                EpochVoteSubmission storage nextVoteSubmission = epochVoteSubmissions[nextExecutableEpoch];

                submissionToExecute = _markSubmissionExecuted(nextVoteSubmission);
            }
        }

        //only execute the messages and update the last executed checkpoint when we have majority
        _applyTopDownMessages(submissionToExecute.topDownMsgs);
    }

    /// @notice sends an arbitrary cross message from the current subnet to a destination subnet.
    /// @param destination - destination subnet
    /// @param crossMsg - message to send
    function sendCross(
        SubnetID memory destination,
        CrossMsg memory crossMsg
    ) external payable signableOnly hasFee {
        // destination is the current network, you are better off with a good ol' message, no cross needed
        if (destination.equals(networkName)) revert CannotSendCrossMsgToItself();
        if (crossMsg.message.value != msg.value) revert NotEnoughFunds();
        if (crossMsg.message.to.rawAddress == address(0)) revert InvalidCrossMsgDestinationAddress();

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
        if (postboxHasOwner[msgCid][msg.sender] == false)
            revert InvalidPostboxOwner();

        CrossMsg storage crossMsg = postbox[msgCid];

        if (crossMsg.isEmpty()) revert PostboxNotExist();

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
        if (msg.value < crossMsgFee) revert NotEnoughFee();

        if (postboxHasOwner[msgCid][msg.sender] == false)
            revert InvalidPostboxOwner();

        CrossMsg storage crossMsg = postbox[msgCid];

        if (crossMsg.isEmpty()) revert PostboxNotExist();

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

        if (to.route.length == 0) revert InvalidCrossMsgDestinationSubnet();
        if (to.equals(networkName)) revert InvalidCrossMsgDestinationSubnet();

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

        if (registered == false) revert NotRegisteredSubnet();

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
        SubnetID memory forwarder,
        CrossMsg memory crossMsg
    ) internal {
        if (crossMsg.message.to.rawAddress == address(0))
            revert InvalidCrossMsgDestinationAddress();
        if (crossMsg.message.to.subnetId.route.length == 0)
            revert InvalidCrossMsgDestinationSubnet();
        if (
            crossMsg.message.method == METHOD_SEND &&
            crossMsg.message.value > address(this).balance
        ) {
            revert NotEnoughBalance();
        }

        IPCMsgType applyType = crossMsg.message.applyType(networkName);

        // If the cross-message destination is the current network.
        if (crossMsg.message.to.subnetId.equals(networkName)) {
            if (applyType == IPCMsgType.BottomUp) {
                (bool registered, Subnet storage subnet) = _getSubnet(
                    forwarder
                );

                if (registered == false) revert NotRegisteredSubnet();
                if (subnet.appliedBottomUpNonce != crossMsg.message.nonce)
                    revert InvalidCrossMsgNonce();

                subnet.appliedBottomUpNonce += 1;
            }

            if (applyType == IPCMsgType.TopDown) {
                if (appliedTopDownNonce != crossMsg.message.nonce)
                    revert InvalidCrossMsgNonce();
                appliedTopDownNonce += 1;
            }

            crossMsg.execute();
            return;
        }

        // when the destination is not the current network we add it to the postbox for further propagation
        bytes32 cid = crossMsg.toHash();

        postbox[cid] = crossMsg;
        postboxHasOwner[cid][crossMsg.message.from.rawAddress] = true;
    }

    function _applyTopDownMessages(CrossMsg[] memory crossMsgs) internal {
        for (uint i = 0; i < crossMsgs.length; ) {
            _applyMsg(SubnetID(new address[](0)), crossMsgs[i]);
            unchecked {
                ++i;
            }
        }
    }

    // @notice applies a cross-net messages coming from some other subnet. The forwarder argument determines the previous subnet that submitted the checkpoint triggering the cross-net message execution.  
    function _applyBottomUpMessages(
        SubnetID calldata forwarder,
        CrossMsg[] calldata crossMsgs
    ) internal {
        uint256 prevNonce = 0;
        for (uint i = 0; i < crossMsgs.length; ) {
            if (prevNonce > crossMsgs[i].message.nonce)
                revert InvalidCrossMsgsSortOrder();

            prevNonce = crossMsgs[i].message.nonce;
            _applyMsg(forwarder, crossMsgs[i]);
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
