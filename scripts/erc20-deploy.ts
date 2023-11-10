/* global ethers */
/* eslint prefer-const: "off" */

import hre, { ethers } from "hardhat";
import { deployContractWithDeployer, getTransactionFees } from './util';

export async function deploy() {
    const [deployer] = await ethers.getSigners();
    const balance = await ethers.provider.getBalance(deployer.address);
    console.log("Deploying libraries with the account:", deployer.address, ' balance:', ethers.utils.formatEther(balance));

    const txArgs = await getTransactionFees();

    const { address } = await deployContractWithDeployer(deployer, "ERC20Token", {}, txArgs);
    console.log("token addr", address);
}

deploy();
