/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { ethers } from "ethers";
import {
  FactoryOptions,
  HardhatEthersHelpers as HardhatEthersHelpersBase,
} from "@nomiclabs/hardhat-ethers/types";

import * as Contracts from ".";

declare module "hardhat/types/runtime" {
  interface HardhatEthersHelpers extends HardhatEthersHelpersBase {
    getContractFactory(
      name: "FilAddress",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.FilAddress__factory>;
    getContractFactory(
      name: "Gateway",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Gateway__factory>;
    getContractFactory(
      name: "IGateway",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IGateway__factory>;
    getContractFactory(
      name: "ISubnetActor",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ISubnetActor__factory>;
    getContractFactory(
      name: "AccountHelper",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.AccountHelper__factory>;
    getContractFactory(
      name: "CheckpointHelper",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.CheckpointHelper__factory>;
    getContractFactory(
      name: "CrossMsgHelper",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.CrossMsgHelper__factory>;
    getContractFactory(
      name: "StorableMsgHelper",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.StorableMsgHelper__factory>;
    getContractFactory(
      name: "SubnetIDHelper",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.SubnetIDHelper__factory>;
    getContractFactory(
      name: "SubnetActor",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.SubnetActor__factory>;
    getContractFactory(
      name: "Voting",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Voting__factory>;

    getContractAt(
      name: "FilAddress",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.FilAddress>;
    getContractAt(
      name: "Gateway",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Gateway>;
    getContractAt(
      name: "IGateway",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IGateway>;
    getContractAt(
      name: "ISubnetActor",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ISubnetActor>;
    getContractAt(
      name: "AccountHelper",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.AccountHelper>;
    getContractAt(
      name: "CheckpointHelper",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.CheckpointHelper>;
    getContractAt(
      name: "CrossMsgHelper",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.CrossMsgHelper>;
    getContractAt(
      name: "StorableMsgHelper",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.StorableMsgHelper>;
    getContractAt(
      name: "SubnetIDHelper",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.SubnetIDHelper>;
    getContractAt(
      name: "SubnetActor",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.SubnetActor>;
    getContractAt(
      name: "Voting",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Voting>;

    // default types
    getContractFactory(
      name: string,
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<ethers.ContractFactory>;
    getContractFactory(
      abi: any[],
      bytecode: ethers.utils.BytesLike,
      signer?: ethers.Signer
    ): Promise<ethers.ContractFactory>;
    getContractAt(
      nameOrAbi: string | any[],
      address: string,
      signer?: ethers.Signer
    ): Promise<ethers.Contract>;
  }
}
