// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

error AddressShouldBeValidator();
error AlreadyRegisteredSubnet();
error CannotConfirmFutureChanges();
error CannotReleaseZero();
error CannotSendCrossMsgToItself();
error CheckpointAlreadyExists();
error CheckpointAlreadyProcessed();
error CheckpointInfoAlreadyExists();
error CheckpointNotCreated();
error CollateralIsZero();
error EmptyAddress();
error FailedAddIncompleteCheckpoint();
error FailedAddSignatory();
error FailedRemoveIncompleteCheckpoint();
error GatewayCannotBeZero();
error InvalidActorAddress();
error InvalidCheckpointEpoch();
error InvalidCheckpointMessagesHash();
error InvalidCheckpointSource();
error InvalidCollateral();
error InvalidConfigurationNumber();
error InvalidCrossMsgDstSubnet();
error InvalidCrossMsgFromSubnet();
error InvalidCrossMsgNonce();
error InvalidCrossMsgValue();
error InvalidMajorityPercentage();
error InvalidPowerScale();
error InvalidRetentionHeight();
error InvalidSignature();
error InvalidSignatureErr(uint8);
error InvalidSignatureLength();
error InvalidPublicKeyLength();
error InvalidSubmissionPeriod();
error InvalidSubnet();
error NoCollateralToWithdraw();
error NoRewardToWithdraw();
error NoValidatorsInSubnet();
error NotAllValidatorsHaveLeft();
error NotAuthorized(address);
error NotEmptySubnetCircSupply();
error NotEnoughBalance();
error NotEnoughBalanceForRewards();
error NotEnoughCollateral();
error NotEnoughFee();
error NotEnoughFunds();
error NotEnoughFundsToRelease();
error NotEnoughSubnetCircSupply();
error NotEnoughValidatorsInSubnet();
error NotGateway();
error NotOwnerOfPublicKey();
error NotRegisteredSubnet();
error NotStakedBefore();
error NotSystemActor();
error NotValidator(address);
error OldConfigurationNumber();
error PQDoesNotContainAddress();
error PQEmpty();
error ParentFinalityAlreadyCommitted();
error PostboxNotExist();
error SignatureReplay();
error SubnetAlreadyKilled();
error SubnetNotActive();
error SubnetNotFound();
error WithdrawExceedingCollateral();
error ZeroMembershipWeight();
error SubnetAlreadyBootstrapped();
error FacetCannotBeZero();
error WrongGateway();
error CannotFindSubnet();
error UnknownSubnet();
error MethodNotAllowed(string reason);
error InvalidFederationPayload();
