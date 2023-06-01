/* global ethers */
/* eslint prefer-const: "off" */

import hre, { ethers } from "hardhat";
import { deployContractWithDeployer, getTransactionFees } from './util';

export async function deploy(libs: { [key in string]: string }) {
    if (Object.keys(libs).length === 0) throw new Error(`Libraris are missing`);

    await hre.run('compile');

    const [deployer] = await ethers.getSigners();
    const balance = await ethers.provider.getBalance(deployer.address);
    console.log("Deploying gateway with the account:", deployer.address, ' balance:', ethers.utils.formatEther(balance));

    const txArgs = await getTransactionFees();

    const gatewayConstructorParams = {
        networkName: {
            route: [ethers.constants.AddressZero]
        },
        bottomUpCheckPeriod: 10,
        topDownCheckPeriod: 10,
        msgFee: ethers.utils.parseUnits("10", "gwei"),
        majorityPercentage: 66
    }

    const { address: gatewayAddress } = await deployContractWithDeployer(deployer, "Gateway", libs, gatewayConstructorParams, txArgs);

    return {
        "Gateway": gatewayAddress
    }

}

// deploy();
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    deploy({})
        .then(() => process.exit(0))
        .catch((error: Error) => {
            console.error(error)
            process.exit(1)
        })
}
