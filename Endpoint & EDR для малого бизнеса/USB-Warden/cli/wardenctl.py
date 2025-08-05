#!/usr/bin/env python3
import argparse, subprocess, json, os, sys
from cryptography import x509
from cryptography.hazmat.primitives import hashes, serialization
from pathlib import Path

CERT_FILE = "/etc/usb-warden/ca.pem"
DB_FILE   = "/etc/usb-warden/whitelist.json"

def add(serial, cert_pem):
    cert = x509.load_pem_x509_certificate(cert_pem.encode())
    sig_ok = cert.verify_directly_by_issuer(cert)  # самоподпись
    if not sig_ok:
        print("Bad signature")
        sys.exit(1)
    db = json.loads(Path(DB_FILE).read_text()) if os.path.exists(DB_FILE) else []
    if serial not in db:
        db.append(serial)
        Path(DB_FILE).write_text(json.dumps(db, indent=2))
    subprocess.run(["systemctl", "restart", "usb-warden"], check=True)

def list_():
    print(Path(DB_FILE).read_text())

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["add", "list"])
    parser.add_argument("--serial")
    parser.add_argument("--cert", help="X.509 PEM file")
    args = parser.parse_args()
    if args.action == "add":
        add(args.serial, Path(args.cert).read_text())
    else:
        list_()