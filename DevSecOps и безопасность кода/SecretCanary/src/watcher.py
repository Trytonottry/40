import time, requests
from notifier import alert

GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")

def watch(repo: str, interval: int):
    owner, name = repo.split("/")
    url = f"https://api.github.com/repos/{owner}/{name}/events/public"
    seen = set()
    while True:
        r = requests.get(url, headers={"Authorization": f"token {GITHUB_TOKEN}"})
        for ev in r.json():
            if ev["type"] != "PushEvent":
                continue
            for commit in ev["payload"]["commits"]:
                if any(t in commit["message"] for t in load_tokens()):
                    alert(ev)
        time.sleep(interval)