import hre, { ethers } from "hardhat";
import {deployContractWithDeployer, getTransactionFees} from './util';

const { getSelectors, FacetCutAction } = require('./js/diamond.js')

async function deployGatewayDiamond (libs: { [key in string]: string }) {
    if (!libs || Object.keys(libs).length === 0) throw new Error(`Libraries are missing`);

    console.log("Deploying Gateway Actor diamond with libraries:", libs);

    await hre.run('compile');


    const [deployer] = await ethers.getSigners();
    const txArgs = await getTransactionFees();

    const FacetNames = [
        'GatewayGetterFacet',
        'GatewayManagerFacet',
        'GatewayRouterFacet'
    ]
    console.log('Target facets: ', FacetNames)
    // The `facetCuts` variable is the FacetCut[] that contains the functions to add during diamond deployment
    const facetCuts = []

    type Libraries = {
        [libraryName: string]: string;
    }

    // ----

    const getterFacetLibs: Libraries = {
        "CheckpointHelper": libs["CheckpointHelper"],
        "SubnetIDHelper": libs["SubnetIDHelper"]
    }

    let getterFacet = await deployContractWithDeployer(
        deployer,
        "GatewayGetterFacet",
        getterFacetLibs, txArgs
    );
    await getterFacet.deployed();
    console.log(`${FacetNames[0]} deployed: ${getterFacet.address}`)

    facetCuts.push({
        facetAddress: getterFacet.address,
        action: FacetCutAction.Add,
        functionSelectors: getSelectors(getterFacet)
    })

    console.log('GatewayGetterFacet address : ', facetCuts[0].facetAddress)

    // ----

    const managerFacetLibs: Libraries = {
        "AccountHelper": libs["AccountHelper"],
        "CrossMsgHelper": libs["CrossMsgHelper"],
        "SubnetIDHelper": libs["SubnetIDHelper"]
    }

    const managerFacet = await deployContractWithDeployer(
        deployer,
        "GatewayManagerFacet",
        managerFacetLibs,
        txArgs
    );

    console.log(`${FacetNames[1]} deployed: ${managerFacet.address}`)
    facetCuts.push({
        facetAddress: managerFacet.address,
        action: FacetCutAction.Add,
        functionSelectors: getSelectors(managerFacet)
    })

    console.log('GatewayManager facet: ', facetCuts[1].facetAddress)

    // ----

    const routerFacetLibs: Libraries = {
        "AccountHelper": libs["AccountHelper"],
        "CrossMsgHelper": libs["CrossMsgHelper"],
        "EpochVoteSubmissionHelper": libs["EpochVoteSubmissionHelper"],
        "ExecutableQueueHelper": libs["ExecutableQueueHelper"],
        "CheckpointHelper": libs["CheckpointHelper"],
        "SubnetIDHelper": libs["SubnetIDHelper"],
        "StorableMsgHelper": libs["StorableMsgHelper"]
    }

    const routerFacet = await deployContractWithDeployer(
        deployer,
        "GatewayRouterFacet",
        routerFacetLibs,
        txArgs
    );

    console.log(`${FacetNames[2]} deployed: ${routerFacet.address}`)
    facetCuts.push({
        facetAddress: routerFacet.address,
        action: FacetCutAction.Add,
        functionSelectors: getSelectors(routerFacet)
    })

    console.log('GatewayRouterFacet facet: ', facetCuts[2].facetAddress)

    const gatewayConstructorParams = {
        networkName: {
            root: 314159,
            route: []
        },
        bottomUpCheckPeriod: 10,
        topDownCheckPeriod: 10,
        msgFee: ethers.utils.parseUnits("10", "gwei"),
        majorityPercentage: 66
    }

    const diamondLibs: Libraries = {
        "SubnetIDHelper": libs["SubnetIDHelper"]
    }

    // deploy Diamond
    const { address: diamondAddress } = await deployContractWithDeployer(
        deployer,
        "GatewayDiamond",
        diamondLibs,
        facetCuts, gatewayConstructorParams,
        txArgs
    );

    console.log('Gateway Actor Diamond address:', diamondAddress)

    // returning the address of the diamond
    return {
        "GatewayActorDiamond": diamondAddress
    }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    deployGatewayDiamond()
        .then(() => process.exit(0))
        .catch(error => {
            console.error(error)
            process.exit(1)
        })
}

exports.deployDiamond = deployGatewayDiamond