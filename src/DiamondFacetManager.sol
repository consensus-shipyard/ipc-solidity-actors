// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "./interfaces/IDiamond.sol";
import "./interfaces/IDiamondCut.sol";

contract DiamondFacetManager {
    // Defining a new struct that includes a diamondContract address and a FacetCut[]
    struct DiamondFacetData {
        address diamondContract;
        IDiamond.FacetCut[] facetCuts;
    }

    // Array to store DiamondFacetData
    DiamondFacetData[] public diamondFacetDataList;
    // Mapping to track if a DiamondFacetData has been used
    mapping(uint256 => bool) public usedDiamondFacetData;

    event DiamondFacetDataAdded(uint256 indexed index, address diamondContract, IDiamond.FacetCut[] facetCut);
    event DiamondFacetCut(uint256 indexed index, address diamondContract);

    // Function to add a new DiamondFacetData
    function addDiamondFacetData(
        address _diamondContract,
        IDiamond.FacetCut[] memory _facetCuts
    ) public returns (uint256) {
        // Creating a new DiamondFacetData struct instance and adding it to the list
        diamondFacetDataList.push();
        uint256 newIndex = diamondFacetDataList.length - 1;

        // Getting a reference to the newly created DiamondFacetData's facetCuts storage array
        IDiamond.FacetCut[] storage storedFacetCuts = diamondFacetDataList[newIndex].facetCuts;

        // Manually copying each element of the _facetCuts memory array into the storage array
        for (uint256 i = 0; i < _facetCuts.length; i++) {
            storedFacetCuts.push(_facetCuts[i]);
        }

        // Setting the diamondContract address
        diamondFacetDataList[newIndex].diamondContract = _diamondContract;

        // Emitting the event with the index of the new DiamondFacetData
        emit DiamondFacetDataAdded(newIndex, _diamondContract, _facetCuts);

        // Returning the index of the new DiamondFacetData
        return newIndex;
    }

    // Function to retrieve a DiamondFacetData by index
    function getDiamondFacetData(uint256 index) public view returns (DiamondFacetData memory) {
        require(index < diamondFacetDataList.length, "Index out of bounds");
        return diamondFacetDataList[index];
    }

    // New method to check a proposal - currently a stub that always returns true
    function checkProposal(uint256 index) public pure returns (bool) {
        if (index >= 0) {} //noop for stub to not have warnings
        // Stub implementation - always returns true
        return true;
    }

    // Modified cutDiamondFacet method
    function cutDiamondFacet(uint256 index) public {
        require(index < diamondFacetDataList.length, "Index out of bounds");
        require(!usedDiamondFacetData[index], "DiamondFacetData already used");

        // Call checkProposal and revert if it returns false
        require(checkProposal(index), "Proposal check failed");

        // Mark this DiamondFacetData as used
        usedDiamondFacetData[index] = true;

        DiamondFacetData storage data = diamondFacetDataList[index];
        IDiamondCut diamondContract = IDiamondCut(data.diamondContract);

        // Call the diamondCut function on the diamond contract
        diamondContract.diamondCut(data.facetCuts, address(0), "");

        emit DiamondFacetCut(index, data.diamondContract);
    }
}
