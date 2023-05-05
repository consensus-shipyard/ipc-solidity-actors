// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

struct ExecutableQueue {
    mapping(uint256 => uint64) epochs;
    mapping(uint64 => uint256) indexes;
    uint256 head; // index of the first element
    uint256 tail; // index after the last element
}
