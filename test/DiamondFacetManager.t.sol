// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/DiamondFacetManager.sol"; // Path to your DiamondFacetManager contract
import "../src/interfaces/IDiamond.sol";

contract DiamondFacetManagerTest is Test {
    DiamondFacetManager private diamondFacetManager;

    // Sample data for testing
    address private constant TEST_DIAMOND_ADDRESS = address(1); // Replace with a valid address in actual tests
    IDiamond.FacetCut[] private sampleFacetCuts;

    function setUp() public {
        diamondFacetManager = new DiamondFacetManager();

        // Setup sample facet cuts (dummy data for testing)
        IDiamond.FacetCut memory sampleCut = IDiamond.FacetCut({
            facetAddress: address(2), // Dummy address
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: new bytes4[](1)
        });
        sampleFacetCuts.push(sampleCut);
    }

    function testDeployment() public {
        // Test if the contract is deployed and the initial state is as expected
        assertEq(address(diamondFacetManager) != address(0), true, "Contract not deployed properly");
    }

    function testAddDiamondFacetData() public {
        uint256 index = diamondFacetManager.addDiamondFacetData(TEST_DIAMOND_ADDRESS, sampleFacetCuts);
        // Check if the returned index is correct
        assertEq(index, 0, "Incorrect index returned");

        // Retrieve the DiamondFacetData struct and verify its contents
        DiamondFacetManager.DiamondFacetData memory data = diamondFacetManager.getDiamondFacetData(index);
        assertEq(data.diamondContract, TEST_DIAMOND_ADDRESS, "Diamond contract address mismatch");
        assertEq(data.facetCuts.length, sampleFacetCuts.length, "Facet cuts length mismatch");
    }

    function testCutDiamondFacet() public {
        uint256 index = diamondFacetManager.addDiamondFacetData(TEST_DIAMOND_ADDRESS, sampleFacetCuts);
        // Cutting the diamond facet
        diamondFacetManager.cutDiamondFacet(index);
        // Attempting to cut again should fail
        vm.expectRevert("DiamondFacetData already used");
        diamondFacetManager.cutDiamondFacet(index);
    }

    function testCutDiamondFacetWithInvalidIndex() public {
        uint256 invalidIndex = 999; // An index that is not added
        vm.expectRevert("Index out of bounds");
        diamondFacetManager.cutDiamondFacet(invalidIndex);
    }

    function testCheckProposalAlwaysTrue() public {
        bool result = diamondFacetManager.checkProposal(0);
        assertTrue(result, "checkProposal should always return true");
    }
}
