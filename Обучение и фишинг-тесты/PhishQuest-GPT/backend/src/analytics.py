from sqlalchemy import func
from db import get_db

def heat_map(tenant_id: str, db: Session = Depends(get_db)):
    rows = db.query(
        Phish.department,
        func.count(Phish.clicked).label("clicks")
    ).filter(Phish.tenant_id == tenant_id).group_by(Phish.department).all()
    return [{"dept": r.department, "clicks": r.clicks} for r in rows]