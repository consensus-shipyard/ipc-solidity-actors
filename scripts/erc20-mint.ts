/* global ethers */
/* eslint prefer-const: "off" */

import { artifacts, ethers } from "hardhat";
import { getTransactionFees } from './util';
import { Contract } from "ethers";

export async function deploy() {
    const [deployer] = await ethers.getSigners();
    const balance = await ethers.provider.getBalance(deployer.address);
    console.log("Deploying libraries with the account:", deployer.address, ' balance:', ethers.utils.formatEther(balance));

    const txArgs = await getTransactionFees();

    const tokenAddress = '0x41c21693e60fc1a5dbb7c50e54e7a6016aa44c99';
    const tokenArtifact = await artifacts.readArtifact('ERC20Token');
    const token = new Contract(tokenAddress, tokenArtifact.abi, deployer);

    await token.transfer(deployer.address, "1000");
}
deploy();
