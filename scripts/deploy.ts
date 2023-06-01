/* global ethers */
/* eslint prefer-const: "off" */

import hre from "hardhat";
import { ethers, deployments } from "hardhat";

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

    const accountHelper = await deployments.deploy("AccountHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});

    // const AccountHelper = await ethers.getContractFactory("AccountHelper");
    // const accountHelper = await AccountHelper.deploy()
    // await accountHelper.deployed();
    console.log("AccountHelper deployed to:", accountHelper.address);

    // const CheckpointHelper = await ethers.getContractFactory("CheckpointHelper");
    // const checkpointHelper = await CheckpointHelper.deploy()
    // await checkpointHelper.deployed();
    const checkpointHelper = await deployments.deploy("CheckpointHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("CheckpointHelper deployed to:", checkpointHelper.address);

    // const CrossMsgHelper = await ethers.getContractFactory("CrossMsgHelper");
    // const crossMsgHelper = await CrossMsgHelper.deploy();
    // await crossMsgHelper.deployed();
    const crossMsgHelper = await deployments.deploy("CrossMsgHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("CrossMsgHelper deployed to:", crossMsgHelper.address);

    // const EpochVoteSubmissionHelper = await ethers.getContractFactory("EpochVoteSubmissionHelper");
    // const epochVoteSubmissionHelper = await EpochVoteSubmissionHelper.deploy();
    // await epochVoteSubmissionHelper.deployed();
    const epochVoteSubmissionHelper = await deployments.deploy("EpochVoteSubmissionHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("EpochVoteSubmissionHelper deployed to:", epochVoteSubmissionHelper.address);

    // const ExecutableQueueHelper = await ethers.getContractFactory("ExecutableQueueHelper");
    // const executableQueueHelper = await ExecutableQueueHelper.deploy();
    // await executableQueueHelper.deployed();
    const executableQueueHelper = await deployments.deploy("ExecutableQueueHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("ExecutableQueueHelper deployed to:", executableQueueHelper.address);

    // const StorableMsgHelper = await ethers.getContractFactory("StorableMsgHelper");
    // const storableMsgHelper = await StorableMsgHelper.deploy();
    // await storableMsgHelper.deployed();
    const storableMsgHelper = await deployments.deploy("StorableMsgHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("StorableMsgHelper deployed to:", storableMsgHelper.address);

    // const SubnetIDHelper = await ethers.getContractFactory("SubnetIDHelper");
    // const subnetIDHelper = await SubnetIDHelper.deploy();
    // await subnetIDHelper.deployed();
    const subnetIDHelper = await deployments.deploy("SubnetIDHelper", {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT});
    console.log("SubnetIDHelper deployed to:", subnetIDHelper.address);

    // const Gateway = await ethers.getContractFactory("Gateway", {libraries: {
    //     AccountHelper: accountHelper.address,
    //     CheckpointHelper: checkpointHelper.address,
    //     CrossMsgHelper: crossMsgHelper.address,
    //     EpochVoteSubmissionHelper: epochVoteSubmissionHelper.address,
    //     ExecutableQueueHelper: executableQueueHelper.address,
    //     StorableMsgHelper: storableMsgHelper.address,
    //     SubnetIDHelper: subnetIDHelper.address
    // }});
    // const gateway = await Gateway.deploy(gatewayConstructorParams)
    // await gateway.deployed();
    // console.log("Gateway address:", gateway.address);

    // const subnet = await deployments.deploy("Subnet",  {from: deployer.address, deterministicDeployment: process.env.CREATE2_SALT, args: });    //TODO:  constructor params in []

    const gateway = await deployments.deploy("Gateway", { from: deployer.address, args: [gatewayConstructorParams], deterministicDeployment: process.env.CREATE2_SALT, log: true, libraries: {
        AccountHelper: accountHelper.address,
        CheckpointHelper: checkpointHelper.address,
        CrossMsgHelper: crossMsgHelper.address,
        EpochVoteSubmissionHelper: epochVoteSubmissionHelper.address,
        ExecutableQueueHelper: executableQueueHelper.address,
        StorableMsgHelper: storableMsgHelper.address,
        SubnetIDHelper: subnetIDHelper.address
    } });
    console.log("Gateway address:", gateway.address);
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
