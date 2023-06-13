// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "openzeppelin-contracts/utils/Strings.sol";

import "../src/lib/SubnetIDHelper.sol";

contract SubnetIDHelperTest is Test {
    using Strings for *;
    using SubnetIDHelper for SubnetID;

    address SUBNET_ONE_ADDRESS;
    address SUBNET_TWO_ADDRESS;
    address SUBNET_THREE_ADDRESS;

    uint64 private constant ROOTNET_CHAINID = 123;
    // FIXME: This is not the correct hash for the empty subnet anymore
    bytes32 constant EMPTY_SUBNET_ID_HASH =
        0x2b88776ddf4d5290d360b934e1785b2f98fc538a5a4d0dc8dab162167e24841c;

    SubnetID EMPTY_SUBNET_ID = SubnetID(0, new address[](0));

    error NoParentForSubnet();
    error EmptySubnet();

    function setUp() public {
        SUBNET_ONE_ADDRESS = makeAddr("subnet_one"); // 0xb0c7ebf9ce6bfce01fba323a8b98054326032522
        SUBNET_TWO_ADDRESS = makeAddr("subnet_two"); // 0x374b3bb66c3a33e054e804d5ea825a8c2514816a
    }

    function test_GetParentSubnet_Fails_EmptySubnet() public {
        vm.expectRevert(NoParentForSubnet.selector);

        EMPTY_SUBNET_ID.getParentSubnet();
    }

    function test_GetParentSubnet_Fails_NoParent() public {
        address[] memory route = new address[](0);

        SubnetID memory emptySubnet = SubnetID(ROOTNET_CHAINID, route);

        vm.expectRevert(NoParentForSubnet.selector);

        emptySubnet.getParentSubnet();
    }

    function test_GetParentSubnet_Works_ParentRoot() public view {
        address[] memory route = new address[](1);
        route[0] = SUBNET_ONE_ADDRESS;

        SubnetID memory subnetId = SubnetID(ROOTNET_CHAINID, route);

        address[] memory expectedRoute = new address[](0);

        require(
            subnetId.getParentSubnet().toHash() ==
                SubnetID(ROOTNET_CHAINID, expectedRoute).toHash()
        );
    }

    function test_GetParentSubnet_Works_ParentSubnetOne() public view {
        address[] memory route = new address[](2);
        route[0] = SUBNET_ONE_ADDRESS;
        route[1] = SUBNET_TWO_ADDRESS;

        SubnetID memory subnetId = SubnetID(ROOTNET_CHAINID, route);

        address[] memory expectedRoute = new address[](1);
        expectedRoute[0] = SUBNET_ONE_ADDRESS;

        require(
            subnetId.getParentSubnet().toHash() ==
                SubnetID(ROOTNET_CHAINID, expectedRoute).toHash()
        );
    }

    function test_CommonParent_Works() public view {
        address[] memory route1 = new address[](2);
        route1[0] = SUBNET_ONE_ADDRESS;
        route1[1] = SUBNET_TWO_ADDRESS;
        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, route1);

        address[] memory route2 = new address[](2);
        route2[0] = SUBNET_ONE_ADDRESS;
        route2[1] = SUBNET_THREE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, route2);

        address[] memory expectedRoute = new address[](1);
        expectedRoute[0] = SUBNET_ONE_ADDRESS;

        require(
            subnetId1.commonParent(subnetId2).toHash() ==
                SubnetID(ROOTNET_CHAINID, expectedRoute).toHash()
        );
    }

    function test_CommonParent_EmptySubnetOnNoCommonParent() public view {
        address[] memory route1 = new address[](2);
        route1[0] = SUBNET_ONE_ADDRESS;
        route1[1] = SUBNET_TWO_ADDRESS;
        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, route1);

        address[] memory route2 = new address[](1);
        route2[0] = SUBNET_THREE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, route2);

        require(
            subnetId1.commonParent(subnetId2).toHash() == EMPTY_SUBNET_ID_HASH
        );
    }

    function test_Down_Works() public view {
        address[] memory route1 = new address[](0);
        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, route1);

        address[] memory route2 = new address[](1);
        route2[0] = SUBNET_ONE_ADDRESS;
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, route2);

        address[] memory dest = new address[](2);
        dest[0] = SUBNET_ONE_ADDRESS;
        dest[1] = SUBNET_THREE_ADDRESS;
        SubnetID memory sub3Id = SubnetID(ROOTNET_CHAINID, dest);

        require(subnetId2.down(subnetId1).equals(subnetId2));
        require(sub3Id.down(subnetId1).equals(subnetId2));
    }

    function test_Down_Subnet2RouteLenghtLargerThanSubnet1() public view {
        address[] memory route1 = new address[](0);

        address[] memory route2 = new address[](1);
        route2[1] = SUBNET_ONE_ADDRESS;

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, route1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, route2);

        require(subnetId1.down(subnetId2).toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_Down_NoCommonRoute() public view {
        address[] memory route1 = new address[](1);
        route1[1] = SUBNET_ONE_ADDRESS;

        address[] memory route2 = new address[](1);
        route2[0] = SUBNET_TWO_ADDRESS;

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, route1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, route2);

        require(subnetId1.down(subnetId2).toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_ToString_Works_NoRoutes() public view {
        require(EMPTY_SUBNET_ID.toString().equal("/r0"));
    }

    function test_ToString_Works_SingleRoute() public pure {
        address[] memory route = new address[](0);

        require(
            SubnetID(ROOTNET_CHAINID, route).toString().equal(
                "/r123/0x9f86b1918e5cf3a2150388024ff87df8c90d1d82"
            )
        );
    }

    function test_ToString_Works_MultiRoute() public view {
        address[] memory route = new address[](2);
        route[0] = SUBNET_ONE_ADDRESS;
        route[1] = SUBNET_TWO_ADDRESS;

        require(
            SubnetID(ROOTNET_CHAINID, route).toString().equal(
                "/root/0x9f86b1918e5cf3a2150388024ff87df8c90d1d82/0xb0c7ebf9ce6bfce01fba323a8b98054326032522/0x374b3bb66c3a33e054e804d5ea825a8c2514816a"
            )
        );
    }

    function test_ToHash_Works_EmptySubnet() public view {
        require(EMPTY_SUBNET_ID.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_ToHash_Works_NonEmptySubnet() public view {
        address[] memory route = new address[](1);
        route[0] = SUBNET_ONE_ADDRESS;

        SubnetID memory subnetId = SubnetID(ROOTNET_CHAINID, route);

        bytes32 expectedSubnetIdHash = keccak256(abi.encode(subnetId));

        require(subnetId.toHash() == expectedSubnetIdHash);
    }

    function test_CreateSubnetId_Fails_EmptySubnet() public {
        vm.expectRevert(EmptySubnet.selector);

        EMPTY_SUBNET_ID.createSubnetId(SUBNET_ONE_ADDRESS);
    }

    function test_CreateSubnetId_Works() public view {
        address[] memory route = new address[](0);

        SubnetID memory subnetId = SubnetID({
            root: ROOTNET_CHAINID,
            route: route
        }).createSubnetId(SUBNET_ONE_ADDRESS);

        address[] memory expectedRoute = new address[](1);
        expectedRoute[0] = SUBNET_ONE_ADDRESS;

        require(
            subnetId.toHash() ==
                SubnetID({root: ROOTNET_CHAINID, route: expectedRoute}).toHash()
        );
    }

    function test_GetActor_Works_EmptySubnet() public view {
        address emptyActor = EMPTY_SUBNET_ID.getActor();
        require(emptyActor == address(0));
    }

    function test_GetActor_Works_RootSubnet() public pure {
        address[] memory route = new address[](0);

        address emptyActor = SubnetID({root: ROOTNET_CHAINID, route: route})
            .getActor();
        require(emptyActor == address(0));
    }

    function test_GetActor_Works_EmptyActor() public view {
        address[] memory route = new address[](1);
        route[0] = SUBNET_ONE_ADDRESS;

        address actor = SubnetID({root: ROOTNET_CHAINID, route: route})
            .getActor();
        require(actor == SUBNET_ONE_ADDRESS);
    }

    function test_IsRoot_Works_EmptySubnet() public view {
        require(EMPTY_SUBNET_ID.isRoot() == false);
    }

    function test_IsRoot_Works_ChildSubnet() public view {
        address[] memory route = new address[](1);
        route[0] = SUBNET_ONE_ADDRESS;

        require(
            SubnetID({root: ROOTNET_CHAINID, route: route}).isRoot() == false
        );
    }

    function test_IsRoot_Works_RootSubnet() public pure {
        address[] memory route = new address[](0);

        require(
            SubnetID({root: ROOTNET_CHAINID, route: route}).isRoot() == true
        );
    }

    function test_Down_Some_1() public pure {
        address[] memory subnetRoute1 = new address[](4);
        subnetRoute1[0] = address(100);
        subnetRoute1[1] = address(101);
        subnetRoute1[2] = address(102);
        subnetRoute1[3] = address(103);

        address[] memory subnetRoute2 = new address[](2);
        subnetRoute2[0] = address(100);
        subnetRoute2[1] = address(101);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        address[] memory expectedRoute = new address[](3);
        expectedRoute[0] = address(100);
        expectedRoute[1] = address(101);
        expectedRoute[2] = address(102);

        require(
            subnetId.toHash() ==
                SubnetID(ROOTNET_CHAINID, expectedRoute).toHash()
        );
    }

    function test_Down_Some_2() public pure {
        address[] memory subnetRoute1 = new address[](4);
        subnetRoute1[0] = address(100);
        subnetRoute1[1] = address(101);
        subnetRoute1[2] = address(102);
        subnetRoute1[3] = address(103);

        address[] memory subnetRoute2 = new address[](3);
        subnetRoute2[0] = address(100);
        subnetRoute2[1] = address(101);
        subnetRoute2[2] = address(102);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        address[] memory expectedRoute = new address[](4);
        expectedRoute[0] = address(100);
        expectedRoute[1] = address(101);
        expectedRoute[2] = address(102);
        expectedRoute[3] = address(103);

        require(
            subnetId.toHash() ==
                SubnetID(ROOTNET_CHAINID, expectedRoute).toHash()
        );
    }

    function test_Down_None_1() public pure {
        address[] memory subnetRoute1 = new address[](1);
        subnetRoute1[0] = address(100);

        address[] memory subnetRoute2 = new address[](2);
        subnetRoute2[0] = address(100);
        subnetRoute2[1] = address(101);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        require(subnetId.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_Down_None_2() public pure {
        address[] memory subnetRoute1 = new address[](2);
        subnetRoute1[0] = address(100);
        subnetRoute1[1] = address(101);

        address[] memory subnetRoute2 = new address[](2);
        subnetRoute2[0] = address(100);
        subnetRoute2[1] = address(101);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        require(subnetId.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_Down_None_3() public pure {
        address[] memory subnetRoute1 = new address[](3);
        subnetRoute1[0] = address(100);
        subnetRoute1[1] = address(101);
        subnetRoute1[2] = address(102);

        address[] memory subnetRoute2 = new address[](4);
        subnetRoute2[0] = address(100);
        subnetRoute2[1] = address(101);
        subnetRoute2[2] = address(102);
        subnetRoute2[3] = address(103);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        require(subnetId.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_Down_None_4() public pure {
        address[] memory subnetRoute1 = new address[](2);
        subnetRoute1[0] = address(101);
        subnetRoute1[1] = address(100);

        address[] memory subnetRoute2 = new address[](1);
        subnetRoute2[0] = address(100);

        SubnetID memory subnetId1 = SubnetID(ROOTNET_CHAINID, subnetRoute1);
        SubnetID memory subnetId2 = SubnetID(ROOTNET_CHAINID, subnetRoute2);

        SubnetID memory subnetId = subnetId1.down(subnetId2);

        require(subnetId.toHash() == EMPTY_SUBNET_ID_HASH);
    }

    function test_IsBottomUp_False() public view {
        address[] memory sub1 = new address[](1);
        sub1[0] = SUBNET_ONE_ADDRESS;
        SubnetID memory sub1Id = SubnetID({root: ROOTNET_CHAINID, route: sub1});

        address[] memory sub2 = new address[](2);
        sub2[0] = SUBNET_ONE_ADDRESS;
        sub2[1] = SUBNET_TWO_ADDRESS;
        SubnetID memory sub2Id = SubnetID({root: ROOTNET_CHAINID, route: sub2});

        require(isBottomUp(sub1Id, sub2Id) == false);
        require(isBottomUp(sub2Id, sub2Id) == false);

        address[] memory sub3 = new address[](3);
        sub3[0] = SUBNET_ONE_ADDRESS;
        sub3[1] = SUBNET_TWO_ADDRESS;
        sub3[2] = SUBNET_THREE_ADDRESS;
        SubnetID memory sub3Id = SubnetID({root: ROOTNET_CHAINID, route: sub3});

        require(isBottomUp(sub2Id, sub3Id) == false);
    }

    function test_IsBottomUp_True() public view {
        address[] memory sub1 = new address[](1);
        sub1[0] = SUBNET_ONE_ADDRESS;
        SubnetID memory sub1Id = SubnetID({root: ROOTNET_CHAINID, route: sub1});

        address[] memory sub2 = new address[](0);
        SubnetID memory sub2Id = SubnetID({root: ROOTNET_CHAINID, route: sub2});

        require(isBottomUp(sub1Id, sub2Id) == true);

        address[] memory sub3 = new address[](2);
        sub3[0] = SUBNET_TWO_ADDRESS;
        sub3[1] = SUBNET_THREE_ADDRESS;
        SubnetID memory sub3Id = SubnetID({root: ROOTNET_CHAINID, route: sub3});

        require(isBottomUp(sub1Id, sub3Id) == true);
    }

    function test_Equals_Works_Empty() public view {
        require(EMPTY_SUBNET_ID.equals(EMPTY_SUBNET_ID) == true);
        require(
            EMPTY_SUBNET_ID.equals(
                SubnetID({root: ROOTNET_CHAINID, route: new address[](0)})
            ) == true
        );
        address[] memory route = new address[](0);
        require(
            EMPTY_SUBNET_ID.equals(
                SubnetID({root: ROOTNET_CHAINID, route: route})
            ) == false
        );
    }

    function test_Equals_Works_NonEmpty() public view {
        address[] memory route = new address[](1);
        route[0] = SUBNET_ONE_ADDRESS;

        address[] memory route2 = new address[](1);
        route2[0] = SUBNET_TWO_ADDRESS;

        require(
            SubnetID({root: ROOTNET_CHAINID, route: route}).equals(
                SubnetID({root: ROOTNET_CHAINID, route: route})
            ) == true
        );
        require(
            SubnetID({root: ROOTNET_CHAINID, route: route}).equals(
                SubnetID({root: ROOTNET_CHAINID, route: route2})
            ) == false
        );
    }

    function isBottomUp(
        SubnetID memory from,
        SubnetID memory to
    ) public pure returns (bool) {
        SubnetID memory parent = from.commonParent(to);
        if (parent.route.length == 0) return false;
        return from.route.length > parent.route.length;
    }
}
