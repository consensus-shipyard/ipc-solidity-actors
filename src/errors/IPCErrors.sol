// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

error AlreadyInitialized();
error AlreadyRegisteredSubnet();
error CallerHasNoStake();
error CannotReleaseZero();
error CannotSendCrossMsgToItself();
error CheckpointNotChained();
error CollateralIsZero();
error CollateralStillLockedInSubnet();
error EmptyAddress();
error EpochAlreadyExecuted();
error EpochNotVotable();
error GatewayCannotBeZero();
error InconsistentPrevCheckpoint();
error InvalidActorAddress();
error InvalidCheckpointEpoch();
error InvalidCheckpointSource();
error OldConfigurationNumber();
error InvalidCollateral();
error InvalidCrossMsgDstSubnet();
error InvalidCrossMsgFromSubnet();
error InvalidCrossMsgNonce();
error InvalidMajorityPercentage();
error InvalidSignature();
error InvalidSignatureLength();
error InvalidSubmissionPeriod();
error InvalidValidatorIndex();
error MessagesNotSorted();
error NoRewardToWithdraw();
error NoValidatorsInSubnet();
error NotEnoughValidatorsInSubnet();
error NotAllValidatorsHaveLeft();
error NotEmptySubnetCircSupply();
error NotEnoughBalance();
error NotEnoughBalanceForRewards();
error NotEnoughFee();
error NotEnoughFunds();
error NotEnoughFundsToRelease();
error NotEnoughSubnetCircSupply();
error NotGateway();
error NotInitialized();
error NotSystemActor();
error NotRegisteredSubnet();
error NotValidator();
error PostboxNotExist();
error RepliedSignature();
error SubnetAlreadyKilled();
error SubnetNotActive();
error ValidatorAlreadyVoted();
error ValidatorWeightIsZero();
error ValidatorsAndWeightsLengthMismatch();
error WorkerAddressInvalid();
error WrongCheckpointSource();
error ParentFinalityAlreadyCommitted();
error InvalidCrossMsgValue();
