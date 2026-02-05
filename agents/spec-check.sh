#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/spec-check.md"

usage() {
  echo "Usage: $(basename "$0") <spec-name>"
  echo ""
  echo "Run a spec completeness check."
  echo ""
  echo "  spec-name   Name of the spec file (without path/extension)"
  echo "              e.g. 'core' checks specs/core.md"
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

SPEC_NAME="$1"
SPEC_FILE="$PROJECT_ROOT/specs/${SPEC_NAME}.md"

if [[ ! -f "$SPEC_FILE" ]]; then
  echo "Error: spec not found: $SPEC_FILE" >&2
  exit 1
fi

cat "$PROMPT_FILE" | claude -p "Evaluate: specs/${SPEC_NAME}.md" --allowedTools "Read"
