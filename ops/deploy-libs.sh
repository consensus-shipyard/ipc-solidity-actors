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

echo "[*] Deploying libraries"
(npx hardhat deploy-libraries --network ${NETWORK} |  sed -n '/{/,/}/p') > scripts/${LIB_OUTPUT}
echo "const LIBMAP =" | cat - scripts/${LIB_OUTPUT}  > temp && mv temp scripts/${LIB_OUTPUT}
echo "[*] Output libraries availableo in $PWD/scripts/${LIB_OUTPUT}"