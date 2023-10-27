import hre, { ethers } from "hardhat";
import {getFacets,deployContractWithDeployer, getTransactionFees} from './util';

const { getSelectors, FacetCutAction } = require('./js/diamond.js')

async function upgradeSubnetActorDiamond (gatewayDiamondAddress: string, libs: { [key in string]: string }) {
   const x = await getFacets("0x11fae1c6ab8d1ec073d60b370232f44284687dc7")
   console.log(x)
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

