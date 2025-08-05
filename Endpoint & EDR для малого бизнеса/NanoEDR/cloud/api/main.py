from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from ml import is_white
import redis, uuid, os

r = redis.Redis(host=os.getenv("REDIS_HOST", "redis"))
app = FastAPI()

class EventIn(BaseModel):
    ts: int
    host: str
    pid: int
    ppid: int
    exe: str
    action: str
    extra: dict

@app.post("/v1/event")
def ingest(ev: EventIn):
    key = f"{ev.host}:{ev.exe}:{ev.pid}"
    if not is_white(ev.dict()):
        r.xadd("alerts", {"event": ev.json()})
    return {"ok": True}

@app.get("/v1/alerts")
def alerts():
    return [x[1][b'event'].decode() for x in r.xrange("alerts", "-", "+")]