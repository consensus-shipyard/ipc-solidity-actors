
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./CheckpointHelper.sol";
import "../structs/EpochVoteSubmission.sol";

library EpochVoteSubmissionHelper {
    using CheckpointHelper for TopDownCheckpoint;

    function submitVote(
        EpochVoteSubmission storage voteSubmission,
        TopDownCheckpoint calldata submission,
        uint256 voteSubmissionWeight
    ) internal {
        bytes32 submissionHash = submission.toHash();

        voteSubmission.submitters[voteSubmission.nonce][msg.sender] = true;
        voteSubmission.totalSubmissionWeight += voteSubmissionWeight;
        voteSubmission.submissionWeights[voteSubmission.nonce][submissionHash] += voteSubmissionWeight;

        if (voteSubmission.submissions[submissionHash].isEmpty()) {
            voteSubmission.submissions[submissionHash] = submission;
        }

        uint256 mostVotedWeight = voteSubmission.submissionWeights[voteSubmission.nonce][voteSubmission.mostVotedSubmission];
        uint256 currVotedWeight = voteSubmission.submissionWeights[voteSubmission.nonce][submissionHash];

        if (mostVotedWeight <= currVotedWeight) {
            voteSubmission.mostVotedSubmission = submissionHash;
        }
    }

    function reset(EpochVoteSubmission storage voteSubmission) internal {
        voteSubmission.nonce++;
        voteSubmission.totalSubmissionWeight = 0;
        voteSubmission.mostVotedSubmission = EMPTY_HASH;
    }

    function getMostVotedWeight(
        EpochVoteSubmission storage voteSubmission
    ) internal view returns (uint256) {
        return voteSubmission.submissionWeights[voteSubmission.nonce][voteSubmission.mostVotedSubmission];
    }

    function getMostVotedSubmission(EpochVoteSubmission storage voteSubmission) internal view returns (TopDownCheckpoint storage) {
        return voteSubmission.submissions[voteSubmission.mostVotedSubmission];
    }
}