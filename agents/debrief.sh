#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/debrief.md"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: $(basename "$0")"
  echo ""
  echo "Post-session debrief. Reads all specs, writes tracking/debrief.md."
  exit 0
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: prompt not found: $PROMPT_FILE" >&2
  exit 1
fi

echo "Running debrief..."
cat "$PROMPT_FILE" | claude -p --allowedTools "Read,Write,Glob,Grep" --dangerously-skip-permissions
echo ""
echo "Done. See tracking/debrief.md"
