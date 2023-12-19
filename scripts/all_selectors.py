import subprocess
import argparse
import json
import os
import glob
from eth_abi import encode
from json.decoder import JSONDecodeError

def get_selectors(contract):
    """This function gets the selectors of the functions of the target contract."""
    print(contract)

    res = subprocess.run(
        ["forge", "inspect", contract, "methodIdentifiers"], capture_output=True)
    res = res.stdout.decode()
    try:
        res = json.loads(res)
    except JSONDecodeError as e:
        print("failed to load JSON:", e)
        print("forge output:", res)
        return None

    selectors = []
    for signature in res:
        selector = res[signature]
        selectors.append(bytes.fromhex(selector))

    enc = encode(["bytes4[]"], [selectors])
    return "0x" + enc.hex()

def main():
    contract_selectors = {}
    for filepath in glob.glob('src/**/*.sol', recursive=True):
        # Extract just the contract name (without path and .sol extension)
        contract_name = os.path.splitext(os.path.basename(filepath))[0]
        # Format full path
        # Call get_selectors for each contract
        try:
            selectors = get_selectors(filepath + ':' + contract_name)
            if selectors:
                contract_selectors[contract_name] = selectors
        except Exception as oops:
            print(oops)

    # Print the final JSON
    print(json.dumps(contract_selectors, indent=4))


if __name__ == "__main__":
    main()

