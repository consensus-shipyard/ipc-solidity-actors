// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {SubnetActor} from "./SubnetActor.sol";
import {SubnetID} from "./structs/Subnet.sol";
import {IDiamond} from "../src/interfaces/IDiamond.sol";
import {IDiamondCut} from "../src/interfaces/IDiamondCut.sol";
import {SubnetIDHelper} from "./lib/SubnetIDHelper.sol";
import {SubnetActorDiamond} from "../src/SubnetActorDiamond.sol";
import {SubnetActorManagerFacet} from "../src/subnet/SubnetActorManagerFacet.sol";
import {SubnetActorGetterFacet} from "../src/subnet/SubnetActorGetterFacet.sol";
import {SubnetActorGetterFacetSelectors, SubnetActorManagerFacetSelectors} from "../src/gen/Selectors.sol";

contract SubnetActorDiamondRegistry {
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

    function newSubnetActorDiamond(SubnetActorDiamond.ConstructorParams calldata params) external returns (address) {
        if (params.ipcGatewayAddr != gateway) {
            revert WrongGateway();
        }

        SubnetActorManagerFacet saManager = new SubnetActorManagerFacet();
        SubnetActorGetterFacet saGetter = new SubnetActorGetterFacet();

        IDiamond.FacetCut[] memory saDiamondCut = new IDiamond.FacetCut[](2);

        saDiamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(saGetter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: abi.decode(SubnetActorGetterFacetSelectors, (bytes4[]))
            })
        );

        saDiamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(saManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: abi.decode(SubnetActorManagerFacetSelectors, (bytes4[]))
            })
        );

        SubnetActorDiamond subnetActorDiamondAddr = new SubnetActorDiamond(saDiamondCut, params);
        saManager = SubnetActorManagerFacet(address(subnetActorDiamondAddr));
        saGetter = SubnetActorGetterFacet(address(subnetActorDiamondAddr));

        subnets[msg.sender][userNonces[msg.sender]] = address(subnetActorDiamondAddr);
        ++userNonces[msg.sender];

        emit SubnetDeployed(address(subnetActorDiamondAddr));
        return address(subnetActorDiamondAddr);
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
