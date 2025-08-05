from storage import save_answer, get_score, add_badge

def answer_handler(message, say):
    user = message["user"]
    value = message["actions"][0]["value"]
    points = 1 if value == "yes" else 0
    save_answer(user, points)
    score = get_score(user)
    badges = ["🥉", "🥈", "🥇", "💎"]
    badge = badges[min(score // 10, len(badges) - 1)]
    add_badge(user, badge)
    say(f"Спасибо! Твой счёт: {score} {badge}")