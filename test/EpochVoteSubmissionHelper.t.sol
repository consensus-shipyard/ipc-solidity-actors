// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";

import "../src/lib/EpochVoteSubmissionHelper.sol";
import "../src/structs/EpochVoteSubmission.sol";
import "../src/structs/Checkpoint.sol";

import "forge-std/console.sol";

contract EpochVoteSubmissionHelperTest is Test {
    using EpochVoteSubmissionHelper for EpochVoteSubmission;
    using CheckpointHelper for TopDownCheckpoint;

    EpochVoteSubmission public voteSubmission;
    TopDownCheckpoint private topDownCheckpoint;
    CrossMsg private crossMsg;

    address constant FIRST_SUBMITTER = address(100);
    address constant SECOND_SUBMITTER = address(101);
    uint256 constant FIRST_SUBMITTER_WEIGHT = 100;
    uint256 constant SECOND_SUBMITTER_WEIGHT = 101;


    function test_SubmitVote_Works_OneSubmissionOneVote() public {
        topDownCheckpoint.epoch = 10;

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);
        
        require(voteSubmission.mostVotedSubmission == topDownCheckpoint.toHash());
    }

    function test_SubmitVote_Works_OneSubmissionManyVotes() public {
        topDownCheckpoint.epoch = 10;

        bytes32 cpHash = topDownCheckpoint.toHash();

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);

        require(voteSubmission.mostVotedSubmission == cpHash);

        _asserSubmitVote(topDownCheckpoint, SECOND_SUBMITTER, SECOND_SUBMITTER_WEIGHT);

        require(voteSubmission.mostVotedSubmission == cpHash);
    }

    function test_SubmitVote_Works_NewMostVotedSubmission() public {        
        topDownCheckpoint.epoch = 10;

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);
        
        bytes32 firstCpHash = topDownCheckpoint.toHash();

       require(voteSubmission.mostVotedSubmission == firstCpHash);

        // simulates new top down checkpoint for the same epoch
        crossMsg.wrapped = true;
        topDownCheckpoint.topDownMsgs.push(crossMsg);

        _asserSubmitVote(topDownCheckpoint, SECOND_SUBMITTER, SECOND_SUBMITTER_WEIGHT);

        bytes32 secondCpHash = topDownCheckpoint.toHash();
        
        require(voteSubmission.mostVotedSubmission == secondCpHash);
    }

    function test_Reset_Works() public {
        topDownCheckpoint.epoch = 10;

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);

        require(voteSubmission.nonce == 0);

        voteSubmission.reset();

        uint256 newNonce = 1;
        bytes32 cpHash = topDownCheckpoint.toHash();

        require(voteSubmission.nonce == newNonce);
        require(voteSubmission.totalSubmissionWeight == 0);
        require(voteSubmission.mostVotedSubmission == EMPTY_HASH);
        require(voteSubmission.submitters[newNonce][FIRST_SUBMITTER] == false);
        require(voteSubmission.submissionWeights[newNonce][cpHash] == 0);
        require(voteSubmission.submissions[cpHash].isEmpty() == false);
    }

    function test_GetMostVotedWeight_Works() public {
        topDownCheckpoint.epoch = 10;

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);
        
        // new submission
        crossMsg.wrapped = true;
        topDownCheckpoint.topDownMsgs.push(crossMsg);

        _asserSubmitVote(topDownCheckpoint, SECOND_SUBMITTER, SECOND_SUBMITTER_WEIGHT);

        require(voteSubmission.getMostVotedWeight() == SECOND_SUBMITTER_WEIGHT);
    }

    function test_GetMostVotedWeight_Works_Empty() public view {
        require(voteSubmission.getMostVotedWeight() == 0);
    }

    function test_GetMostVotedSubmission_Works() public {
        topDownCheckpoint.epoch = 10;

        _asserSubmitVote(topDownCheckpoint, FIRST_SUBMITTER, FIRST_SUBMITTER_WEIGHT);

        // new submission
        crossMsg.wrapped = true;
        topDownCheckpoint.topDownMsgs.push(crossMsg);

        _asserSubmitVote(topDownCheckpoint, SECOND_SUBMITTER, SECOND_SUBMITTER_WEIGHT);

        TopDownCheckpoint memory mostVotedSubmission = voteSubmission.getMostVotedSubmission();

        require(mostVotedSubmission.topDownMsgs.length == 1);
        require(mostVotedSubmission.topDownMsgs[0].wrapped == true);
    }

    function _asserSubmitVote(TopDownCheckpoint memory submission, address submitterAddress, uint256 submitterWeight) internal {
        bytes32 submissionHash = submission.toHash();

        uint256 nonce = voteSubmission.nonce;
        uint256 totalSubmissionWeightBefore = voteSubmission.totalSubmissionWeight;
        uint256 totalSubmissionWeightsBefore = voteSubmission.submissionWeights[nonce][submissionHash];
        
        voteSubmission.submitVote(submission, submitterAddress, submitterWeight);
        
        require(voteSubmission.submitters[nonce][submitterAddress] == true);
        require(voteSubmission.totalSubmissionWeight == totalSubmissionWeightBefore + submitterWeight);
        require(voteSubmission.submissionWeights[nonce][submissionHash] == totalSubmissionWeightsBefore + submitterWeight);
        require(voteSubmission.submissions[submissionHash].isEmpty() == false);
    }
}
