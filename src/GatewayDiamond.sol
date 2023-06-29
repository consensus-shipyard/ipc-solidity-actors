// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "../lib/AppStorage.sol";

contract GatewayDiamond {
    AppStorage internal s;

    // uint8 constant MIN_CHECKPOINT_PERIOD = 10;
    uint256 public constant MIN_COLLATERAL_AMOUNT = 1 ether;

    /// @notice minimum checkpoint period. Values get clamped to this
    uint8 public constant MIN_CHECKPOINT_PERIOD = 10;

    struct ConstructorParams {
        SubnetID networkName;
        uint64 bottomUpCheckPeriod;
        uint64 topDownCheckPeriod;
        uint256 msgFee;
        uint8 majorityPercentage;
    }

    constructor(ConstructorParams memory params){
        s.networkName = params.networkName;
        s.minStake = MIN_COLLATERAL_AMOUNT;
        s.bottomUpCheckPeriod = params.bottomUpCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.bottomUpCheckPeriod;
        s.topDownCheckPeriod = params.topDownCheckPeriod < MIN_CHECKPOINT_PERIOD
            ? MIN_CHECKPOINT_PERIOD
            : params.topDownCheckPeriod;
        s.crossMsgFee = params.msgFee;

        // the root doesn't need to be explicitly initialized
        if (s.networkName.isRoot()) {
            s.initialized = true;
        }
    }
}
