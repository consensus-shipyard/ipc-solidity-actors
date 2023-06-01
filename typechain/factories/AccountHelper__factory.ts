/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { AccountHelper, AccountHelperInterface } from "../AccountHelper";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_address",
        type: "address",
      },
    ],
    name: "isAccount",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_address",
        type: "address",
      },
    ],
    name: "isSystemActor",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
];

const _bytecode =
  "0x6080806040523461001a576101949081610020823930815050f35b600080fdfe608080604052600436101561001357600080fd5b600090813560e01c90816325ca4c9c146100715750635d3f8a691461003757600080fd5b602036600319011261006e576004356001600160a01b0381169081900361006a5760405160ff60981b9091148152602090f35b5080fd5b80fd5b9050602036600319011261006a576004356001600160a01b038116810361015a57803b15918261012f575b826100af575b6020836040519015158152f35b908092503b67ffffffffffffffff80821161011b57601f8201601f19908116603f011683019081118382101761011b579360209460405281835284830180943c5190207fc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a4701438806100a2565b634e487b7160e01b85526041600452602485fd5b7fc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470823f14925061009c565b8280fdfea2646970667358221220576755b7ee5b8d0b50598d8000e4413cbbde4755b158436841cf6e525906618364736f6c63430008110033";

export class AccountHelper__factory extends ContractFactory {
  constructor(
    ...args: [signer: Signer] | ConstructorParameters<typeof ContractFactory>
  ) {
    if (args.length === 1) {
      super(_abi, _bytecode, args[0]);
    } else {
      super(...args);
    }
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<AccountHelper> {
    return super.deploy(overrides || {}) as Promise<AccountHelper>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): AccountHelper {
    return super.attach(address) as AccountHelper;
  }
  connect(signer: Signer): AccountHelper__factory {
    return super.connect(signer) as AccountHelper__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): AccountHelperInterface {
    return new utils.Interface(_abi) as AccountHelperInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): AccountHelper {
    return new Contract(address, _abi, signerOrProvider) as AccountHelper;
  }
}
