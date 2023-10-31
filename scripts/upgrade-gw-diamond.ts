import hre, { ethers } from 'hardhat'
import { DiamondLoupeFacet__factory } from '../typechain/factories/DiamondLoupeFacet__factory'
import { GatewayMessengerFacet__factory } from '../typechain/factories/GatewayMessengerFacet__factory'
import {
    getFacets,
    deployContractWithDeployer,
    getTransactionFees,
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

const FacetNames = [
    // 'GatewayGetterFacet',
    'GatewayManagerFacet',
    'GatewayRouterFacet',
    'GatewayMessengerFacet',
    'DiamondLoupeFacet',
    'DiamondCutFacet',
]

// given a facet address and a gateway diamond,
// upgrade the diamond to use the new facet
async function _upgradeSubnetActorDiamond(
    gatewayAddress: string,
    replacementFacetName: string,
    facetLibs: { [key in string]: string },
) {
    if (!gatewayAddress) throw new Error(`Gateway is missing`)

    //if (!facetLibs || Object.keys(facetLibs).length === 0)
    //throw new Error(`Libraries are missing`)

    await hre.run('compile')
    const [deployer] = await ethers.getSigners()
    const txArgs = await getTransactionFees()

    let replacementFacet = await deployContractWithDeployer(
        deployer,
        replacementFacetName,
        facetLibs,
        txArgs,
    )
    await replacementFacet.deployed()

    const gateway = await ethers.getContractAt(
        'GatewayDiamond',
        gatewayAddress,
        deployer,
    )
    const facetCuts = [
        {
            facetAddress: replacementFacet.address,
            action: FacetCutAction.Replace,
            functionSelectors: getSelectors(replacementFacet),
        },
    ]
    const diamondCutter = await ethers.getContractAt(
        'DiamondCutFacet',
        gatewayAddress,
        deployer,
    )

    // 0x0 (contract address) and "" (call data) can be used to send call data to contract
    diamondCutter.diamondCut(
        facetCuts,
        '0x0000000000000000000000000000000000000000',
        '',
    )
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
    const provider = new ethers.providers.JsonRpcProvider(
        'http://127.0.0.1:8545',
    )

    // Create a wallet
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider)

    // Create a contract factory with a dummy ABI
    const contractFactory = new ethers.ContractFactory([], bytecode, wallet)

    // Deploy the contract
    const contract = await contractFactory.deploy()
    await contract.deployed()

    // Get the latest bytecode of the contract
    const bytecodeLatest = await provider.getCode(contract.address)
    return bytecodeLatest
}

// Function to upgrade the Subnet Actor Diamond
async function upgradeSubnetActorDiamond(deployments) {
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
            console.log(`Bytecode for ${contractAddress}:\n`, bytecode)
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
            console.info(
                `Facet bytecode not found in deployed bytecode: ${facet}`,
            )
        }
    }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    upgradeSubnetActorDiamond()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error)
            process.exit(1)
        })
}

exports.upgradeDiamond = upgradeSubnetActorDiamond
