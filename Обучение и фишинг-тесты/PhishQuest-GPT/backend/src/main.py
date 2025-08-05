from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from campaign import create_campaign, list_campaigns
from analytics import heat_map
from gpt import craft_email
import stripe

app = FastAPI(title="PhishQuest-GPT")

@app.post("/campaign")
def new_campaign(payload: dict, api_key: str = Depends(verify_key)):
    campaign = create_campaign(payload)
    return campaign

@app.get("/dashboard/{tenant_id}")
def dashboard(tenant_id: str):
    return heat_map(tenant_id)