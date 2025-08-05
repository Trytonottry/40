import datetime, os
from storage import fetch_stats
from weasyprint import HTML, CSS

def build_pdf():
    data = fetch_stats(days=30)
    html = f"""
    <h1>Cyber-Habits отчёт</h1>
    <table>
      <tr><th>ФИО</th><th>Баллы</th><th>Бейджи</th></tr>
      {"".join(f"<tr><td>{d['name']}</td><td>{d['score']}</td><td>{d['badges']}</td></tr>" for d in data)}
    </table>
    """
    pdf = HTML(string=html).write_pdf()
    send_to_hr(pdf)

def send_to_hr(pdf_bytes):
    # Отправка в Slack #hr или email
    pass