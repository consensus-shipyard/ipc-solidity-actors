#!/bin/bash
# Compile contract and output core contracts ABI
set -e

if [ $# -ne 1 ]
then
    echo "Expected a single argument with the output directory for the compiled contracts"
    exit 1
fi

OUTPUT=$1

echo -e "\033[0;36mTo aid build reproducibility, ensure you have recursively checked out all submodules: git submodule update --init --recursive\033[0m"
echo "[*] Compiling contracts and output core contracts ABI in $OUTPUT" 
forge build -C ./src/ -R $(jq '.remappings | join(",")' remappings.json) --lib-paths lib/ --via-ir --sizes --skip test --out=$OUTPUT
