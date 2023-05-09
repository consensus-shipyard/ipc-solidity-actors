
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./CheckpointHelper.sol";
import "../structs/EpochVoteSubmission.sol";

library EpochVoteSubmissionHelper {
    using CheckpointHelper for TopDownCheckpoint;

    function submitVote(
        EpochVoteSubmission storage voteSubmission,
        TopDownCheckpoint calldata submission,
        address submitterAddress,
        uint256 submitterWeight
    ) external {
        bytes32 submissionHash = submission.toHash();

        voteSubmission.submitters[voteSubmission.nonce][submitterAddress] = true;
        voteSubmission.totalSubmissionWeight += submitterWeight;
        voteSubmission.submissionWeights[voteSubmission.nonce][submissionHash] += submitterWeight;

        // store the submission only the first time
        if (voteSubmission.submissions[submissionHash].isEmpty()) {
            voteSubmission.submissions[submissionHash] = submission;
        }

        uint256 mostVotedWeight = voteSubmission.submissionWeights[voteSubmission.nonce][voteSubmission.mostVotedSubmission];
        uint256 currVotedWeight = voteSubmission.submissionWeights[voteSubmission.nonce][submissionHash];

        if (mostVotedWeight < currVotedWeight) {
            voteSubmission.mostVotedSubmission = submissionHash;
        }
    }

    function reset(EpochVoteSubmission storage voteSubmission) external {
        voteSubmission.nonce++;
        voteSubmission.totalSubmissionWeight = 0;
        voteSubmission.mostVotedSubmission = EMPTY_HASH;
    }

    function getMostVotedWeight(
        EpochVoteSubmission storage voteSubmission
    ) external view returns (uint256) {
        return voteSubmission.submissionWeights[voteSubmission.nonce][voteSubmission.mostVotedSubmission];
    }

    function getMostVotedSubmission(EpochVoteSubmission storage voteSubmission) external view returns (TopDownCheckpoint storage) {
        return voteSubmission.submissions[voteSubmission.mostVotedSubmission];
    }
}