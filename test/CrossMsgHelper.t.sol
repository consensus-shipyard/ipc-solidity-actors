// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/lib/CrossMsgHelper.sol";
import "../src/lib/SubnetIDHelper.sol";

contract CrossMsgHelperTest is Test {
    using SubnetIDHelper for SubnetID;
    using CrossMsgHelper for CrossMsg;
    using CrossMsgHelper for CrossMsg[];

    bytes32 constant EMPTY_CROSS_MSGS_HASH =
        keccak256(abi.encode(new CrossMsg[](0)));
    bytes32 constant EMPTY_CROSS_MSG_HASH =
        keccak256(
            abi.encode(
                CrossMsg({
                    message: StorableMsg({
                        from: IPCAddress({
                            subnetId: SubnetID(new address[](0)),
                            rawAddress: address(0)
                        }),
                        to: IPCAddress({
                            subnetId: SubnetID(new address[](0)),
                            rawAddress: address(0)
                        }),
                        value: 0,
                        nonce: 0,
                        method: 0,
                        params: EMPTY_BYTES
                    }),
                    wrapped: false
                })
            )
        );

    CrossMsg public crossMsg;
    CrossMsg[] public crossMsgs;

    function test_ToHash_Works_EmptyCrossMsg() public view {
        require(crossMsg.toHash() == EMPTY_CROSS_MSG_HASH);
    }

    function test_ToHash_Works_NonEmptyCrossMsg() public {
        crossMsg.message.nonce = 1;

        // hash of cross msg with nonce = 1
        bytes32 expectedHash = 0xf4a7693a381a21cd772723e52656a0a91111ed118c7c87fa3bb7061b75c61330;

        require(crossMsg.toHash() == expectedHash);
    }

    function test_ToHash_Works_EmptyCrossMsgs() public view {
        require(crossMsgs.toHash() == EMPTY_CROSS_MSGS_HASH);
    }

    function test_ToHash_Works_NonEmptyCrossMsgs() public {
        crossMsg.message.nonce = 1;
        crossMsgs.push(crossMsg);

        // hash of cross msg array containing 1 element with nonce = 1
        bytes32 expectedHash = 0xea420f08de853f9408624b29bc7b4ffea5db75e5cfb1865eda8b8326a6e264d6;

        require(crossMsgs.toHash() == expectedHash);
    }

    function test_CreateReleaseMsg_Works(
        uint256 releaseAmount,
        uint64 nonce,
        address sender
    ) public {
        address[] memory route = new address[](2);
        route[0] = makeAddr("root");
        route[1] = makeAddr("subnet");
        SubnetID memory subnetId = SubnetID(route);

        vm.prank(sender);

        CrossMsg memory releaseMsg = CrossMsgHelper.createReleaseMsg(
            subnetId,
            sender,
            releaseAmount,
            nonce
        );

        address[] memory parentRoute = new address[](1);
        parentRoute[0] = route[0];
        SubnetID memory parentSubnetId = SubnetID(parentRoute);

        require(releaseMsg.message.from.subnetId.toHash() == subnetId.toHash());
        require(releaseMsg.message.from.rawAddress == BURNT_FUNDS_ACTOR);
        require(
            releaseMsg.message.to.subnetId.toHash() == parentSubnetId.toHash()
        );
        require(releaseMsg.message.to.rawAddress == sender);
        require(releaseMsg.message.value == releaseAmount);
        require(releaseMsg.message.nonce == nonce);
        require(releaseMsg.message.method == 0);
        require(keccak256(releaseMsg.message.params) == keccak256(EMPTY_BYTES));
        require(releaseMsg.wrapped == false);
    }

    function test_CreateReleaseMsg_Fails_SubnetNoParent(
        uint256 releaseAmount,
        uint64 nonce,
        address sender
    ) public {
        address[] memory route = new address[](1);
        route[0] = makeAddr("root");
        SubnetID memory subnetId = SubnetID(route);

        vm.expectRevert("error getting parent for subnet addr");

        CrossMsgHelper.createReleaseMsg(subnetId, sender, releaseAmount, nonce);
    }

    function test_CreateFundMsg_Works(
        uint256 fundAmount,
        address sender
    ) public {
        address[] memory route = new address[](2);
        route[0] = makeAddr("root");
        route[1] = makeAddr("subnet");
        SubnetID memory subnetId = SubnetID(route);

        vm.prank(sender);

        CrossMsg memory fundMsg = CrossMsgHelper.createFundMsg(
            subnetId,
            sender,
            fundAmount
        );

        address[] memory parentRoute = new address[](1);
        parentRoute[0] = route[0];
        SubnetID memory parentSubnetId = SubnetID(parentRoute);

        require(
            fundMsg.message.from.subnetId.toHash() == parentSubnetId.toHash()
        );
        require(fundMsg.message.from.rawAddress == sender);
        require(fundMsg.message.to.subnetId.toHash() == subnetId.toHash());
        require(fundMsg.message.to.rawAddress == sender);
        require(fundMsg.message.value == fundAmount);
        require(fundMsg.message.nonce == 0);
        require(fundMsg.message.method == 0);
        require(keccak256(fundMsg.message.params) == keccak256(EMPTY_BYTES));
        require(fundMsg.wrapped == false);
    }

    function test_CreateFundMsg_Fails_SubnetNoParent(
        uint256 fundAmount,
        address sender
    ) public {
        address[] memory noParentRoute = new address[](1);
        noParentRoute[0] = makeAddr("root");
        SubnetID memory subnetId = SubnetID(noParentRoute);

        vm.expectRevert("error getting parent for subnet addr");

        CrossMsgHelper.createFundMsg(subnetId, sender, fundAmount);
    }
}
