#!/bin/bash
# Deploys IPC on an EVM-compatible subnet using hardhat
set -e

./ops/deploy-libs.sh "$@"

./ops/deploy-gw.sh "$@"

./ops/deploy-reg.sh "$@"