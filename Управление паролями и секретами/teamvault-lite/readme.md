# TeamVault Lite

Бесплатный (freemium) самостоятельный менеджер паролей для малого бизнеса (< 50 человек).  
1-клик деплой через `docker-compose`, встроенный аудит reused/cracked паролей через haveibeenpwned API.

## Скриншот
![ui](docs/ui.png)

## Быстрый старт

```bash
git clone https://github.com/yourorg/teamvault-lite
cd teamvault-lite
cp backend/.env.example backend/.env
docker-compose -f backend/docker-compose.yml up -d
# Открыть http://localhost:8080
