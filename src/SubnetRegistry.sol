// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./SubnetActor.sol";
import "./structs/Subnet.sol";
import "./lib/SubnetIDHelper.sol";

contract SubnetRegistry {
    using SubnetIDHelper for SubnetID;

    uint64 constant LIST_SUBNETS_PAGE_SIZE = 10;

    struct SubnetStoreInfo {
        address addr;
        uint64 index;
    }

    /// @notice Mapping that tracks the deployed subnet actors. 
    /// Key is the hash of Subnet ID, values are addresses.
    mapping(bytes32 => SubnetStoreInfo) public subnets;

    SubnetID[] private subnetIDs;

    address public gateway;

    /// @notice Event emitted when a new subnet is deployed.
    event SubnetDeployed(address subnetAddr, SubnetID subnetId);

    error NotSameGateway();
    error SubnetsOutOfBound();

    constructor(address _gateway) {
        gateway = _gateway;
    }

    function newSubnetActor(SubnetActor.ConstructParams calldata _params) external returns(address subnetAddr) {
        if (_params.ipcGatewayAddr != gateway) { revert NotSameGateway(); }

        subnetAddr = address(new SubnetActor(_params));

        SubnetID memory id = _params.parentId.createSubnetId(subnetAddr);

        bytes32 subnetHash = id.toHash();
        subnets[subnetHash].addr = subnetAddr;
        subnets[subnetHash].index = uint64(subnetIDs.length);

        subnetIDs.push(id);

        emit SubnetDeployed(subnetAddr, id);
    }

    function subnetAddress(SubnetID calldata _subnetId) external view returns(address subnet) {
        bytes32 subnetHash = _subnetId.toHash();
        subnet = subnets[subnetHash].addr;

        require(subnet != address(0), "Not exists");
    }

    // @notice List all subnets in the registry. This is equivalent to list all subnets in the gateway.
    // TODO: considering moving this function into gateway once its size is smallers. Currently delete
    // TODO: is not handled. Or gateway calls into registry to delete the subnets.
    function listSubnets(uint64 _page) external view returns(SubnetID[] memory) {
        uint64 start = _page * LIST_SUBNETS_PAGE_SIZE;
        if (start >= subnetIDs.length) { revert SubnetsOutOfBound(); }

        uint64 end = (_page + 1) * LIST_SUBNETS_PAGE_SIZE;
        if (end >= subnetIDs.length) { end = uint64(subnetIDs.length); }

        SubnetID[] memory results = new SubnetID[](end - start);
        for (uint64 i = 0; i < (end - start); i++) {
            results[i] = subnetIDs[i + start];
        }

        return results;
    }
}