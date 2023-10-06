// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

error AlreadyRegisteredSubnet();
error CallerHasNoStake();
error CannotReleaseZero();
error CannotSendCrossMsgToItself();
error CheckpointAlreadyExists();
error CheckpointAlreadyProcessed();
error CheckpointInfoAlreadyExists();
error IncompleteCheckpointExists();
error FailedAddSignatory();
error FailedAddSignature();
error FailedAddIncompleteCheckpoint();
error FailedRemoveIncompleteCheckpoint();
error CheckpointNotChained();
error CollateralIsZero();
error CollateralStillLockedInSubnet();
error EmptyAddress();
error HeightAlreadyExecuted();
error EpochNotVotable();
error GatewayCannotBeZero();
error InconsistentPrevCheckpoint();
error InvalidActorAddress();
error CheckpointNotCreated();
error CheckpointMembershipNotCreated();
error InvalidCheckpointEpoch();
error InvalidCheckpointMessagesHash();
error InvalidCheckpointSource();
error OldConfigurationNumber();
error InvalidCollateral();
error InvalidCrossMsgDstSubnet();
error InvalidCrossMsgFromSubnet();
error InvalidCrossMsgNonce();
error InvalidMajorityPercentage();
error InvalidSignature();
error InvalidSignatureErr(uint8);
error InvalidSignatureLength();
error InvalidSubmissionPeriod();
error MessagesNotSorted();
error NoRewardToWithdraw();
error NoValidatorsInSubnet();
error NotEnoughValidatorsInSubnet();
error NotAuthorized(address);
error NotAllValidatorsHaveLeft();
error NotEmptySubnetCircSupply();
error NotEnoughBalance();
error NotEnoughBalanceForRewards();
error NotEnoughFee();
error NotEnoughFunds();
error NotEnoughFundsToRelease();
error NotEnoughSubnetCircSupply();
error NotGateway();

error NotSystemActor();
error NotRegisteredSubnet();
error NotValidator();
error PostboxNotExist();
error InvalidRetentionHeight();
error SignatureReplay();
error SubnetAlreadyKilled();
error SubnetNotActive();
error ValidatorAlreadyVoted();
error ValidatorWeightIsZero();
error ValidatorsAndWeightsLengthMismatch();
error WorkerAddressInvalid();
error WrongCheckpointSource();
error ParentFinalityAlreadyCommitted();
error InvalidCrossMsgValue();
error ZeroMembershipWeight();
error WithdrawExceedingCollateral();
error CannotConfirmFutureChanges();
error NoCollateralToWithdraw();
error PQEmpty();
error PQDoesNotContainAddress();
error AddressShouldBeValidator();
error NotStakedBefore();
error InvalidConfigurationNumber();
