#!/bin/bash
# post-edit-lint.sh -- Optional wrapper for environments that expose the edited file
# path via CLAUDE_TOOL_ARG_FILE_PATH. Advisory only.

FILE="${CLAUDE_TOOL_ARG_FILE_PATH:-}"
[[ -z "$FILE" ]] && exit 0

case "$FILE" in
  *.R|*.py|*.jl) ;;
  *) exit 0 ;;
esac

case "$FILE" in
  */plugins/clo-author/*|*/.claude/*) exit 0 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/lint-scripts.sh" "$FILE" 2>/dev/null

exit 0
