// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {SubnetActor} from "./SubnetActor.sol";

import {SubnetActorDiamond} from "./SubnetActorDiamond.sol";
import {SubnetActorGetterFacet} from "./subnet/SubnetActorGetterFacet.sol";
import {SubnetActorManagerFacet} from "./subnet/SubnetActorManagerFacet.sol";
import {LibDiamond} from "./lib/LibDiamond.sol";

import {SubnetID} from "./structs/Subnet.sol";
import {SubnetIDHelper} from "./lib/SubnetIDHelper.sol";

contract SubnetRegistry {
    using SubnetIDHelper for SubnetID;

    /// @notice Mapping that tracks the deployed subnet actors per user.
    /// Key is the hash of Subnet ID, values are addresses.
    /// mapping owner => nonce => subnet
    mapping(address => mapping(uint64 => address)) public subnets;

    /// @notice Mapping that tracks the latest nonce of the deployed
    /// subnet for each user.
    /// owner => nonce
    mapping(address => uint64) public userNonces;

    address public immutable gateway;

    /// @notice Event emitted when a new subnet is deployed.
    event SubnetDeployed(address subnetAddr);

    error WrongGateway();
    error ZeroGatewayAddress();
    error UnknownSubnet();

    constructor(address _gateway) {
        if (_gateway == address(0)) {
            revert ZeroGatewayAddress();
        }
        gateway = _gateway;
    }

    function newSubnetActor(
        bytes4[] _getterSelectors,
        bytes4[] _managerSelectors,
        SubnetActor.ConstructParams calldata _params
    ) external returns (address subnetAddr) {
        if (params.ipcGatewayAddr != gateway) {
            revert WrongGateway();
        }

        IDiamond.FacetCut[] memory diamondCut = IDiamond.FacetCut[](2);

        // set the diamond cut for subnet getter
        diamondCut[0] = IDiamond.FacetCut({
            facetAddress: address(new SubnetActorGetterFacet()),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: _getterSelectors
        });

        // set the diamond cut for subnet manager
        diamondCut[1] = IDiamond.FacetCut({
            facetAddress: address(new SubnetActorManagerFacet()),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: _managerSelectors
        });

        subnetAddr = address(new SubnetActorDiamond(diamondCut, _params));

        subnets[msg.sender][userNonces[msg.sender]] = subnetAddr;
        ++userNonces[msg.sender];

        emit SubnetDeployed(subnetAddr);
    }

    /// @notice Returns the address of the latest subnet actor
    /// deployed by a user
    function latestSubnetDeployed(address owner) external view returns (address subnet) {
        subnet = subnets[owner][userNonces[owner] - 1];
        if (subnet == address(0)) {
            revert ZeroGatewayAddress();
        }
    }

    /// @notice Returns the address of a subnet actor deployed for a
    /// specific nonce by a user
    function getSubnetDeployedByNonce(address owner, uint64 nonce) external view returns (address subnet) {
        subnet = subnets[owner][nonce];
        if (subnet == address(0)) {
            revert ZeroGatewayAddress();
        }
    }
}
