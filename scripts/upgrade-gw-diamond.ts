import hre, { ethers } from 'hardhat'
import {
    getFacets,
    deployContractWithDeployer,
    getTransactionFees,
} from './util'

const { getSelectors, FacetCutAction } = require('./js/diamond.js')

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
    if (!facetLibs || Object.keys(facetLibs).length === 0)
        throw new Error(`Libraries are missing`)

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
        'Gateway',
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

async function upgradeSubnetActorDiamond(
    deployments
) {
    const gatewayDiamondAddress = deployments.Gateway
    const [deployer] = await ethers.getSigners();

    const facets = await getFacets(gatewayDiamondAddress)
    console.log(facets)
    const provider = ethers.provider

    for (let contractAddress in facets) {
        try {
            // Fetch the bytecode
            const bytecode = await provider.getCode(contractAddress)

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


    for (let facetIndex in deployments.Facets) {
        const facet = deployments.Facets[facetIndex]
        const facetName = facet.Name
        const libs = facet.libs
        const contractFactory = await ethers.getContractFactory(facetName, { signer: deployer, libraries: libs, });
        console.log(facetName)
        console.log(contractFactory.bytecode)
        // const fs = require('fs')
        // const path = require('path')
        // const facetJsonPath = path.join(
        //     __dirname,
        //     '..',
        //     'out',
        //     `${facetName}.sol`,
        //     `${facetName}.json`,
        // )
        // const facetJson = fs.readFileSync(facetJsonPath, 'utf8')
        // const facetBytecode = JSON.parse(facetJson).deployedBytecode.object
        // console.log(facetName, facetBytecode)
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
