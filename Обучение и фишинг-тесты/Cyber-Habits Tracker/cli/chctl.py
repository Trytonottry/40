#!/usr/bin/env python3
import argparse, json
import requests

parser = argparse.ArgumentParser()
parser.add_argument("action", choices=["stats", "export"])
parser.add_argument("--user")
args = parser.parse_args()

if args.action == "stats":
    r = requests.get("http://localhost:8000/api/stats", params={"user": args.user})
    print(r.json())
elif args.action == "export":
    r = requests.get("http://localhost:8000/api/export")
    open("report.pdf", "wb").write(r.content)