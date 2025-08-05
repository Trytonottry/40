import uuid, boto3, os, json
from pydantic import BaseModel

class Canary(BaseModel):
    type: str
    token: str
    metadata: dict

def create_token(typ: str) -> Canary:
    if typ == "aws":
        iam = boto3.client("iam")
        user = f"canary-{uuid.uuid4().hex[:8]}"
        iam.create_user(UserName=user)
        key = iam.create_access_key(UserName=user)["AccessKey"]
        return Canary(type="aws", token=key["AccessKeyId"], metadata={"secret": key["SecretAccessKey"]})
    elif typ == "slack":
        fake_hook = f"https://hooks.slack.com/services/T00000000/B00000000/{uuid.uuid4().hex}"
        return Canary(type="slack", token=fake_hook, metadata={})
    # SMTP, GitHub PAT и т.д.