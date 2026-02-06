#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/check-assumptions.md"
TRACKER="$PROJECT_ROOT/tracking/assumptions.md"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: $(basename "$0")"
  echo ""
  echo "Check if existing assumptions have gained new evidence from specs."
  echo "Updates tracking/assumptions.md with any findings."
  exit 0
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: prompt not found: $PROMPT_FILE" >&2
  exit 1
fi

if [[ ! -f "$TRACKER" ]]; then
  echo "Error: no assumption tracker found: $TRACKER" >&2
  echo "Run extract-assumptions.sh first." >&2
  exit 1
fi

echo "Checking assumptions against current specs..."
cat "$PROMPT_FILE" | claude -p --allowedTools "Read,Edit,Glob,Grep" --dangerously-skip-permissions
echo "Done. See tracking/assumptions.md"
