from sqlalchemy.orm import Session
from db import get_db
import uuid

def create_campaign(data: dict, db: Session = Depends(get_db)):
    cid = str(uuid.uuid4())
    for emp in data["employees"]:
        profile = fetch_profile(emp["email"])
        email_html = craft_email(profile, data["prompt"])
        db.add(Phish(campaign_id=cid, target=emp, email=email_html))
    db.commit()
    return {"campaign_id": cid}