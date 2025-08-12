#!/usr/bin/env bash
# Requires GitHub CLI: https://cli.github.com/
set -euo pipefail

REPO_NAME="ParentConnect-Assist"
PRIVATE=${1:-true}

git init
git add .
git commit -m "chore: bootstrap repo skeleton (docs + server + infra)"
gh repo create "$REPO_NAME" ${PRIVATE:+--private} --source=. --push
echo "Repo created and pushed: $REPO_NAME"
