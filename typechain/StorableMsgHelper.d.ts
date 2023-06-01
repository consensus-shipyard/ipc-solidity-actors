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
  CallOverrides,
} from "ethers";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import type { TypedEventFilter, TypedEvent, TypedListener } from "./common";

interface StorableMsgHelperInterface extends ethers.utils.Interface {
  functions: {
    "EMPTY_STORABLE_MESSAGE_HASH()": FunctionFragment;
    "applyType((((address[]),address),((address[]),address),uint256,uint64,bytes4,bytes),(address[]))": FunctionFragment;
    "toHash((((address[]),address),((address[]),address),uint256,uint64,bytes4,bytes))": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "EMPTY_STORABLE_MESSAGE_HASH",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "applyType",
    values: [
      {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      { route: string[] }
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "toHash",
    values: [
      {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      }
    ]
  ): string;

  decodeFunctionResult(
    functionFragment: "EMPTY_STORABLE_MESSAGE_HASH",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "applyType", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "toHash", data: BytesLike): Result;

  events: {};
}

export class StorableMsgHelper extends BaseContract {
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

  interface: StorableMsgHelperInterface;

  functions: {
    EMPTY_STORABLE_MESSAGE_HASH(overrides?: CallOverrides): Promise<[string]>;

    applyType(
      message: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      currentSubnet: { route: string[] },
      overrides?: CallOverrides
    ): Promise<[number]>;

    toHash(
      storableMsg: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      overrides?: CallOverrides
    ): Promise<[string]>;
  };

  EMPTY_STORABLE_MESSAGE_HASH(overrides?: CallOverrides): Promise<string>;

  applyType(
    message: {
      from: { subnetId: { route: string[] }; rawAddress: string };
      to: { subnetId: { route: string[] }; rawAddress: string };
      value: BigNumberish;
      nonce: BigNumberish;
      method: BytesLike;
      params: BytesLike;
    },
    currentSubnet: { route: string[] },
    overrides?: CallOverrides
  ): Promise<number>;

  toHash(
    storableMsg: {
      from: { subnetId: { route: string[] }; rawAddress: string };
      to: { subnetId: { route: string[] }; rawAddress: string };
      value: BigNumberish;
      nonce: BigNumberish;
      method: BytesLike;
      params: BytesLike;
    },
    overrides?: CallOverrides
  ): Promise<string>;

  callStatic: {
    EMPTY_STORABLE_MESSAGE_HASH(overrides?: CallOverrides): Promise<string>;

    applyType(
      message: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      currentSubnet: { route: string[] },
      overrides?: CallOverrides
    ): Promise<number>;

    toHash(
      storableMsg: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      overrides?: CallOverrides
    ): Promise<string>;
  };

  filters: {};

  estimateGas: {
    EMPTY_STORABLE_MESSAGE_HASH(overrides?: CallOverrides): Promise<BigNumber>;

    applyType(
      message: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      currentSubnet: { route: string[] },
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    toHash(
      storableMsg: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    EMPTY_STORABLE_MESSAGE_HASH(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    applyType(
      message: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      currentSubnet: { route: string[] },
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    toHash(
      storableMsg: {
        from: { subnetId: { route: string[] }; rawAddress: string };
        to: { subnetId: { route: string[] }; rawAddress: string };
        value: BigNumberish;
        nonce: BigNumberish;
        method: BytesLike;
        params: BytesLike;
      },
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}
