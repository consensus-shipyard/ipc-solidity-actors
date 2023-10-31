import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { providers, Wallet, ContractFactory, Contract } from 'ethers'
import { Contract, ethers } from 'hardhat'
import ganache from 'ganache-core'

export const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000'

export async function deployContractWithDeployer(
    deployer: SignerWithAddress,
    contractName: string,
    libs: { [key in string]: string },
    ...args: any[]
): Promise<Contract> {
    const contractFactory = await ethers.getContractFactory(contractName, {
        signer: deployer,
        libraries: libs,
    })
    return contractFactory.deploy(...args)
}

export async function getTransactionFees() {
    const feeData = await ethers.provider.getFeeData()

    return {
        maxFeePerGas: feeData.maxFeePerGas,
        maxPriorityFeePerGas: feeData.maxPriorityFeePerGas,
        type: 2,
    }
}

interface Facet {
    facetAddress: string
    functionSelectors: string[]
}
type FacetMap = { [key: string]: string[] }

export async function getFacets(diamondAddress: string): Promise<FacetMap> {
    // Ensure you have the ABI for the diamond loupe functions
    const diamondLoupeABI = [
        {
            inputs: [],
            name: 'facets',
            outputs: [
                {
                    components: [
                        {
                            internaltype: 'address',
                            name: 'facetaddress',
                            type: 'address',
                        },
                        {
                            internaltype: 'bytes4[]',
                            name: 'functionselectors',
                            type: 'bytes4[]',
                        },
                    ],
                    name: 'facets_',
                    type: 'tuple[]',
                },
            ],
            statemutability: 'view',
            constant: true,
            type: 'function',
        },
    ]

    const provider = ethers.provider
    const diamond = new Contract(diamondAddress, diamondLoupeABI, provider)
    const facetsData = await diamond.facets()

    // Convert facetsData to the Facet[] type.
    const facets: Facet[] = facetsData.map((facetData) => ({
        facetAddress: facetData[0],
        functionSelectors: facetData[1],
    }))

    const facetMap = facets.reduce((acc, facet) => {
        acc[facet.facetAddress] = facet.functionSelectors
        return acc
    }, {})

    return facetMap
}

async function startGanache() {
    return new Promise((resolve, reject) => {
        const server = ganache.server()
        server.listen(8545, (err) => {
            if (err) reject(err)
            else resolve(server)
        })
    })
}

async function stopGanache(server) {
    return new Promise((resolve, reject) => {
        server.close((err) => {
            if (err) reject(err)
            else resolve()
        })
    })
}

export async function getRuntimeBytecode(bytecode) {
    // Check if bytecode is provided
    if (!bytecode) {
        throw new Error('No bytecode provided')
    }
    const ganacheServer = await startGanache()

    const provider = new providers.JsonRpcProvider('http://127.0.0.1:8545')
    const wallet = new Wallet(process.env.PRIVATE_KEY, provider)
    const contractFactory = new ContractFactory([], bytecode, wallet)
    const contract = await contractFactory.deploy()
    await contract.deployed()

    const runtimeBytecode = await provider.getCode(contract.address)

    await stopGanache(ganacheServer)

    return runtimeBytecode
}
