NETWORK ?= localnet

check:
	slither . --config-file ./slither.config.json

lint:
	solhint 'src/**/*.sol'

deploy-ipc:
	./ops/deploy.sh $(NETWORK)

.PHONY: deploy-ipc check