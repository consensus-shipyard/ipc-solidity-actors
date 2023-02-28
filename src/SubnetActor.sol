// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;
import "./enums/ConsensusType.sol";
import "./enums/Status.sol";
import "./structs/Checkpoint.sol";
import "./structs/Subnet.sol";
import "./interfaces/ISubnetActor.sol";
import "./interfaces/IGateway.sol";
import "./lib/CheckpointHelper.sol";
import "openzeppelin-contracts/utils/structs/EnumerableSet.sol";
import "openzeppelin-contracts/security/ReentrancyGuard.sol";

contract SubnetActor is ISubnetActor, ReentrancyGuard {
    using EnumerableSet for EnumerableSet.AddressSet;
    using CheckpointHelper for mapping(int64 => Checkpoint);
    /// @notice Human-readable name of the subnet.
    string public name;
    /// @notice ID of the parent subnet
    SubnetID public parentId;
    /// @notice Address of the IPC gateway for the subnet
    address public ipcGatewayAddr;
    /// @notice Type of consensus algorithm.
    ConsensusType public consensus;
    /// @notice The minimum stake required to be a validator in this subnet
    uint256 public minValidatorStake;
    /// @notice Total collateral currently deposited in the SCA from the subnet
    uint256 public totalStake;
    /// @notice validator address to stake amount
    mapping(address => uint256) public stake;
    /// @notice current status of the subnet
    Status public status;
    /// @notice genesis block
    bytes public genesis;
    /// @notice number of blocks after which finality is reached
    int64 public finalityThreshold;
    /// @notice number of blocks between two checkpoints
    int64 public checkPeriod;
    /// @notice block number to corresponding checkpoint at that block
    mapping(int64 => Checkpoint) public checkpoints;
    /// @notice keccak256 hashed message data to set of validators who voted for the
    mapping(bytes32 => EnumerableSet.AddressSet) windowChecks;
    /// @notice List of validators in the subnet
    EnumerableSet.AddressSet private validators;
    /// @notice Minimal number of validators required for the subnet
    // to be able to validate new blocks.
    uint64 public minValidators;

    modifier onlyGateway() {
        require(msg.sender == ipcGatewayAddr, "only the IPC gateway can call this function");
        _;
    }

    modifier mutateState() {
        _;
        if(status == Status.Instantiated && totalStake >= minValidatorStake) {
            status = Status.Active;
        } else if(status == Status.Active && totalStake < minValidatorStake) {
            status = Status.Inactive;
        } else if(status == Status.Inactive && totalStake >= minValidatorStake) {
            status = Status.Active;
        } else if(status == Status.Terminating && totalStake == 0) {
            status = Status.Killed;
        }
    }

    function validatorCount() public returns (uint) {
        return validators.length();
    }

    function validatorAt(uint index) public returns (address) {
        return validators.at(index);
    }

    constructor(
        SubnetID memory _parentId,
        string memory _name,
        address _ipcGatewayAddr,
        ConsensusType _consensus,
        uint256 _minValidatorStake,
        uint64 _minValidators,
        int64 _finalityThreshold,
        int64 _checkPeriod,
        bytes memory _genesis
    ) {
        parentId = _parentId;
        name = _name;
        ipcGatewayAddr = _ipcGatewayAddr;
        consensus = _consensus;
        minValidatorStake = _minValidatorStake;
        minValidators = _minValidators;
        finalityThreshold = _finalityThreshold;
        checkPeriod = _checkPeriod;
        genesis = _genesis;
        status = Status.Instantiated;
    }

    function join(address _validator) external payable mutateState {
        require(_validator != address(0), "validator address cannot be zero");
        require(msg.value != 0, "a minimum collateral is required to join the subnet");

        stake[_validator] += msg.value;
        totalStake += msg.value;
        validators.add(_validator);

        if(status == Status.Instantiated) {
            if(totalStake >= minValidatorStake) {
                (bool success1,) = parentId.actor.call{value: totalStake}(abi.encodeWithSignature("register()"));
                require(success1);
            }
        } else {
            (bool success2, ) = parentId.actor.call{value: msg.value}(abi.encodeWithSignature("addStake()"));
            require(success2);
        }
    }

    function leave() external mutateState nonReentrant {
        require(stake[msg.sender] != 0, "caller has no stake in subnet");

        uint256 amount = stake[msg.sender];

        stake[msg.sender] = 0;
        totalStake -= amount;
        validators.remove(msg.sender);

        if(status == Status.Terminating) return;
        
        IGateway(parentId.actor).releaseStake(amount);
    
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success);

    }

    function kill() external mutateState {
        // require(address(this).balance == 0, "the subnet has non-zero balance");
        require(status != Status.Terminating && status != Status.Killed, "the subnet is already in a killed or terminating state");
        require(validators.length() == 0 && totalStake == 0, "this subnet can only be killed when all validators have left");

        status = Status.Terminating;

        IGateway(parentId.actor).kill();
    }

    function submitCheckpoint(Checkpoint calldata checkpoint) external {
        require(validators.contains(msg.sender), "not validator");
        require(status == Status.Active, "submitting checkpoints is not allowed while subnet is not active");
        require(checkpoints[checkpoint.data.epoch].signature.length != 0, "cannot submit checkpoint for epoch");
        require(checkpoint.data.epoch % checkPeriod != 0, "epoch in checkpoint doesn't correspond with a signing window");
        require(keccak256(abi.encode(checkpoint.data.source)) == keccak256(abi.encode(parentId)), "submitting checkpoint with the wrong source");
        
        bytes32 prevcheckpointHash = keccak256(abi.encode(checkpoints.getPrevCheckpoint(checkpoint.data.epoch, checkPeriod)));
        require(keccak256(abi.encode(checkpoint.data)) == prevcheckpointHash, "checkpoint data hash is the same as prevHash");
        
        bytes32 messageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", 
                keccak256(abi.encode(checkpoint.data))
            )
        );
        // bytes32 messageHash = keccak256(abi.encode(checkpoint.data));
          
        require(_recoverSigner(messageHash, checkpoint.signature) == msg.sender, "invalid signature");

        bytes32 cid = keccak256(abi.encode(checkpoint.data));

        require(!windowChecks[cid].contains(msg.sender), "miner has already voted the checkpoint");
    
        windowChecks[cid].add(msg.sender);
        uint sum = 0;
        for(uint i = 0; i < windowChecks[cid].length(); i++) {
            sum += stake[windowChecks[cid].at(i)];
            unchecked {
                ++i;
            }
        }

        bool hasMajority = sum >= (totalStake  * 2 / 3);
        if(!hasMajority) return;

        IGateway(parentId.actor).commitChildCheck(checkpoint);

    }

     function _recoverSigner(
        bytes32 _ethSignedMessageHash,
        bytes memory _signature
    ) internal pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _splitSignature(_signature);

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _splitSignature(
        bytes memory sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        // implicitly return (r, s, v)
    }

    function reward() public payable onlyGateway nonReentrant {
        require(msg.value != 0, "no rewards sent for distribution");

        uint validatorLength = validators.length();
        require(validatorLength != 0, "no validators in subnet");

        uint rewardAmount = msg.value / validatorLength;

        for(uint i = 0; i < validatorLength;)
        {
            (bool success, ) = validators.at(i).call{value: rewardAmount}("");
            require(success);
            unchecked {
                ++i;
            }
        }
    }

    receive() external payable {}
}
