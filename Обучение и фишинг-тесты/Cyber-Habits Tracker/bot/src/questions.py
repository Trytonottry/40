import random, datetime, os
from storage import save_question, get_team_id

QUESTIONS = [
    {"text": "Ты включил 2FA в Steam?", "weight": 3},
    {"text": "Ты обновил пароль банкинга за последние 90 дней?", "weight": 2},
    {"text": "Ты используешь пароль-менеджер?", "weight": 2},
]

def daily_question(client):
    today = datetime.date.today()
    q = random.choice(QUESTIONS)
    blocks = [
        {
            "type": "section",
            "text": {"type": "mrkdwn", "text": f"*{q['text']}*"},
        },
        {
            "type": "actions",
            "elements": [
                {"type": "button", "text": {"type": "plain_text", "text": "Да"}, "value": "yes"},
                {"type": "button", "text": {"type": "plain_text", "text": "Нет"}, "value": "no"},
            ],
        },
    ]
    team_id = get_team_id()
    client.chat_postMessage(channel=team_id, blocks=blocks)
    save_question(today, q)