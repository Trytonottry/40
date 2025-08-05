import os, schedule, time
from slack_bolt import App
from slack_bolt.adapter.socket_mode import SocketModeHandler
from questions import daily_question
from scoring import answer_handler
from report import build_pdf, send_to_hr

app = App(token=os.getenv("SLACK_BOT_TOKEN"))

@app.message("answer")
def handle_answer(message, say):
    answer_handler(message, say)

def daily_job():
    daily_question(app.client)

schedule.every().day.at("09:00").do(daily_job)
schedule.every(30).days.do(build_pdf)

if __name__ == "__main__":
    SocketModeHandler(app, os.getenv("SLACK_APP_TOKEN")).start()
    while True:
        schedule.run_pending()
        time.sleep(1)