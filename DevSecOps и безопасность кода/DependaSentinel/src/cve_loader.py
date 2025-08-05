import requests, os

def load_cves(base_ref: str, head_ref: str, token: str):
    url = "https://api.github.com/repos/{repo}/dependency-graph/compare/{base}...{head}"
    repo = os.getenv("GITHUB_REPOSITORY")
    headers = {"Authorization": f"token {token}"}
    r = requests.get(url.format(repo=repo, base=base_ref, head=head_ref), headers=headers)
    data = r.json()
    return [v for v in data.get("vulnerabilities", [])]