import { ethers } from 'hardhat'
import {
    getFacets,
    getBytecodeFromFacet,
    getOnChainBytecodeFromFacets,
    upgradeFacetOnChain,
} from './util'

/**
 * Log information about a missing facet.
 * @param facet - The facet to display.
 */
function logMissingFacetInfo(facet) {
    const formattedLibs = Object.entries(facet.libs)
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
}

/**
 * Handle facet upgrades on chain.
 * @param facet - The facet to process.
 * @param onChainFacets - the on chain facets and their functions as returned by DiamondLoupe
 * @param gatewayDiamondAddress - The address of the Gateway Diamond.
 * @param updatedFacets - A collection of updated facets.
 * @param onChainFacetBytecodes - The bytecodes from the on-chain facets.
 */
async function upgradeFacet(
    facet,
    onChainFacets,
    gatewayDiamondAddress,
    updatedFacets,
    onChainFacetBytecodes,
) {
    const facetBytecode = await getBytecodeFromFacet(facet)

    if (!onChainFacetBytecodes[facetBytecode]) {
        logMissingFacetInfo(facet)

        const newFacet = await upgradeFacetOnChain(gatewayDiamondAddress, facet)
        for (let key in newFacet) updatedFacets[key] = newFacet[key]

        const DEPLOYMENT_STATUS_MESSAGE = `
Deployment Status:
-------------------------
New replacement facet (${facet.name}) deployed.
`
        console.info(DEPLOYMENT_STATUS_MESSAGE)
    }
}

/**
 * Upgrade the Gateway Actor Diamond.
 * @param deployments - The deployment data.
 * @returns An object of updated facets.
 */
async function upgradeGatewayActorDiamond(deployments) {
    const gatewayDiamondAddress = deployments.Gateway

    const onChainFacets = await getFacets(gatewayDiamondAddress)
    const updatedFacets = {}
    const onChainFacetBytecodes = await getOnChainBytecodeFromFacets(
        onChainFacets,
    )

    for (const facet of deployments.Facets) {
        await upgradeFacet(
            facet,
            onChainFacets,
            gatewayDiamondAddress,
            updatedFacets,
            onChainFacetBytecodes,
        )
    }

    return updatedFacets
}

export { upgradeGatewayActorDiamond as upgradeDiamond }
