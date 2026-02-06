#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/extract-assumptions.md"
TRACKER="$PROJECT_ROOT/tracking/assumptions.md"

usage() {
  echo "Usage: $(basename "$0") [--fresh]"
  echo ""
  echo "Extract assumptions from specs into tracking/assumptions.md."
  echo ""
  echo "  --fresh   Start from scratch (removes existing tracker before running)"
  exit 1
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: prompt not found: $PROMPT_FILE" >&2
  exit 1
fi

if [[ "${1:-}" == "--fresh" ]]; then
  if [[ -f "$TRACKER" ]]; then
    echo "Removing existing tracker: $TRACKER"
    rm "$TRACKER"
  fi
fi

echo "Extracting assumptions from specs..."
cat "$PROMPT_FILE" | claude -p --allowedTools "Read,Write,Glob,Grep" --dangerously-skip-permissions
echo "Done. See tracking/assumptions.md"
