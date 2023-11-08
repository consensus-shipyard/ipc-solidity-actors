// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {SubnetActorDiamond} from "./SubnetActorDiamond.sol";
import {IDiamond} from "./interfaces/IDiamond.sol";
 import {SubnetRegistryActorStorage} from "./lib/LibSubnetRegistryStorage.sol";
 import {GatewayCannotBeZero, FacetCannotBeZero} from "./errors/IPCErrors.sol";
 import {LibDiamond} from "./lib/LibDiamond.sol";

contract SubnetRegistryDiamond {


    SubnetRegistryActorStorage internal s;




    struct ConstructorParams {
        address gateway;
        address getterFacet;
        address managerFacet;
        bytes4[] subnetGetterSelectors;
        bytes4[] subnetManagerSelectors;
    }

       constructor(IDiamond.FacetCut[] memory _diamondCut, ConstructorParams memory params) {

        if (params.gateway == address(0)) {
            revert GatewayCannotBeZero();
        }
        if (params.getterFacet == address(0)) {
            revert FacetCannotBeZero();
        }
        if (params.managerFacet == address(0)) {
            revert FacetCannotBeZero();
        }

        LibDiamond.setContractOwner(msg.sender);
        LibDiamond.diamondCut({_diamondCut: _diamondCut, _init: address(0), _calldata: new bytes(0)});

        s.GATEWAY = params.gateway;
        s.SUBNET_GETTER_FACET = params.getterFacet;
        s.SUBNET_MANAGER_FACET = params.managerFacet;

        s.subnetGetterSelectors = params.subnetGetterSelectors;
        s.subnetManagerSelectors = params.subnetManagerSelectors;
    }


 
}
