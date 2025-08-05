import os, json, shutil
from pathlib import Path

CANARY_DIR = Path(".canary")

def embed(repo_root: str, canary: "Canary"):
    root = Path(repo_root)
    CANARY_DIR.mkdir(exist_ok=True)
    path = CANARY_DIR / f"{canary.type}.json"
    path.write_text(canary.json(indent=2))
    print(f"🪙 Токен {canary.type} сохранён в {path}")