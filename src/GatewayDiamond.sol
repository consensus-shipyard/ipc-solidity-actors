// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import { AppStorage } from "./lib/AppStorage.sol";
import { IDiamondCut } from "./interfaces/IDiamondCut.sol";
import { LibDiamond } from "./lib/Diamond.sol";
import {SubnetID, Subnet} from "./structs/Subnet.sol";
import {SubnetIDHelper} from "./lib/SubnetIDHelper.sol";

error FunctionNotFound(bytes4 _functionSelector);

contract GatewayDiamond {
    using SubnetIDHelper for SubnetID;

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

    constructor(IDiamondCut.FacetCut[] memory _diamondCut, ConstructorParams memory params){
        LibDiamond.setContractOwner(msg.sender);
        LibDiamond.diamondCut(_diamondCut, address(0), new bytes(0));

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

    function _fallback() internal {
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        address facet = ds.facetAddressAndSelectorPosition[msg.sig].facetAddress;
        if(facet == address(0)) {
            revert FunctionNotFound(msg.sig);
        }
        // Execute external function from facet using delegatecall and return any value.
        assembly {
        // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
        // execute function call using the facet
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
        // get any return value
            returndatacopy(0, 0, returndatasize())
        // return any return value or error back to the caller
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    /// @notice Will run when no functions matches call data
    fallback() external payable {
        _fallback();
    }

    /// @notice Same as fallback but called when calldata is empty
    receive() external payable {
        _fallback();
    }

}
