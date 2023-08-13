#!/bin/bash
# Deploys IPC on an EVM-compatible subnet using hardhat
set -e

if [ $# -ne 1 ]
then
    echo "Expected a single argument with the name of the network to deploy (localnet, calibrationnet, mainnet)"
    exit 1
fi

LIB_OUTPUT="libraries.out"
GATEWAY_OUTPUT="gateway.out"
NETWORK=$1

if [ "$NETWORK" = "auto" ]; then
  echo "[*] Automatically getting chainID for network"
  source ops/chain-id.sh
fi


echo "[*] Populating deploy-registry script"
cat scripts/${LIB_OUTPUT} | sed '/StorableMsgHelper/d' | cat - scripts/deploy-registry.template > temp && mv temp scripts/deploy-registry.ts
cat scripts/${GATEWAY_OUTPUT} |  cat - scripts/deploy-registry.ts > temp && mv temp scripts/deploy-registry.ts
echo "[*] Registry script in $PWD/scripts/deploy-registry.ts"
npx hardhat run scripts/deploy-registry.ts --network ${NETWORK}
echo "[*] IPC actors successfully deployed"