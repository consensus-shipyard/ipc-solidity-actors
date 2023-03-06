// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Subnet.sol";

/// @title Helper library for manipulating SubnetID struct
/// @author LimeChain team
library SubnetIDHelper {
    function getParentSubnet(SubnetID memory subnet) public pure returns (SubnetID memory) {
        require(subnet.route.length != 0, "error getting parent for subnet addr");

        address[] memory route = new address[](subnet.route.length - 1);
        for(uint i = 0; i < subnet.route.length - 1; i++) {
            route[i] = subnet.route[i];
        }
        route[route.length - 1] = subnet.route[route.length];
        
        return SubnetID({
            route: route
        });
    }

    function toString(SubnetID memory subnet) public pure returns (string memory) {
        string memory route = "/root";
        for(uint i = 0; i < subnet.route.length; i++) {
            route = string(abi.encodePacked(route, "/", subnet.route[i]));
        }

        return route;
    }

    function setActor(SubnetID memory subnet, address actor) public pure returns (SubnetID memory newSubnet) {
        require(subnet.route.length >= 1, "cannot set actor for empty subnet");

        newSubnet.route = new address[](subnet.route.length + 1);
        for(uint i = 0; i < subnet.route.length; i++) {
            newSubnet.route[i] = subnet.route[i];
        }

        newSubnet.route[newSubnet.route.length - 1] = actor;
    }

    function getActor(SubnetID memory subnet) public pure returns (address) {
        if(subnet.route.length == 0)
            return address(0);

        return subnet.route[subnet.route.length - 1];
    }

    function isRoot(SubnetID memory subnet) public pure returns (bool) {
        return subnet.route.length == 1;
    }
}