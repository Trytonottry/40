import argparse, os
from cve_loader import load_cves
from ast_analyzer import analyze_repo
from filter import filter_cves
from sarif import to_sarif

parser = argparse.ArgumentParser()
parser.add_argument("--severity", default="moderate")
parser.add_argument("--token", required=True)
args = parser.parse_args()

base_ref = os.getenv("GITHUB_BASE_REF", "HEAD~1")
head_ref = os.getenv("GITHUB_SHA")

cves = load_cves(base_ref, head_ref, args.token)
calls = analyze_repo(".", cves)
filtered = filter_cves(cves, calls, min_severity=args.severity)
sarif_path = to_sarif(filtered, "dependasentinel.sarif")
print(f"::set-output name=sarif::{sarif_path}")