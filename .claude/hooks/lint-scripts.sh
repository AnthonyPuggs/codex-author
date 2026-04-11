#!/bin/bash
# lint-scripts.sh -- Mechanical grep-based linter for R, Python, Julia scripts.
# Advisory only: it reports findings and exits 0.

set -uo pipefail

TARGET="${1:-scripts}"
FILES=()

if [[ -f "$TARGET" ]]; then
  FILES=("$TARGET")
elif [[ -d "$TARGET" ]]; then
  while IFS= read -r -d '' f; do
    FILES+=("$f")
  done < <(find "$TARGET" -type f \( -name "*.R" -o -name "*.py" -o -name "*.jl" \) -print0 2>/dev/null)
else
  echo "LINT: Target not found: $TARGET"
  exit 0
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "LINT: No R/Python/Julia scripts found in $TARGET"
  exit 0
fi

TOTAL_ISSUES=0
TOTAL_HIGH=0
TOTAL_MEDIUM=0
TOTAL_LOW=0

lint_file() {
  local file="$1"
  local ext="${file##*.}"
  local issues=0
  local findings=""

  add_finding() {
    local severity="$1"
    local line="$2"
    local msg="$3"
    findings+="  [$severity] Line $line: $msg"$'\n'
    issues=$((issues + 1))
    case "$severity" in
      HIGH) TOTAL_HIGH=$((TOTAL_HIGH + 1)) ;;
      MEDIUM) TOTAL_MEDIUM=$((TOTAL_MEDIUM + 1)) ;;
      LOW) TOTAL_LOW=$((TOTAL_LOW + 1)) ;;
    esac
  }

  add_finding_noline() {
    local severity="$1"
    local msg="$2"
    findings+="  [$severity] $msg"$'\n'
    issues=$((issues + 1))
    case "$severity" in
      HIGH) TOTAL_HIGH=$((TOTAL_HIGH + 1)) ;;
      MEDIUM) TOTAL_MEDIUM=$((TOTAL_MEDIUM + 1)) ;;
      LOW) TOTAL_LOW=$((TOTAL_LOW + 1)) ;;
    esac
  }

  while IFS=: read -r num line; do
    [[ -n "$num" ]] && add_finding "HIGH" "$num" "Absolute path detected: ${line:0:80}"
  done < <(grep -n '/Users/\|/home/\|/opt/\|C:\\\\' "$file" 2>/dev/null | grep -v '^[[:space:]]*#\|^[[:space:]]*//\|^[[:space:]]*%' || true)

  if [[ "$ext" == "R" ]]; then
    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "HIGH" "$num" "setwd() -- use here() instead"
    done < <(grep -n 'setwd(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "rm(list = ls()) -- restart R instead"
    done < <(grep -n 'rm(list[[:space:]]*=[[:space:]]*ls()' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "HIGH" "$num" "install.packages() in script -- use a project environment instead"
    done < <(grep -n 'install\.packages(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "T/F literal -- use TRUE/FALSE"
    done < <(grep -nE '=[[:space:]]*(T|F)[[:space:]]*[,)]' "$file" 2>/dev/null | grep -v '^[[:space:]]*#\|TRUE\|FALSE' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "sapply() -- use vapply() or lapply()"
    done < <(grep -n 'sapply(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "attach()/detach() -- use explicit column references"
    done < <(grep -n 'attach(\|detach(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "<<- global assignment -- pass state explicitly"
    done < <(grep -n '<<-' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "LOW" "$num" "require() -- prefer library()"
    done < <(grep -n 'require(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#\|requireNamespace' || true)

    while IFS=: read -r num _; do
      if [[ -n "$num" && "$num" -gt 30 ]]; then
        add_finding "LOW" "$num" "library() call after line 30 -- load packages near the top"
      fi
    done < <(grep -n '^[^#]*library(' "$file" 2>/dev/null || true)

    if grep -q 'sample(\|rnorm(\|runif(\|rbinom(\|bootstrap\|boot\|replicate(' "$file" 2>/dev/null; then
      if ! grep -q 'set\.seed(' "$file" 2>/dev/null; then
        add_finding_noline "HIGH" "Stochastic code detected but no set.seed() was found"
      fi
    fi
  fi

  if [[ "$ext" == "py" ]]; then
    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "HIGH" "$num" "os.chdir() -- use pathlib.Path instead"
    done < <(grep -n 'os\.chdir(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)

    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "MEDIUM" "$num" "Wildcard import -- use explicit imports"
    done < <(grep -n 'from .* import \*' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)
  fi

  if [[ "$ext" == "jl" ]]; then
    while IFS=: read -r num _; do
      [[ -n "$num" ]] && add_finding "HIGH" "$num" "cd() -- use joinpath(@__DIR__, ...) instead"
    done < <(grep -nE '^[[:space:]]*cd\(' "$file" 2>/dev/null | grep -v '^[[:space:]]*#' || true)
  fi

  TOTAL_ISSUES=$((TOTAL_ISSUES + issues))
  if [[ $issues -gt 0 ]]; then
    echo "$file ($issues issues):"
    echo -n "$findings"
  fi
}

echo "=== LINT REPORT ==="
echo ""

for f in "${FILES[@]}"; do
  lint_file "$f"
done

echo ""
echo "--- Summary ---"
echo "Files scanned: ${#FILES[@]}"
echo "Total issues:  $TOTAL_ISSUES (HIGH: $TOTAL_HIGH, MEDIUM: $TOTAL_MEDIUM, LOW: $TOTAL_LOW)"

if [[ $TOTAL_ISSUES -eq 0 ]]; then
  echo "Status: CLEAN"
else
  echo "Status: $TOTAL_ISSUES issue(s) found -- review before committing"
fi

exit 0
