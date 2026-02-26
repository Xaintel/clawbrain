#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

export CLAWBRAIN_LOCAL_DATA_ROOT="${CLAWBRAIN_LOCAL_DATA_ROOT:-$ROOT_DIR/.local/data}"
export CLAWBRAIN_LOCAL_REPO_ROOT="${CLAWBRAIN_LOCAL_REPO_ROOT:-$ROOT_DIR}"
export CLAWBRAIN_LOCAL_DEMO_ROOT="${CLAWBRAIN_LOCAL_DEMO_ROOT:-$ROOT_DIR/.local/projects/demo}"

PROJECT_NAME="${CLAWBRAIN_LOCAL_PROJECT_NAME:-clawbrain-local}"

"$ROOT_DIR/scripts/bootstrap_local.sh"

docker compose \
  -p "$PROJECT_NAME" \
  -f "$ROOT_DIR/docker-compose.yml" \
  -f "$ROOT_DIR/docker-compose.local.yml" \
  up -d --build "$@"

echo "[local-up] ClawBrain local running with project: $PROJECT_NAME"
echo "[local-up] API: ${CLAWBRAIN_LOCAL_API_BIND:-127.0.0.1:18088}"
echo "[local-up] verify: $ROOT_DIR/scripts/verify_brain_local.sh"
