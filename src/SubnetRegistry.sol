// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {SubnetActorDiamond} from "./SubnetActorDiamond.sol";
import {IDiamond} from "./interfaces/IDiamond.sol";
import {CloneFactory} from "./CloneFactory.sol";

contract SubnetRegistry is CloneFactory {
    address public immutable gateway;

    /// The base contract address for clone factory
    address public getterFacet;
    address public managerFacet;

    /// The subnet getter facet functions selectors
    bytes4[] public subnetGetterSelectors;
    /// The subnet manager facet functions selectors
    bytes4[] public subnetManagerSelectors;

    /// @notice Event emitted when a new subnet is deployed.
    event SubnetDeployed(address subnetAddr);

    error WrongGateway();
    error ZeroGatewayAddress();
    error UnknownSubnet();

    constructor(address _gateway, address _getterFacet, address _managerFacet, bytes4[] memory _subnetGetterSelectors, bytes4[] memory _subnetManagerSelectors) {
        gateway = _gateway;

        getterFacet = _getterFacet;
        managerFacet = _managerFacet;

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
            facetAddress: createClone(getterFacet),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: subnetGetterSelectors
        });

        // set the diamond cut for subnet manager
        diamondCut[1] = IDiamond.FacetCut({
            facetAddress: address(managerFacet),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: subnetManagerSelectors
        });

        subnetAddr = address(new SubnetActorDiamond(diamondCut, _params));

        emit SubnetDeployed(subnetAddr);
    }
}
