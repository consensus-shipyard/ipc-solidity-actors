// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import {ConsensusType} from "../../src/enums/ConsensusType.sol";

import "forge-std/console.sol";

import {SubnetIDHelper} from "../../src/lib/SubnetIDHelper.sol";
import {TestUtils} from "../TestUtils.sol";
import {IERC165} from "../../src/interfaces/IERC165.sol";
import {IDiamond} from "../../src/interfaces/IDiamond.sol";
import {IDiamondCut} from "../../src/interfaces/IDiamondCut.sol";
import {IDiamondLoupe} from "../../src/interfaces/IDiamondLoupe.sol";

import {SubnetActorDiamond} from "../../src/SubnetActorDiamond.sol";
import {SubnetID} from "../../src/structs/Subnet.sol";
import {SubnetRegistryDiamond} from "../../src/SubnetRegistryDiamond.sol";

import {RegisterSubnetFacet} from "../../src/subnetregistry/RegisterSubnetFacet.sol";
import {SubnetGetterFacet} from "../../src/subnetregistry/SubnetGetterFacet.sol";
import {DiamondLoupeFacet} from "../../src/diamond/DiamondLoupeFacet.sol";
import {DiamondCutFacet} from "../../src/diamond/DiamondCutFacet.sol";

import {EnumerableSet} from "openzeppelin-contracts/utils/structs/EnumerableSet.sol";

contract SubnetRegistryHandler {
    using EnumerableSet for EnumerableSet.AddressSet;

    address private constant DEFAULT_IPC_GATEWAY_ADDR = address(1024);
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    uint256 private constant DEFAULT_MIN_VALIDATOR_STAKE = 1 ether;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    int8 private constant DEFAULT_POWER_SCALE = 18;
    uint64 private constant ROOTNET_CHAINID = 123;
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    uint16 private constant DEFAULT_ACTIVE_VALIDATORS = 50;
    uint256 private constant CROSS_MSG_FEE = 10 gwei;

    EnumerableSet.AddressSet private owners;
    RegisterSubnetFacet private registerSubnetFacet;
    SubnetGetterFacet private subnetGetterFacet;

    address private registerSubnetFacetAddr;
    address private subnetGetterFacetAddr;

    constructor(address _subnetGetterFacetAddr, address _registerSubnetFacetAddr) {
        registerSubnetFacet = RegisterSubnetFacet(_registerSubnetFacetAddr);
        subnetGetterFacet = SubnetGetterFacet(_subnetGetterFacetAddr);
    }

    function getSubnetDeployedBy(address owner) external view returns (address subnet) {
        return subnetGetterFacet.latestSubnetDeployed(owner);
    }

    function getSubnetDeployedWithNonce(address owner, uint64 nonce) external view returns (address subnet) {
        return subnetGetterFacet.getSubnetDeployedByNonce(owner, nonce);
    }

    function getUserLastNonce(address user) external view returns (uint64 nonce) {
        return subnetGetterFacet.getUserLastNonce(user);
    }

    function getOwners() external view returns (address[] memory) {
        return owners.values();
    }

    function getGateway() external view returns (address) {
        return subnetGetterFacet.getGateway();
    }

    function deploySubnetActor(
        uint256 _minCollateral,
        uint64 _minValidators,
        uint64 _bottomUpCheckPeriod,
        uint16 _activeValidatorsLimit,
        uint8 _majorityPercentage,
        uint256 _minCrossMsgFee,
        uint8 _pathSize,
        int8 _powerScale
    ) public {
        if (_minCollateral > DEFAULT_MIN_VALIDATOR_STAKE || _minCollateral == 0) {
            _minCollateral = DEFAULT_MIN_VALIDATOR_STAKE;
        }
        if (_bottomUpCheckPeriod > DEFAULT_CHECKPOINT_PERIOD || _bottomUpCheckPeriod == 0) {
            _bottomUpCheckPeriod = DEFAULT_CHECKPOINT_PERIOD;
        }
        if (_majorityPercentage < 51 || _majorityPercentage > 100) {
            _majorityPercentage = DEFAULT_MAJORITY_PERCENTAGE;
        }
        if (_powerScale > DEFAULT_POWER_SCALE) {
            _powerScale = DEFAULT_POWER_SCALE;
        }
        if (_minValidators > DEFAULT_MIN_VALIDATORS || _minValidators == 0) {
            _minValidators = DEFAULT_MIN_VALIDATORS;
        }
        if (_pathSize > 5) {
            _pathSize = 1;
        }
        if (_minCrossMsgFee > 1 ether || _minCrossMsgFee == 0) {
            _minCrossMsgFee = CROSS_MSG_FEE;
        }
        if (_activeValidatorsLimit > DEFAULT_ACTIVE_VALIDATORS || _activeValidatorsLimit == 0) {
            _activeValidatorsLimit = DEFAULT_ACTIVE_VALIDATORS;
        }

        address[] memory path = new address[](_pathSize);
        for (uint256 i; i < _pathSize; ++i) {
            path[i] = address(uint160(i));
        }

        SubnetActorDiamond.ConstructorParams memory params = SubnetActorDiamond.ConstructorParams({
            parentId: SubnetID({root: ROOTNET_CHAINID, route: path}),
            ipcGatewayAddr: subnetGetterFacet.getGateway(),
            consensus: ConsensusType.Fendermint,
            minActivationCollateral: _minCollateral,
            minValidators: _minValidators,
            bottomUpCheckPeriod: _bottomUpCheckPeriod,
            majorityPercentage: _majorityPercentage,
            activeValidatorsLimit: _activeValidatorsLimit,
            powerScale: _powerScale,
            minCrossMsgFee: _minCrossMsgFee
        });

        registerSubnetFacet.newSubnetActor(params);
        if (!owners.contains(msg.sender)) {
            owners.add(msg.sender);
        }
    }
}