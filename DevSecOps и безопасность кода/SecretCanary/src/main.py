import typer
from generator import create_token
from embedder  import embed
from watcher   import watch
from notifier  import test_alert

app = typer.Typer()

@app.command()
def init(repo: str = ".", token_type: str = "aws"):
    """Создать и встроить токен в репозиторий."""
    tok = create_token(token_type)
    embed(repo, tok)

@app.command()
def watch_loop(repo: str = ".", interval: int = 30):
    """Запустить мониторинг утечек."""
    watch(repo, interval)

@app.command()
def test():
    """Послать тестовый алерт."""
    test_alert()

if __name__ == "__main__":
    app()