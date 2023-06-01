/* global ethers */
/* eslint prefer-const: "off" */

import hre, { ethers, deployments } from "hardhat";
import { deployContractWithDeployer } from './util';

export async function deploy() {
    await hre.run('compile');

    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const gatewayConstructorParams = {
        networkName: {
            route: [ethers.constants.AddressZero]
        },
        bottomUpCheckPeriod: 10,
        topDownCheckPeriod: 10,
        msgFee: ethers.utils.parseUnits("10", "gwei"),
        majorityPercentage: 66
    }

    const feeData = await ethers.provider.getFeeData();
    const txArgs = {
        maxFeePerGas: feeData.maxFeePerGas,
        maxPriorityFeePerGas: feeData.maxPriorityFeePerGas,
        type: 2
    };

    const libs = {
        "AccountHelper": "0x914Ea90c6e478EB4033299B9819c72d6161F840D",
        "CheckpointHelper": "0x1cFB0B7B451b67fC51E229cCF7299361e6B644F1",
        "SubnetIDHelper": "0x4042BAD419a0986beBB86AE948F94c4FbA4156ce",
        "CrossMsgHelper": "0xE26182d0DA2352C6Bc10831827ee2E4878A8580b",
        "EpochVoteSubmissionHelper": "0xb48a3eE6627965C1003fb328016EAFF6A3Cf17ef",
        "ExecutableQueueHelper": "0x61404de0907E4affa58A6F4ddc9fbb2B738afe65",
        "StorableMsgHelper": "0x18A4D584e844F5a24a6c1EF4c3486F3b0446F1c8",
    };

    // const accountHelper = await deployments.deploy("AccountHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!, });
    // const accountHelper = await deployContractWithDeployer(deployer, "AccountHelper", {}, txArgs);
    // console.log("AccountHelper deployed to:", accountHelper.address);

    // const checkpointHelper = await deployments.deploy("CheckpointHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const checkpointHelper = await deployContractWithDeployer(deployer, "CheckpointHelper", {}, txArgs);
    // console.log("CheckpointHelper deployed to:", checkpointHelper.address);

    // const subnetIDHelper = await deployments.deploy("SubnetIDHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const subnetIDHelper = await deployContractWithDeployer(deployer, "SubnetIDHelper", {}, txArgs);
    // console.log("SubnetIDHelper deployed to:", subnetIDHelper.address);

    // const crossMsgHelper = await deployments.deploy("CrossMsgHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const crossMsgHelper = await deployContractWithDeployer(deployer, "CrossMsgHelper", { "SubnetIDHelper": subnetIDHelper.address }, txArgs);
    // console.log("CrossMsgHelper deployed to:", crossMsgHelper.address);

    // const epochVoteSubmissionHelper = await deployments.deploy("EpochVoteSubmissionHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const epochVoteSubmissionHelper = await deployContractWithDeployer(deployer, "EpochVoteSubmissionHelper", {}, txArgs);
    // console.log("EpochVoteSubmissionHelper deployed to:", epochVoteSubmissionHelper.address);

    // const executableQueueHelper = await deployments.deploy("ExecutableQueueHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const executableQueueHelper = await deployContractWithDeployer(deployer, "ExecutableQueueHelper", {}, txArgs);
    // console.log("ExecutableQueueHelper deployed to:", executableQueueHelper.address);

    // const storableMsgHelper = await deployments.deploy("StorableMsgHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, maxFeePerGas: feeData.maxFeePerGas!, maxPriorityFeePerGas: feeData.maxPriorityFeePerGas!});
    // const storableMsgHelper = await deployContractWithDeployer(deployer, "StorableMsgHelper", { "SubnetIDHelper": subnetIDHelper.address }, txArgs);
    // console.log("StorableMsgHelper deployed to:", storableMsgHelper.address);

    const Gateway = await ethers.getContractFactory("Gateway", {
        libraries: {
            // AccountHelper: accountHelper.address,
            // CheckpointHelper: checkpointHelper.address,
            // CrossMsgHelper: crossMsgHelper.address,
            // EpochVoteSubmissionHelper: epochVoteSubmissionHelper.address,
            // ExecutableQueueHelper: executableQueueHelper.address,
            // StorableMsgHelper: storableMsgHelper.address,
            // SubnetIDHelper: subnetIDHelper.address
            ...libs
        }
    });
    const gateway = await Gateway.deploy(gatewayConstructorParams, txArgs)
    await gateway.deployed();
    console.log("Gateway address:", gateway.address);

    // // const subnet = await deployments.deploy("Subnet",  {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, args: });    //TODO:  constructor params in []

    // const gateway = await deployments.deploy("Gateway", { from: deployer.address, args: [gatewayConstructorParams], deterministicDeployment: process.env.CREATE2_SALT, log: true, libraries: {
    //     AccountHelper: accountHelper.address,
    //     CheckpointHelper: checkpointHelper.address,
    //     CrossMsgHelper: crossMsgHelper.address,
    //     EpochVoteSubmissionHelper: epochVoteSubmissionHelper.address,
    //     ExecutableQueueHelper: executableQueueHelper.address,
    //     StorableMsgHelper: storableMsgHelper.address,
    //     SubnetIDHelper: subnetIDHelper.address
    // } });
    // console.log("Gateway address:", gateway.address);
    return {
        gateway,
        // subnet
    }

}

// deploy();
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    deploy()
        .then(() => process.exit(0))
        .catch((error: Error) => {
            console.error(error)
            process.exit(1)
        })
}
