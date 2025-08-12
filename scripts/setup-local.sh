#!/usr/bin/env bash
set -euo pipefail

pushd server >/dev/null
cp -n .env.example .env || true
npm install
popd >/dev/null

docker compose -f infra/docker-compose.yml up -d --build
echo "Local stack is up. Health: http://localhost:8080/health"
