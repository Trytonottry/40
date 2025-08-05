import os, json
from slack_sdk import WebClient
from jira import JIRA

SLACK_TOKEN = os.getenv("SLACK_TOKEN")
JIRA_SERVER = os.getenv("JIRA_SERVER")
JIRA_BASIC  = (os.getenv("JIRA_USER"), os.getenv("JIRA_TOKEN"))

slack = WebClient(token=SLACK_TOKEN)
jira = JIRA(server=JIRA_SERVER, basic_auth=JIRA_BASIC)

def alert(event):
    msg = f"🚨 Canary token leaked!\n{event['html_url']}"
    slack.chat_postMessage(channel="#security", text=msg)
    jira.create_issue(
        project={"key": "SEC"},
        summary="Canary token leaked",
        description=json.dumps(event, indent=2),
        issuetype={"name": "Bug"}
    )

def test_alert():
    alert({"html_url": "https://gist.github.com/test"})