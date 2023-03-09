// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../structs/Subnet.sol";
import "openzeppelin-contracts/utils/Strings.sol";
/// @title Helper library for manipulating SubnetID struct
/// @author LimeChain team
library SubnetIDHelper {
    using Strings for address;

    function newReleaseMsg(
        SubnetID calldata subnet,
        address signer,
        uint256 value,
        uint64 nonce
    ) public pure returns (StorableMsg memory) {
        return
            StorableMsg({
                from: IPCAddress({subnetId: subnet, rawAddress: signer}),
                to: IPCAddress({subnetId: subnet, rawAddress: signer}),
                value: value,
                nonce: nonce,
                method: 0,
                params: bytes("")
            });
    }

    function newFundMsg(
        SubnetID calldata subnet,
        address signer,
        uint256 value
    ) public pure returns (StorableMsg memory) {
        require(
            subnet.route.length >= 1,
            "error getting parent for subnet addr"
        );

        SubnetID memory parent = getParentSubnet(subnet);
        require(
            parent.route[parent.route.length - 1] != address(0),
            "error creating fund cross-message"
        );

        return
            StorableMsg({
                from: IPCAddress({subnetId: parent, rawAddress: signer}),
                to: IPCAddress({subnetId: subnet, rawAddress: signer}),
                value: value,
                nonce: 0,
                method: 0,
                params: bytes("")
            });
    }

    function getParentSubnet(SubnetID calldata subnet)
        public
        pure
        returns (SubnetID memory parent)
    {
        require(
            subnet.route.length != 0,
            "error getting parent for subnet addr"
        );

        parent.route = new address[](subnet.route.length - 1);
        for (uint i = 0; i < subnet.route.length - 1; i++) {
            parent.route[i] = subnet.route[i];
        }

    }

    function toString(SubnetID calldata subnet)
        public
        pure
        returns (string memory)
    {
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

    function setActor(SubnetID calldata subnet, address actor)
        public
        pure
        returns (SubnetID memory newSubnet)
    {
        require(subnet.route.length >= 1, "cannot set actor for empty subnet");

        newSubnet.route = new address[](subnet.route.length + 1);
        for (uint i = 0; i < subnet.route.length; i++) {
            newSubnet.route[i] = subnet.route[i];
        }

        newSubnet.route[newSubnet.route.length - 1] = actor;
    }

    function getActor(SubnetID calldata subnet) public pure returns (address) {
        if (subnet.route.length == 0) return address(0);

        return subnet.route[subnet.route.length - 1];
    }

    function isRoot(SubnetID calldata subnet) public pure returns (bool) {
        return subnet.route.length == 1;
    }

    function equals(SubnetID calldata subnet1, SubnetID calldata subnet2)
        public
        pure
        returns (bool)
    {
        if (subnet1.route.length != subnet2.route.length) return false;

        for (uint i = 0; i < subnet1.route.length; i++) {
            if (subnet1.route[i] != subnet2.route[i]) return false;
        }

        return true;
    }

    function commonParent(SubnetID calldata subnet1, SubnetID calldata subnet2)
        public
        pure
        returns (SubnetID memory)
    {
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

    function down(SubnetID calldata subnet1, SubnetID calldata subnet2)
        public
        pure
        returns (SubnetID memory)
    {
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
        if(i < subnet2.route.length)
            route[i] = subnet2.route[i];

        return SubnetID({route: route});
    }

    function up(SubnetID calldata subnet1, SubnetID calldata subnet2) public pure returns (SubnetID memory) {
        if(isRoot(subnet1)) return SubnetID({route: new address[](0)});
        if(isRoot(subnet2)) return SubnetID({route: new address[](0)});

        uint i = 0;
        while (
            i < subnet1.route.length &&
            i < subnet2.route.length &&
            subnet1.route[i] == subnet2.route[i]
        ) {
            i++;
        }
        if (i == 0) return SubnetID({route: new address[](0)});

        address[] memory route = new address[](i - 1);
        for (uint j = 0; j < i - 1; j++) {
            route[j] = subnet1.route[j];
        }

        return SubnetID({route: route});
    }

    function isBottomUp(SubnetID calldata from, SubnetID calldata to) public pure returns (bool){
        SubnetID memory commonParent = commonParent(from, to);
        if(commonParent.route.length == 0) return true;
        return from.route.length > commonParent.route.length;
    }
}
