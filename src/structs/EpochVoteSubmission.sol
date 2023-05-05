// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./Checkpoint.sol";

struct EpochVoteSubmission {
    uint256 nonce;
    uint256 totalSubmissionWeight;
    bytes32 mostVotedSubmission;
    mapping(uint256 => mapping(address => bool)) submitters;
    mapping(uint256 => mapping(bytes32 => uint256)) submissionWeights;
    mapping(bytes32 => TopDownCheckpoint) submissions;
}
