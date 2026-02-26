#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

export CLAWBRAIN_LOCAL_DATA_ROOT="${CLAWBRAIN_LOCAL_DATA_ROOT:-$ROOT_DIR/.local/data}"
export CLAWBRAIN_LOCAL_REPO_ROOT="${CLAWBRAIN_LOCAL_REPO_ROOT:-$ROOT_DIR}"
export CLAWBRAIN_LOCAL_DEMO_ROOT="${CLAWBRAIN_LOCAL_DEMO_ROOT:-$ROOT_DIR/.local/projects/demo}"
export CLAWBRAIN_LOCAL_CODEX_AUTH_DIR="${CLAWBRAIN_LOCAL_CODEX_AUTH_DIR:-$HOME/.codex}"

PROJECT_NAME="${CLAWBRAIN_LOCAL_PROJECT_NAME:-clawbrain-local}"

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  if [[ -d "$CLAWBRAIN_LOCAL_CODEX_AUTH_DIR" ]]; then
    echo "[local-up] using codex login session from $CLAWBRAIN_LOCAL_CODEX_AUTH_DIR"
  else
    echo "[local-up][warn] no OPENAI_API_KEY and no codex auth dir at $CLAWBRAIN_LOCAL_CODEX_AUTH_DIR"
    echo "[local-up][warn] run 'codex login --device-auth' or export OPENAI_API_KEY"
  fi
fi

"$ROOT_DIR/scripts/bootstrap_local.sh"

docker compose \
  -p "$PROJECT_NAME" \
  -f "$ROOT_DIR/docker-compose.yml" \
  -f "$ROOT_DIR/docker-compose.local.yml" \
  up -d --build "$@"

echo "[local-up] ClawBrain local running with project: $PROJECT_NAME"
echo "[local-up] API: ${CLAWBRAIN_LOCAL_API_BIND:-127.0.0.1:18088}"
echo "[local-up] verify: $ROOT_DIR/scripts/verify_brain_local.sh"
