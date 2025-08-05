#!/usr/bin/env python3
import argparse, requests, json
parser = argparse.ArgumentParser()
parser.add_argument("action", choices=["create", "stats"])
parser.add_argument("--tenant")
parser.add_argument("--file", help="JSON with employees")
args = parser.parse_args()

if args.action == "create":
    payload = json.load(open(args.file))
    r = requests.post("https://api.phishquest.com/campaign", json=payload, headers={"X-Api-Key": "..."})
    print(r.json())
else:
    r = requests.get(f"https://api.phishquest.com/dashboard/{args.tenant}")
    print(r.json())