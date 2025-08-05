import joblib, json, os
from sklearn.ensemble import IsolationForest

MODEL_PATH = "/app/model.pkl"

def train():
    # dummy white events
    white = [{"exe": "chrome.exe", "action": "process"} for _ in range(100)]
    clf = IsolationForest(contamination=0.05).fit(white)
    joblib.dump(clf, MODEL_PATH)

def is_white(ev: dict) -> bool:
    if not os.path.exists(MODEL_PATH):
        train()
    clf = joblib.load(MODEL_PATH)
    vec = [hash(ev.get("exe", "")) % 1000]
    return clf.predict([vec])[0] == 1