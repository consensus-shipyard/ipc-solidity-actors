#!/bin/bash
# Deploys IPC on an EVM-compatible subnet using hardhat
set -e

source ./ops/deploy-libs.sh "$@"

source ./ops/deploy-gw.sh "$@"

source ./ops/deploy-reg.sh "$@"