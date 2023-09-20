# ==============================================================================
# Deployment

NETWORK ?= auto
OUTPUT ?= ./out

deploy-ipc:
	./ops/deploy.sh $(NETWORK)

compile-abi:
	./ops/compile-abi.sh $(OUTPUT)

rust-binding:
	cargo build --release --manifest-path ./binding/Cargo.toml -p fendermint_vm_ipc_actors

# ==============================================================================
# Running security checks within the local computer

slither:
	slither . --config-file ./slither.config.json

check-gateway:
	docker run --rm -v $(shell pwd):/app -w /app mythril/myth:latest -v4 analyze --solc-json remappings.json ./src/Gateway.sol --solv 0.8.19

check-subnet:
	docker run --rm -v $(shell pwd):/app -w /app mythril/myth:latest -v4 analyze --solc-json remappings.json ./src/SubnetActor.sol --solv 0.8.19

# ==============================================================================
# Development support

lint:
	solhint 'src/**/*.sol'

format:
	npx prettier --check -w 'src/**/*.sol' 'test/*.sol'

build:
	forge build

test:
	forge test -vvv --ffi

install-dev: install-npm-package install-eth-abi

install-npm-package:
	npm install --save-dev

install-eth-abi:
	curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py && python3 -m pip install eth_abi

storage:
	npx hardhat storage-layout --update

clean:
	rm -rf ./artifacts
	rm -rf ./cache
	rm -rf ./cache_hardhat
	rm -rf ./typechain

prepare: format lint test slither

# ==============================================================================
.PHONY: deploy-ipc lint format check-subnet slither check-gateway test prepare storage build clean
