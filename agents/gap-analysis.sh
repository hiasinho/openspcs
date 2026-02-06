#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/gap-analysis.md"

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: prompt not found: $PROMPT_FILE" >&2
  exit 1
fi

echo "Running gap analysis across specs..."
cat "$PROMPT_FILE" | claude -p --allowedTools "Read,Write,Glob,Grep" --dangerously-skip-permissions
echo "Done. See tracking/findings.md"
