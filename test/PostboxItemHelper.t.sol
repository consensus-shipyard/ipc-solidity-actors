// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/lib/PostboxItemHelper.sol";
import "../src/lib/CrossMsgHelper.sol";

contract PostboxItemHelperTest is Test {
    using CrossMsgHelper for CrossMsg;

    bytes32 EMPTY_POSTBOX_HASH = keccak256(abi.encode(createItem(address(0))));

    function test_CreateItem_Works(CrossMsg calldata crossMsg) public pure {
        PostboxItem memory postboxItem = PostboxItemHelper.createItem(crossMsg);

        require(postboxItem.crossMsg.toHash() == crossMsg.toHash());
        require(postboxItem.owners.length == 1);
        require(postboxItem.owners[0] == crossMsg.message.from.rawAddress);
    }

    function test_ToHash_Works_Empty() public view {
        PostboxItem memory postboxItem = createItem(address(0));

        require(PostboxItemHelper.toHash(postboxItem) == EMPTY_POSTBOX_HASH);
    }

    function test_ToHash_Works_NonEmpty() public pure {
        PostboxItem memory postboxItem = createItem(address(1));

        require(
            PostboxItemHelper.toHash(postboxItem) ==
                keccak256(abi.encode(postboxItem))
        );
    }

    function createItem(
        address owner
    ) internal pure returns (PostboxItem memory) {
        address[] memory owners = new address[](1);
        owners[0] = owner;

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({
                    subnetId: SubnetID(new address[](0)),
                    rawAddress: owner
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
        });
        return PostboxItem(crossMsg, owners);
    }
}
