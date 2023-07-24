// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {SubnetActorDiamond} from "./SubnetActorDiamond.sol";
import {SubnetActorGetterFacet} from "./subnet/SubnetActorGetterFacet.sol";
import {SubnetActorManagerFacet} from "./subnet/SubnetActorManagerFacet.sol";
import {IDiamond} from "./interfaces/IDiamond.sol";

contract SubnetRegistry {

    address public immutable gateway;

    /// The subnet getter facet functions selectors
    bytes4[] public subnetGetterSelectors;
    /// The subnet manager facet functions selectors
    bytes4[] public subnetManagerSelectors;

    /// @notice Event emitted when a new subnet is deployed.
    event SubnetDeployed(address subnetAddr);

    error WrongGateway();
    error ZeroGatewayAddress();
    error UnknownSubnet();

    constructor(address _gateway, bytes4[] memory _subnetGetterSelectors, bytes4[] memory _subnetManagerSelectors) {
        gateway = _gateway;

        subnetGetterSelectors = _subnetGetterSelectors;
        subnetManagerSelectors = _subnetManagerSelectors;
    }

    /// @notice Deploys a new subnet actor.
    /// @param _params The constructor params for Subnet Actor.
    function newSubnetActor(SubnetActorDiamond.ConstructorParams calldata _params) external returns (address subnetAddr) {
        if (_params.ipcGatewayAddr != gateway) {
            revert WrongGateway();
        }

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](2);

        // set the diamond cut for subnet getter
        diamondCut[0] = IDiamond.FacetCut({
            facetAddress: address(new SubnetActorGetterFacet()),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: subnetGetterSelectors
        });

        // set the diamond cut for subnet manager
        diamondCut[1] = IDiamond.FacetCut({
            facetAddress: address(new SubnetActorManagerFacet()),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: subnetManagerSelectors
        });

        subnetAddr = address(new SubnetActorDiamond(diamondCut, _params));

        emit SubnetDeployed(subnetAddr);
    }
}
