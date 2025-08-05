import httpx, os

async def fetch_profile(email: str) -> dict:
    # используем LinkedIn Sales Navigator API или публичный скрейп
    api = "https://api.linkedin.com/v2/emailToProfile"
    token = os.getenv("LINKEDIN_TOKEN")
    r = await httpx.get(api, params={"email": email}, headers={"Authorization": f"Bearer {token}"})
    return r.json()