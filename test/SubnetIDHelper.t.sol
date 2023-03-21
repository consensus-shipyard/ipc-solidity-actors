// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "openzeppelin-contracts/utils/Strings.sol";

import "../src/lib/SubnetIDHelper.sol";

contract SubnetIDHelperTest is Test {
    using Strings for *;
    using SubnetIDHelper for SubnetID;

    address ROOT_ADDRESS;
    address SUBNET_ONE_ADDRESS;
    address SUBNET_TWO_ADDRESS;
    address SUBNET_THREE_ADDRESS;

    bytes32 constant EMPTY_SUBNET_ID_HASH =
        0x2b88776ddf4d5290d360b934e1785b2f98fc538a5a4d0dc8dab162167e24841c;

    SubnetID EMPTY_SUBNET_ID = SubnetID(new address[](0));

    function setUp() public {
        ROOT_ADDRESS = makeAddr("root"); // 0x9f86b1918e5cf3a2150388024ff87df8c90d1d82
        SUBNET_ONE_ADDRESS = makeAddr("subnet_one"); // 0xb0c7ebf9ce6bfce01fba323a8b98054326032522
        SUBNET_TWO_ADDRESS = makeAddr("subnet_two"); // 0x374b3bb66c3a33e054e804d5ea825a8c2514816a
    }

    function test_GetParentSubnet_Fails_EmptySubnet() public {
        vm.expectRevert("error getting parent for subnet addr");

        EMPTY_SUBNET_ID.getParentSubnet();
    }

    function test_GetParentSubnet_Fails_NoParent() public {
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;

        SubnetID memory emptySubnet = SubnetID(route);

        vm.expectRevert("error getting parent for subnet addr");

        emptySubnet.getParentSubnet();
    }

    function test_GetParentSubnet_Works_ParentRoot() public view {
        address[] memory route = new address[](2);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;

        SubnetID memory subnetId = SubnetID(route);

        address[] memory expectedRoute = new address[](1);
        expectedRoute[0] = ROOT_ADDRESS;

        require(
            subnetId.getParentSubnet().toHash() ==
                SubnetID(expectedRoute).toHash()
        );
    }

    function test_GetParentSubnet_Works_ParentSubnetOne() public view {
        address[] memory route = new address[](3);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;
        route[2] = SUBNET_TWO_ADDRESS;

        SubnetID memory subnetId = SubnetID(route);

        address[] memory expectedRoute = new address[](2);
        expectedRoute[0] = ROOT_ADDRESS;
        expectedRoute[1] = SUBNET_ONE_ADDRESS;

        require(
            subnetId.getParentSubnet().toHash() ==
                SubnetID(expectedRoute).toHash()
        );
    }

    function test_CommonParent_Works() public view {
        address[] memory route1 = new address[](3);
        route1[0] = ROOT_ADDRESS;
        route1[1] = SUBNET_ONE_ADDRESS;
        route1[2] = SUBNET_TWO_ADDRESS;
        SubnetID memory subnetId1 = SubnetID(route1);

        address[] memory route2 = new address[](3);
        route2[0] = ROOT_ADDRESS;
        route2[1] = SUBNET_ONE_ADDRESS;
        route2[2] = SUBNET_THREE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(route2);

        address[] memory expectedRoute = new address[](2);
        expectedRoute[0] = ROOT_ADDRESS;
        expectedRoute[1] = SUBNET_ONE_ADDRESS;

        require(
            subnetId1.commonParent(subnetId2).toHash() ==
                SubnetID(expectedRoute).toHash()
        );
    }

    function test_CommonParent_EmptySubnetOnNoCommonParent() public view {
        address[] memory route1 = new address[](3);
        route1[0] = ROOT_ADDRESS;
        route1[1] = SUBNET_ONE_ADDRESS;
        route1[2] = SUBNET_TWO_ADDRESS;
        SubnetID memory subnetId1 = SubnetID(route1);

        address[] memory route2 = new address[](1);
        route2[0] = SUBNET_THREE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(route2);

        require(
            subnetId1.commonParent(subnetId2).toHash() == EMPTY_SUBNET_ID_HASH
        );
    }

    function test_Down_Works() public view {
        address[] memory route1 = new address[](1);
        route1[0] = ROOT_ADDRESS;
        SubnetID memory subnetId1 = SubnetID(route1);

        address[] memory route2 = new address[](2);
        route2[0] = ROOT_ADDRESS;
        route2[1] = SUBNET_ONE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(route2);

        address[] memory dest = new address[](3);
        dest[0] = ROOT_ADDRESS;
        dest[1] = SUBNET_ONE_ADDRESS;
        dest[2] = SUBNET_THREE_ADDRESS;
        SubnetID memory destSubnetId = SubnetID(dest);

        require(subnetId1.down(destSubnetId).equals(subnetId2));
        require(subnetId2.down(destSubnetId).equals(destSubnetId));

    }

    function test_ToString_Works_NoRoutes() public view {
        require(EMPTY_SUBNET_ID.toString().equal("/root"));
    }

    function test_ToString_Works_SingleRoute() public view {
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;

        require(
            SubnetID(route).toString().equal(
                "/root/0x9f86b1918e5cf3a2150388024ff87df8c90d1d82"
            )
        );
    }

    function test_ToString_Works_MultiRoute() public view {
        address[] memory route = new address[](3);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;
        route[2] = SUBNET_TWO_ADDRESS;

        require(
            SubnetID(route).toString().equal(
                "/root/0x9f86b1918e5cf3a2150388024ff87df8c90d1d82/0xb0c7ebf9ce6bfce01fba323a8b98054326032522/0x374b3bb66c3a33e054e804d5ea825a8c2514816a"
            )
        );
    }

    function test_ToHash_Works_EmptySubnet() public view {
        require(EMPTY_SUBNET_ID.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_ToHash_Works_NonEmptySubnet() public view {
        address[] memory route = new address[](2);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;

        SubnetID memory subnetId = SubnetID(route);

        bytes32 expectedSubnetIdHash = keccak256(abi.encode(subnetId));

        require(subnetId.toHash() == expectedSubnetIdHash);
    }

    function test_CreateSubnetId_Fails_EmptySubnet() public {
        vm.expectRevert("cannot set actor for empty subnet");

        EMPTY_SUBNET_ID.createSubnetId(SUBNET_ONE_ADDRESS);
    }

    function test_CreateSubnetId_Works() public view {
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;

        SubnetID memory subnetId = SubnetID({route: route}).createSubnetId(
            SUBNET_ONE_ADDRESS
        );

        address[] memory expectedRoute = new address[](2);
        expectedRoute[0] = ROOT_ADDRESS;
        expectedRoute[1] = SUBNET_ONE_ADDRESS;

        require(subnetId.toHash() == SubnetID({route: expectedRoute}).toHash());
    }

    function test_GetActor_Works_EmptySubnet() public view {
        address emptyActor = EMPTY_SUBNET_ID.getActor();
        require(emptyActor == address(0));
    }

    function test_GetActor_Works_RootSubnet() public view {
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;

        address emptyActor = SubnetID({route: route}).getActor();
        require(emptyActor == address(0));
    }

    function test_GetActor_Works_EmptyActor() public view {
        address[] memory route = new address[](2);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;

        address actor = SubnetID({route: route}).getActor();
        require(actor == SUBNET_ONE_ADDRESS);
    }

    function test_IsRoot_Works_EmptySubnet() public view {
        require(EMPTY_SUBNET_ID.isRoot() == false);
    }

    function test_IsRoot_Works_ChildSubnet() public view {
        address[] memory route = new address[](2);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;

        require(SubnetID({route: route}).isRoot() == false);
    }

    function test_IsRoot_Works_RootSubnet() public view {
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;

        require(SubnetID({route: route}).isRoot() == true);
    }

    function test_IsBottomUp_False() public view {
        address[] memory sub1 = new address[](2);
        sub1[0] = ROOT_ADDRESS;
        sub1[1] = SUBNET_ONE_ADDRESS;
        SubnetID memory sub1Id = SubnetID({route: sub1});

        address[] memory sub2 = new address[](3);
        sub2[0] = ROOT_ADDRESS;
        sub2[1] = SUBNET_ONE_ADDRESS;
        sub2[2] = SUBNET_TWO_ADDRESS;
        SubnetID memory sub2Id = SubnetID({route: sub2});

        require(sub1Id.isBottomUp(sub2Id) == false);
        require(sub2Id.isBottomUp(sub2Id) == false);

        address[] memory sub3 = new address[](4);
        sub3[0] = ROOT_ADDRESS;
        sub3[1] = SUBNET_ONE_ADDRESS;
        sub3[2] = SUBNET_TWO_ADDRESS;
        sub3[3] = SUBNET_THREE_ADDRESS;
        SubnetID memory sub3Id = SubnetID({route: sub3});

        require(sub2Id.isBottomUp(sub3Id) == false);
    }


    function test_IsBottomUp_True() public view {
        address[] memory sub1 = new address[](2);
        sub1[0] = ROOT_ADDRESS;
        sub1[1] = SUBNET_ONE_ADDRESS;
        SubnetID memory sub1Id = SubnetID({route: sub1});

        address[] memory sub2 = new address[](1);
        sub2[0] = ROOT_ADDRESS;
        SubnetID memory sub2Id = SubnetID({route: sub2});

        require(sub1Id.isBottomUp(sub2Id) == true);

        address[] memory sub3 = new address[](3);
        sub3[0] = ROOT_ADDRESS;
        sub3[1] = SUBNET_TWO_ADDRESS;
        sub3[2] = SUBNET_THREE_ADDRESS;
        SubnetID memory sub3Id = SubnetID({route: sub3});

        require(sub1Id.isBottomUp(sub3Id) == true);
    }
 
    function test_Equals_Works_Empty() public view {
        require(EMPTY_SUBNET_ID.equals(EMPTY_SUBNET_ID) == true);
        require(EMPTY_SUBNET_ID.equals(SubnetID({route: new address[](0)})) == true);
        address[] memory route = new address[](1);
        route[0] = ROOT_ADDRESS;
        require(EMPTY_SUBNET_ID.equals(SubnetID({route: route})) == false);
    }

    function test_Equals_Works_NonEmpty() public view {
        address[] memory route = new address[](2);
        route[0] = ROOT_ADDRESS;
        route[1] = SUBNET_ONE_ADDRESS;

        address[] memory route2 = new address[](2);
        route2[0] = ROOT_ADDRESS;
        route2[1] = SUBNET_TWO_ADDRESS;

        require(SubnetID({route: route}).equals(SubnetID({route: route})) == true);
        require(SubnetID({route: route}).equals(SubnetID({route: route2})) == false);
    }
}
