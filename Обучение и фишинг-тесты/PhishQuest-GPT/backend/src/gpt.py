import openai, os, json

openai.api_key = os.getenv("OPENAI_API_KEY")

def craft_email(profile: dict, prompt_template: str) -> str:
    prompt = prompt_template.format(
        name=profile["firstName"],
        company=profile["company"],
        title=profile["title"]
    )
    resp = openai.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}]
    )
    return resp.choices[0].message.content