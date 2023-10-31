import hre, { ethers } from 'hardhat'
import { DiamondLoupeFacet__factory } from '../typechain/factories/DiamondLoupeFacet__factory';
import { GatewayMessengerFacet__factory } from '../typechain/factories/GatewayMessengerFacet__factory';
import {
    getFacets,
    deployContractWithDeployer,
    getTransactionFees,
} from './util'
import solc from 'solc';
import { findLinkReferences } from 'solc';
import * as linker from 'solc/linker';





const lazyImport = async (module: any) => {
  return await import(module);
};


const { getSelectors, FacetCutAction } = require('./js/diamond.js')

const fs = require('fs');

function getBytecode(fileName) {
  try {
    // Read the file synchronously
    const fileContent = fs.readFileSync(fileName, 'utf8');
    
    // Split the file content into lines
    const lines = fileContent.split('\n');
    
    // Initialize a flag to identify when the target line is found
    let found = false;
    
    for (const line of lines) {
      // If the previous line was the target line, return the current line
      if (found) {
        // Trim semicolons and quotes from the beginning and end of the string
        return line.trim().replace(/^[";]+|[";]+$/g, '');
      }
      
      // Check if the current line is the target line
      if (line.includes('const _bytecode =')) {
        found = true;
      }
    }
    
    // If the loop completes without returning, the target line was not found
    throw new Error('Target line "const _bytecode =" not found in the file');
  } catch (error) {
    console.error('Error reading file:', error.message);
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
        const facetName = facet.name
        const libs = facet.libs
   const bytecodeNeedsLink = getBytecode( `./typechain/factories/${facetName}__factory.ts`);
   //const linkLibraryAddresses: GatewayMessengerFacetLibraryAddresses = {
         //"SubnetIDHelper": "0x116d795e669fd39aB4E91068e74B182434af503A",
           //"StorableMsgHelper": "0xbce050A3c7c39Be710beBaD368A4F0A1CdffAA39"
   //};
//
   //const constructorParams: GatewayMessengerFacetConstructorParams = [linkLibraryAddresses];
//
   //const res = GatewayMessengerFacet__factory.linkBytecode(constructorParams);

   //console.log(res);

   let libs2 = {};

   for (let key in libs) {
           let newKey = `src/lib/${key}.sol:${key}`;
               libs2[newKey] = libs[key];
   }

   console.log(libs2);

   //const bytecode = linker.linkBytecode(bytecodeNeedsLink, Object.entries(libs).reduce((acc, [key, value]) => ({ ...acc, [`src/lib/${key}.sol:${key}`]: value }), {}));

   const bytecode = linker.linkBytecode(bytecodeNeedsLink, libs2);
   const linkReferences = linker.findLinkReferences(bytecode);
   console.log(linkReferences)
   //

        //
//console.log('linking',facetName)
////console.log('linking',libs)
    //console.log(linkReferences);
    console.log(bytecode);
//

var i =0
console.log(i++)
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545');

console.log(i++)
// Create a wallet
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

console.log(i++)
// Create a contract factory with a dummy ABI
const contractFactory = new ethers.ContractFactory([], bytecode, wallet);

console.log(i++)
// Deploy the contract
const contract = await contractFactory.deploy();

console.log(i++)
// Log the contract address
console.log('Contract deployed to address:', contract.address);
console.log('Contract deployed to address:', contract);

// Log the transaction hash
console.log('Transaction hash:', contract.deployTransaction.hash);

// Wait for the contract to be mined
await contract.deployed();

// To print the contract details in a valid JSON format:
console.log(JSON.stringify({
      contractAddress: contract.address,
        transactionHash: contract.deployTransaction.hash,
          // ... any other details you want to include
}, null, 2));


// To print the contract details in a valid JSON format:
console.log(JSON.stringify(contract));



            const bytecodeLatest = await provider.getCode(contract.address)
            console.log("bytecodeLatest")
            console.log(bytecodeLatest)

        //console.log(facetName, libs)
        const contractFactory2 = await ethers.getContractFactory(facetName, { signer: deployer, libraries: libs, });
        const c = contractFactory2.attach(contract.address)
        console.log("factory attach:")
        console.log(c)
        //console.log(facetName)
        //console.log(contractFactory.bytecode)

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
