/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import { Provider } from "@ethersproject/providers";
import type { Voting, VotingInterface } from "../Voting";

const _abi = [
  {
    inputs: [],
    name: "EpochAlreadyExecuted",
    type: "error",
  },
  {
    inputs: [],
    name: "EpochNotVotable",
    type: "error",
  },
  {
    inputs: [],
    name: "InvalidMajorityPercentage",
    type: "error",
  },
  {
    inputs: [],
    name: "ValidatorAlreadyVoted",
    type: "error",
  },
  {
    inputs: [],
    name: "executableQueue",
    outputs: [
      {
        internalType: "uint64",
        name: "period",
        type: "uint64",
      },
      {
        internalType: "uint64",
        name: "first",
        type: "uint64",
      },
      {
        internalType: "uint64",
        name: "last",
        type: "uint64",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "genesisEpoch",
    outputs: [
      {
        internalType: "uint64",
        name: "",
        type: "uint64",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "lastVotingExecutedEpoch",
    outputs: [
      {
        internalType: "uint64",
        name: "",
        type: "uint64",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "majorityPercentage",
    outputs: [
      {
        internalType: "uint8",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "submissionPeriod",
    outputs: [
      {
        internalType: "uint64",
        name: "",
        type: "uint64",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

export class Voting__factory {
  static readonly abi = _abi;
  static createInterface(): VotingInterface {
    return new utils.Interface(_abi) as VotingInterface;
  }
  static connect(address: string, signerOrProvider: Signer | Provider): Voting {
    return new Contract(address, _abi, signerOrProvider) as Voting;
  }
}
