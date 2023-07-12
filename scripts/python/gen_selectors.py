import subprocess
import argparse
import json
import jinja2

from eth_abi import encode
from jinja2 import Environment, FileSystemLoader


def gen_selectors(args):
    environment = Environment(loader=FileSystemLoader(searchpath="./scripts/python"))
    template = environment.get_template("selectors.tmpl")

    results_filename = args.out

    data = []

    for contract in args.contracts.split(","):

        res = subprocess.run(
            ["forge", "inspect", contract, "mi"], capture_output=True)
        res = res.stdout.decode()
        res = json.loads(res)

        selectors = []
        for signature in res:
            selector = res[signature]
            selectors.append(bytes.fromhex(selector))

        enc = encode(["bytes4[]"], [selectors])
        data.append({"name":contract, "selector":enc.hex()})

    with open(results_filename, mode="w", encoding="utf-8") as results:
        results.write(template.render(context=data))


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--contracts", type=str)
    parser.add_argument("--out", type=str)
    return parser.parse_args()


def main():
    args = parse_args()
    gen_selectors(args)


if __name__ == "__main__":
    main()