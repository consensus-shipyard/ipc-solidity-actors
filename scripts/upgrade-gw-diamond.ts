import hre, { ethers } from 'hardhat'
import {
    getFacets,
    deployContractWithDeployer,
    getTransactionFees,
    getRuntimeBytecode,
} from './util'
import solc from 'solc'
import { findLinkReferences } from 'solc'
import * as linker from 'solc/linker'

const lazyImport = async (module: any) => {
    return await import(module)
}

const { getSelectors, FacetCutAction } = require('./js/diamond.js')

const fs = require('fs')

function getBytecode(fileName) {
    try {
        // Read the file synchronously
        const fileContent = fs.readFileSync(fileName, 'utf8')

        // Split the file content into lines
        const lines = fileContent.split('\n')

        // Initialize a flag to identify when the target line is found
        let found = false

        for (const line of lines) {
            // If the previous line was the target line, return the current line
            if (found) {
                // Trim semicolons and quotes from the beginning and end of the string
                return line.trim().replace(/^[";]+|[";]+$/g, '')
            }

            // Check if the current line is the target line
            if (line.includes('const _bytecode =')) {
                found = true
            }
        }

        // If the loop completes without returning, the target line was not found
        throw new Error('Target line "const _bytecode =" not found in the file')
    } catch (error) {
        console.error('Error reading file:', error.message)
    }
}

/**
 * Filters the input array to only return strings that start with '0x'.
 *
 * @param {Object} input - The object containing the functionSelectors array.
 * @returns {Array} - An array of strings from functionSelectors that start with '0x'.
 */
function filterSelectors(input) {
    return input.filter((item) => {
        return typeof item === 'string' && item.startsWith('0x')
    })
}

// given a facet address and a gateway diamond,
// upgrade the diamond to use the new facet
async function upgradeGatewayActorFacet(
    gatewayAddress: string,
    replacementFacetName: string,
    facetLibs: { [key in string]: string },
) {
    console.info(`
Gateway Actor Facet Upgrade:
-----------------------------------
Gateway Address: ${gatewayAddress}
Replacement Facet Name: ${replacementFacetName}
`)

    if (!gatewayAddress) throw new Error(`Gateway is missing`)

    const [deployer] = await ethers.getSigners()
    const txArgs = await getTransactionFees()
    let replacementFacet = await deployContractWithDeployer(
        deployer,
        replacementFacetName,
        facetLibs,
        txArgs,
    )
    await replacementFacet.deployed()

    const facetCuts = [
        {
            facetAddress: replacementFacet.address,
            action: FacetCutAction.Replace,
            functionSelectors: filterSelectors(getSelectors(replacementFacet)),
        },
    ]
    const diamondCutter = await ethers.getContractAt(
        'DiamondCutFacet',
        gatewayAddress,
        deployer,
    )
    // 0x0 (contract address) and "" (call data) can be used to send call data to contract
    const tx = await diamondCutter.diamondCut(
        facetCuts,
        ethers.constants.AddressZero,
        ethers.utils.formatBytes32String(''),
        txArgs,
    )
    await tx.wait()
    return tx.hash
}

async function generateBytecode(facet) {
    const facetName = facet.name
    const libs = facet.libs
    const bytecodeNeedsLink = getBytecode(
        `./typechain/factories/${facetName}__factory.ts`,
    )
    let libs2 = {}
    // Loop through each key in the libs
    for (let key in libs) {
        let newKey = `src/lib/${key}.sol:${key}`
        libs2[newKey] = libs[key]
    }

    // Link the bytecode with the libraries
    const bytecode = linker.linkBytecode(bytecodeNeedsLink, libs2)
    return await getRuntimeBytecode(bytecode)
}

// Function to upgrade the Subnet Actor Diamond
async function upgradeGatewayActorDiamond(deployments) {
    // Get the Gateway Diamond address from the deployments
    const gatewayDiamondAddress = deployments.Gateway

    // Get the facets of the Gateway Diamond
    const facets = await getFacets(gatewayDiamondAddress)
    const provider = ethers.provider

    const deployedBytecode = {}

    // Loop through each contract address in the facets
    for (let contractAddress in facets) {
        try {
            // Fetch the bytecode of the contract
            const bytecode = await provider.getCode(contractAddress)
            deployedBytecode[bytecode] = contractAddress
            // Log the bytecode to the console
        } catch (error) {
            // Print any errors to stderr
            console.error(
                `Error fetching bytecode for ${contractAddress}:`,
                error.message,
            )
        }
    }

    // Loop through each facet in the deployments
    for (let facetIndex in deployments.Facets) {
        const facet = deployments.Facets[facetIndex]
        const facetBytecode = await generateBytecode(facet)
        if (!deployedBytecode.hasOwnProperty(facetBytecode)) {
            let formattedLibs = Object.entries(facet.libs)
                .map(([key, value]) => `  - ${key}: ${value}`)
                .join('\n')

            console.info(`
Facet Bytecode Not Found:
---------------------------------
Facet Name: ${facet.name}
Libraries:
${formattedLibs}
Address: ${facet.address}
`)

            const newFacetTX = await upgradeGatewayActorFacet(
                gatewayDiamondAddress,
                facet.name,
                facet.libs,
            )

            console.info(`
Deployment Status:
-------------------------
New replacement facet (${facet.name}) deployed.
Transaction Hash: ${newFacetTX}
`)
        }
    }
}
exports.upgradeDiamond = upgradeGatewayActorDiamond
exports.upgradeFacet = upgradeGatewayActorFacet
