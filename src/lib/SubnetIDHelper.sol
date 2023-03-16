// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Subnet.sol";
import "openzeppelin-contracts/utils/Strings.sol";
import "forge-std/console.sol";

/// @title Helper library for manipulating SubnetID struct
/// @author LimeChain team
library SubnetIDHelper {
    using Strings for address;

    bytes32 public constant EMPTY_SUBNET_ID_HASH = keccak256(abi.encode(SubnetID(new address[](0))));

    function getParentSubnet(
        SubnetID memory subnet
    ) public pure returns (SubnetID memory) {
        require(
            subnet.route.length > 1,
            "error getting parent for subnet addr"
        );

        address[] memory route = new address[](subnet.route.length - 1);
        for (uint i = 0; i < route.length; i++) {
            route[i] = subnet.route[i];
        }

        return SubnetID({route: route});
    }

    function toString(
        SubnetID calldata subnet
    ) public pure returns (string memory) {
        string memory route = "/root";
        for (uint i = 0; i < subnet.route.length; i++) {
            route = string.concat(route, "/");
            route = string.concat(route, subnet.route[i].toHexString());
        }

        return route;
    }

    function toHash(SubnetID calldata subnet) public pure returns (bytes32) {
        return keccak256(abi.encode(subnet));
    }

    function createSubnetId(
        SubnetID calldata subnet,
        address actor
    ) public pure returns (SubnetID memory newSubnet) {
        require(subnet.route.length >= 1, "cannot set actor for empty subnet");

        newSubnet.route = new address[](subnet.route.length + 1);
        for (uint i = 0; i < subnet.route.length; i++) {
            newSubnet.route[i] = subnet.route[i];
        }

        newSubnet.route[newSubnet.route.length - 1] = actor;
    }

    function getActor(SubnetID memory subnet) public pure returns (address) {
        if (subnet.route.length <= 1) return address(0);

        return subnet.route[subnet.route.length - 1];
    }

    function isRoot(SubnetID calldata subnet) public pure returns (bool) {
        return subnet.route.length == 1;
    }

    function equals(
        SubnetID calldata subnet1,
        SubnetID calldata subnet2
    ) public pure returns (bool) {
        if (subnet1.route.length != subnet2.route.length) return false;

        for (uint i = 0; i < subnet1.route.length; i++) {
            if (subnet1.route[i] != subnet2.route[i]) return false;
        }

        return true;
    }

    function commonParent(
        SubnetID calldata subnet1,
        SubnetID calldata subnet2
    ) public pure returns (SubnetID memory) {
        uint i = 0;
        while (
            i < subnet1.route.length &&
            i < subnet2.route.length &&
            subnet1.route[i] == subnet2.route[i]
        ) {
            i++;
        }
        if (i == 0) return SubnetID({route: new address[](0)});

        address[] memory route = new address[](i);
        for (uint j = 0; j < i; j++) {
            route[j] = subnet1.route[j];
        }

        return SubnetID({route: route});
    }

    function down(
        SubnetID calldata subnet1,
        SubnetID calldata subnet2
    ) public pure returns (SubnetID memory) {
        uint i = 0;
        while (
            i < subnet1.route.length &&
            i < subnet2.route.length &&
            subnet1.route[i] == subnet2.route[i]
        ) {
            i++;
        }
        if (i == 0) return SubnetID({route: new address[](0)});

        address[] memory route = new address[](i + 1);
        for (uint j = 0; j < i; j++) {
            route[j] = subnet1.route[j];
        }
        if (i < subnet2.route.length) route[i] = subnet2.route[i];

        return SubnetID({route: route});
    }

    function isBottomUp(
        SubnetID calldata from,
        SubnetID calldata to
    ) public pure returns (bool) {
        SubnetID memory parent = commonParent(from, to);

        if(parent.route.length == 0) {
            return false;
        }
        return from.route.length > parent.route.length;
    }
}
