#!/usr/bin/env python3
import requests, argparse, os, json
parser = argparse.ArgumentParser(description='NanoEDR CLI')
parser.add_argument('--register', action='store_true', help='register new endpoint')
parser.add_argument('--tenant', required=True)
parser.add_argument('--api-key', required=True)
args = parser.parse_args()

if args.register:
    payload = {"tenant": args.tenant, "api_key": args.api_key}
    r = requests.post("https://cloud.nanoedr.com/v1/register", json=payload)
    print(r.json())