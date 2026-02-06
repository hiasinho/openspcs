#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PROMPT_FILE="$SCRIPT_DIR/prompts/spec.md"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: $(basename "$0")"
  echo ""
  echo "Start an interactive speccing session. Claude studies the specs and review notes, then you talk."
  exit 0
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: prompt not found: $PROMPT_FILE" >&2
  exit 1
fi

cd "$PROJECT_DIR"
exec claude "$(cat "$PROMPT_FILE")" --dangerously-skip-permissions
