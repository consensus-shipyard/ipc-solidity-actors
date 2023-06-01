/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
  BaseContract,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  CallOverrides,
} from "ethers";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import type { TypedEventFilter, TypedEvent, TypedListener } from "./common";

interface IGatewayInterface extends ethers.utils.Interface {
  functions: {
    "addStake()": FunctionFragment;
    "commitChildCheck(((address[]),uint64,uint256,tuple[],tuple[],bytes32))": FunctionFragment;
    "fund((address[]))": FunctionFragment;
    "kill()": FunctionFragment;
    "propagate(bytes32)": FunctionFragment;
    "register()": FunctionFragment;
    "release()": FunctionFragment;
    "releaseStake(uint256)": FunctionFragment;
    "sendCross((address[]),((((address[]),address),((address[]),address),uint256,uint64,bytes4,bytes),bool))": FunctionFragment;
    "setMembership(address[],uint256[])": FunctionFragment;
    "submitTopDownCheckpoint((uint64,tuple[]))": FunctionFragment;
    "whitelistPropagator(bytes32,address[])": FunctionFragment;
  };

  encodeFunctionData(functionFragment: "addStake", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "commitChildCheck",
    values: [
      {
        source: { route: string[] };
        epoch: BigNumberish;
        fee: BigNumberish;
        crossMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
        children: { source: { route: string[] }; checks: BytesLike[] }[];
        prevHash: BytesLike;
      }
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "fund",
    values: [{ route: string[] }]
  ): string;
  encodeFunctionData(functionFragment: "kill", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "propagate",
    values: [BytesLike]
  ): string;
  encodeFunctionData(functionFragment: "register", values?: undefined): string;
  encodeFunctionData(functionFragment: "release", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "releaseStake",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "sendCross",
    values: [
      { route: string[] },
      {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      }
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "setMembership",
    values: [string[], BigNumberish[]]
  ): string;
  encodeFunctionData(
    functionFragment: "submitTopDownCheckpoint",
    values: [
      {
        epoch: BigNumberish;
        topDownMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
      }
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "whitelistPropagator",
    values: [BytesLike, string[]]
  ): string;

  decodeFunctionResult(functionFragment: "addStake", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "commitChildCheck",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "fund", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "kill", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "propagate", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "register", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "release", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "releaseStake",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "sendCross", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "setMembership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "submitTopDownCheckpoint",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "whitelistPropagator",
    data: BytesLike
  ): Result;

  events: {};
}

export class IGateway extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  listeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter?: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): Array<TypedListener<EventArgsArray, EventArgsObject>>;
  off<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  on<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  once<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeListener<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>,
    listener: TypedListener<EventArgsArray, EventArgsObject>
  ): this;
  removeAllListeners<EventArgsArray extends Array<any>, EventArgsObject>(
    eventFilter: TypedEventFilter<EventArgsArray, EventArgsObject>
  ): this;

  listeners(eventName?: string): Array<Listener>;
  off(eventName: string, listener: Listener): this;
  on(eventName: string, listener: Listener): this;
  once(eventName: string, listener: Listener): this;
  removeListener(eventName: string, listener: Listener): this;
  removeAllListeners(eventName?: string): this;

  queryFilter<EventArgsArray extends Array<any>, EventArgsObject>(
    event: TypedEventFilter<EventArgsArray, EventArgsObject>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEvent<EventArgsArray & EventArgsObject>>>;

  interface: IGatewayInterface;

  functions: {
    addStake(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    commitChildCheck(
      bottomupCheckpoint: {
        source: { route: string[] };
        epoch: BigNumberish;
        fee: BigNumberish;
        crossMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
        children: { source: { route: string[] }; checks: BytesLike[] }[];
        prevHash: BytesLike;
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    fund(
      subnetId: { route: string[] },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    kill(
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    propagate(
      msgCid: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    register(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    release(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    releaseStake(
      amount: BigNumberish,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    sendCross(
      destination: { route: string[] },
      crossMsg: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    setMembership(
      validatorsToSet: string[],
      weights: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    submitTopDownCheckpoint(
      topdownCheckpoint: {
        epoch: BigNumberish;
        topDownMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    whitelistPropagator(
      msgCid: BytesLike,
      owners: string[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;
  };

  addStake(
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  commitChildCheck(
    bottomupCheckpoint: {
      source: { route: string[] };
      epoch: BigNumberish;
      fee: BigNumberish;
      crossMsgs: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      }[];
      children: { source: { route: string[] }; checks: BytesLike[] }[];
      prevHash: BytesLike;
    },
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  fund(
    subnetId: { route: string[] },
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  kill(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  propagate(
    msgCid: BytesLike,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  register(
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  release(
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  releaseStake(
    amount: BigNumberish,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  sendCross(
    destination: { route: string[] },
    crossMsg: {
      message: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      };
      wrapped: boolean;
    },
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  setMembership(
    validatorsToSet: string[],
    weights: BigNumberish[],
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  submitTopDownCheckpoint(
    topdownCheckpoint: {
      epoch: BigNumberish;
      topDownMsgs: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      }[];
    },
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  whitelistPropagator(
    msgCid: BytesLike,
    owners: string[],
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    addStake(overrides?: CallOverrides): Promise<void>;

    commitChildCheck(
      bottomupCheckpoint: {
        source: { route: string[] };
        epoch: BigNumberish;
        fee: BigNumberish;
        crossMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
        children: { source: { route: string[] }; checks: BytesLike[] }[];
        prevHash: BytesLike;
      },
      overrides?: CallOverrides
    ): Promise<void>;

    fund(
      subnetId: { route: string[] },
      overrides?: CallOverrides
    ): Promise<void>;

    kill(overrides?: CallOverrides): Promise<void>;

    propagate(msgCid: BytesLike, overrides?: CallOverrides): Promise<void>;

    register(overrides?: CallOverrides): Promise<void>;

    release(overrides?: CallOverrides): Promise<void>;

    releaseStake(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    sendCross(
      destination: { route: string[] },
      crossMsg: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      },
      overrides?: CallOverrides
    ): Promise<void>;

    setMembership(
      validatorsToSet: string[],
      weights: BigNumberish[],
      overrides?: CallOverrides
    ): Promise<void>;

    submitTopDownCheckpoint(
      topdownCheckpoint: {
        epoch: BigNumberish;
        topDownMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
      },
      overrides?: CallOverrides
    ): Promise<void>;

    whitelistPropagator(
      msgCid: BytesLike,
      owners: string[],
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {};

  estimateGas: {
    addStake(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    commitChildCheck(
      bottomupCheckpoint: {
        source: { route: string[] };
        epoch: BigNumberish;
        fee: BigNumberish;
        crossMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
        children: { source: { route: string[] }; checks: BytesLike[] }[];
        prevHash: BytesLike;
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    fund(
      subnetId: { route: string[] },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    kill(
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    propagate(
      msgCid: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    register(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    release(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    releaseStake(
      amount: BigNumberish,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    sendCross(
      destination: { route: string[] },
      crossMsg: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    setMembership(
      validatorsToSet: string[],
      weights: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    submitTopDownCheckpoint(
      topdownCheckpoint: {
        epoch: BigNumberish;
        topDownMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    whitelistPropagator(
      msgCid: BytesLike,
      owners: string[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    addStake(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    commitChildCheck(
      bottomupCheckpoint: {
        source: { route: string[] };
        epoch: BigNumberish;
        fee: BigNumberish;
        crossMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
        children: { source: { route: string[] }; checks: BytesLike[] }[];
        prevHash: BytesLike;
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    fund(
      subnetId: { route: string[] },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    kill(
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    propagate(
      msgCid: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    register(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    release(
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    releaseStake(
      amount: BigNumberish,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    sendCross(
      destination: { route: string[] },
      crossMsg: {
        message: {
          from: { subnetId: { route: string[] }; rawAddress: string };
          to: { subnetId: { route: string[] }; rawAddress: string };
          value: BigNumberish;
          nonce: BigNumberish;
          method: BytesLike;
          params: BytesLike;
        };
        wrapped: boolean;
      },
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    setMembership(
      validatorsToSet: string[],
      weights: BigNumberish[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    submitTopDownCheckpoint(
      topdownCheckpoint: {
        epoch: BigNumberish;
        topDownMsgs: {
          message: {
            from: { subnetId: { route: string[] }; rawAddress: string };
            to: { subnetId: { route: string[] }; rawAddress: string };
            value: BigNumberish;
            nonce: BigNumberish;
            method: BytesLike;
            params: BytesLike;
          };
          wrapped: boolean;
        }[];
      },
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    whitelistPropagator(
      msgCid: BytesLike,
      owners: string[],
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;
  };
}
