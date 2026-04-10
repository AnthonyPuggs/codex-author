#!/bin/bash
# post-edit-lint.sh -- Optional PostToolUse hook wrapper for environments that
# expose the edited file path in CLAUDE_TOOL_ARG_FILE_PATH.

FILE="${CLAUDE_TOOL_ARG_FILE_PATH:-}"
[[ -z "$FILE" ]] && exit 0

case "$FILE" in
  *.R|*.py|*.jl) ;;
  *) exit 0 ;;
esac

case "$FILE" in
  */.claude/*) exit 0 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/lint-scripts.sh" "$FILE" 2>/dev/null

exit 0
