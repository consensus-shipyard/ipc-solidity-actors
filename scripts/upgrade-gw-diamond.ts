import hre, { ethers } from "hardhat";
import {getFacets,deployContractWithDeployer, getTransactionFees} from './util';

const { getSelectors, FacetCutAction } = require('./js/diamond.js')


const FacetNames = [
   // 'GatewayGetterFacet',
    'GatewayManagerFacet',
    'GatewayRouterFacet',
    'GatewayMessengerFacet',
    'DiamondLoupeFacet',
    'DiamondCutFacet'
]


async function upgradeSubnetActorDiamond (gatewayDiamondAddress: string, libs: { [key in string]: string }) {
   const facets = await getFacets("0x5B509997C12098c908A5B160D4D25b645AB53343")
   console.log(facets)
   const provider = ethers.provider;

   for (let facetIndex in FacetNames){
    const facetName = FacetNames[facetIndex];
    console.log(facetName)
    const fs = require('fs');
    const path = require('path');
    const facetJsonPath = path.join(__dirname, '..', 'out', `${facetName}.sol`, `${facetName}.json`);
    const facetJson = fs.readFileSync(facetJsonPath, 'utf8');
    const facetBytecode = JSON.parse(facetJson).deployedBytecode.object;
     console.log(facetName, facetBytecode);

   }

   for (let contractAddress in facets) {
    try {
      // Fetch the bytecode
      const bytecode = await provider.getCode(contractAddress);

      // Log the bytecode to the console
      console.log(`Bytecode for ${contractAddress}:`, bytecode);
    } catch (error) {
      // Print any errors to stderr
      console.error(`Error fetching bytecode for ${contractAddress}:`, error.message);
    }
  }

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    upgradeSubnetActorDiamond()
        .then(() => process.exit(0))
        .catch(error => {
            console.error(error)
            process.exit(1)
        })
}

exports.upgradeDiamond = upgradeSubnetActorDiamond

