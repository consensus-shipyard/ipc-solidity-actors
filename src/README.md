# IPC Diamond

The IPC Solidity Actors are implemented in the Diamond pattern, but the current implementation 
is not compatible with [EIP-2535](https://eips.ethereum.org/EIPS/eip-2535) standard. 

The current implementation can be classified as a `Single Cut Diamond`. 
A single cut diamond adds all functions to itself in its constructor function,
but it does not allow adding, replacing, or removing functions later.
This means that all facets of the diamond will be added to it in the constructor of the diamond 
and upgrades will not be possible.

## Code Layout

1. The SubnetActor facets are stored in the `subnet` directory. The Gateway facets are stored in the `gateway` directory.
2. `GatewayDiamond.sol` and `SubnetActorDiamond.sol` are diamond contracts.
3. Libraries are stored in the `lib` directory. They contain functionality that can't fit in a facet or should be shared by multiple facets.
4. `lib/LibSubnetActor.sol` and `lib/LibGatewayActorStorage` implement `AppStorage` pattern.
5. A custom `lib/ReentrancyGuard.sol` is used because original OpenZeppelin's `ReentrancyGuard` contract doesn't support diamond pattern.

## Implementation Base
The IPC diamond code is based on the [diamond-1-hardhat](https://github.com/mudgen/diamond-1-hardhat/tree/main/contracts) reference implementation.

## References

 - [Introduction to EIP-2535 Diamonds](https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard)
 - [ERC-2535: Diamonds, Multi-Facet Proxy](https://eips.ethereum.org/EIPS/eip-2535#facets-state-variables-and-diamond-storage)
 - [Understanding Diamonds on Ethereum](https://dev.to/mudgen/understanding-diamonds-on-ethereum-1fb)