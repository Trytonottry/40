import json, os

def to_sarif(findings, filename):
    sarif = {
        "version": "2.1.0",
        "$schema": "https://json.schemastore.org/sarif-2.1.0.json",
        "runs": [{
            "tool": {"driver": {"name": "DependaSentinel"}},
            "results": [
                {
                    "ruleId": f"{f['advisory_ghsa_id']}",
                    "level": "error" if f["reachable"] else "note",
                    "message": {"text": f"{f['advisory_summary']} (reachable={f.get('reachable', False)})"},
                    "locations": [{"physicalLocation": {"artifactLocation": {"uri": "requirements.txt"}}}]
                }
                for f in findings
            ]
        }]
    }
    with open(filename, "w") as f:
        json.dump(sarif, f)
    return filename