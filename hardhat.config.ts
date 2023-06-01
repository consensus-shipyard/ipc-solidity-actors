import { HardhatUserConfig, task } from "hardhat/config";
import '@typechain/hardhat';

import "@nomicfoundation/hardhat-foundry";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-ethers";
import "hardhat-deploy";
import 'hardhat-contract-sizer';

import dotenv from 'dotenv';

dotenv.config();

const lazyImport = async (module: any) => {
  return await import(module);
};

task('deploy', 'Builds and deploys the contract on the selected network', async () => {
  const { deploy } = await lazyImport('./scripts/deploy');
  const deploymentData = await deploy();

  // console.log('Gateway deployed to:', deploymentData.gateway.address);
  // console.log('Subnet deployed to:', deploymentData.subnet.address);
});

/** @type import('hardhat/config').HardhatUserConfig */
const config: HardhatUserConfig = {
  defaultNetwork: "calibrationnet",
  networks: {
    calibrationnet: {
      chainId: 314159,
      url: "https://filecoin-calibration.chainup.net/rpc/v1",
      accounts: [process.env.PRIVATE_KEY!],
      // gasPrice: 3,
      // blockGasLimit: 10000000000,
      // initialBaseFeePerGas: 1,
      // throwOnTransactionFailures: true,
      // throwOnCallFailures: true,
      // maxFeePerGas: 0,
      // maxPriorityFeePerGas: 0
    }
  },
  solidity: {
    compilers: [
      {
        version: '0.8.17',
        settings: {
          viaIR: true,
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  etherscan: {
    apiKey: {
      calibrationnet: process.env.ETHERSCAN_API_KEY!
    }
  },
  typechain: {
    outDir: 'typechain',
    target: 'ethers-v5',
  },
};


export default config;

