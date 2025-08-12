# ParentConnect Assist

Android-first remote assistance for seniors. MVP = Android (Senior) with full assist; Helper on Android/iOS (guidance mode).

## Monorepo Layout
- `docs/` — cost matrix, sprints, AI roadmap, compliance
- `server/` — Node.js + Socket.io signaling API
- `infra/` — docker-compose for Postgres/Redis/server, coturn template
- `android/` — (placeholder) Senior + Helper apps
- `ios-helper/` — (placeholder) Helper guidance-mode app
- `scripts/` — setup and deploy scripts

## Quick start
```bash
# 1) Copy .env.example → .env and fill values
cp server/.env.example server/.env

# 2) Start local stack (Postgres, Redis, server)
docker compose -f infra/docker-compose.yml up --build

# API: http://localhost:8080/health
```

## License
Proprietary (All rights reserved). Replace with your preferred license if needed.
