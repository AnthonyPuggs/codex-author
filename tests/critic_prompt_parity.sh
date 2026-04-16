#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

command -v rg >/dev/null 2>&1 || fail "ripgrep (rg) required but not found"

expect_file() {
  local path="$1"
  local message="$2"

  if [[ ! -f "$path" ]]; then
    fail "$message ($path)"
  fi
}

expect_match() {
  local path="$1"
  local pattern="$2"
  local message="$3"

  if ! rg -q --multiline "$pattern" "$path"; then
    fail "$message ($path)"
  fi
}

ACTIVE_CRITICS=(
  "plugins/clo-author/references/active-critics/librarian-critic.md"
  "plugins/clo-author/references/active-critics/explorer-critic.md"
  "plugins/clo-author/references/active-critics/strategist-critic.md"
  "plugins/clo-author/references/active-critics/data-engineer-critic.md"
  "plugins/clo-author/references/active-critics/coder-critic.md"
  "plugins/clo-author/references/active-critics/writer-critic.md"
  "plugins/clo-author/references/active-critics/storyteller-critic.md"
)

for critic in "${ACTIVE_CRITICS[@]}"; do
  expect_file "$critic" "active critic prompt must exist"
done

expect_file \
  "plugins/clo-author/references/critic-runtime-contract.md" \
  "shared critic runtime contract must exist"

expect_match \
  "plugins/clo-author/references/critic-runtime-contract.md" \
  "no external MCP/app tools unless the task explicitly requires them" \
  "critic runtime contract must define the no-MCP-by-default rule"

expect_match \
  "plugins/clo-author/references/critic-runtime-contract.md" \
  "severity is an explicit runtime input" \
  "critic runtime contract must define severity injection"

expect_match \
  "plugins/clo-author/references/agent-catalog.md" \
  'Data-engineer[[:space:]]*\\|[[:space:]]*Execution[[:space:]]*\\|[[:space:]]*Cleaning scripts, panel builds, figures[[:space:]]*\\|[[:space:]]*data-engineer-critic' \
  "active agent catalog must pair Data-engineer with data-engineer-critic"

expect_match \
  "plugins/clo-author/references/agent-catalog.md" \
  "plugins/clo-author/references/active-critics/" \
  "active agent catalog must point to the active critic layer"

expect_match \
  "plugins/clo-author/references/codex-workflow.md" \
  "active critic prompt" \
  "active workflow must require loading the active critic prompt"

expect_match \
  "plugins/clo-author/references/codex-workflow.md" \
  "severity" \
  "active workflow must mention explicit severity injection for critics"

expect_match \
  "plugins/clo-author/references/quality-scoring.md" \
  "active prompt file plus the shared critic contract" \
  "quality scoring reference must tie deductions to the active critic prompt layer"

expect_match \
  "plugins/clo-author/skills/discover/SKILL.md" \
  "active-critics/librarian-critic\\.md" \
  "discover must route literature review through the active librarian critic prompt"

expect_match \
  "plugins/clo-author/skills/discover/SKILL.md" \
  "active-critics/explorer-critic\\.md" \
  "discover must route data discovery through the active explorer critic prompt"

expect_match \
  "plugins/clo-author/skills/strategize/SKILL.md" \
  "active-critics/strategist-critic\\.md" \
  "strategize must route through the active strategist critic prompt"

expect_match \
  "plugins/clo-author/skills/analyze/SKILL.md" \
  "active-critics/data-engineer-critic\\.md" \
  "analyze must route Data-engineer output through the active data-engineer critic prompt"

expect_match \
  "plugins/clo-author/skills/analyze/SKILL.md" \
  "active-critics/coder-critic\\.md" \
  "analyze must route Coder output through the active coder critic prompt"

expect_match \
  "plugins/clo-author/skills/review/SKILL.md" \
  "data-engineering review" \
  "review must expose a standalone data-engineering review mode"

expect_match \
  "plugins/clo-author/skills/review/SKILL.md" \
  "active-critics/data-engineer-critic\\.md" \
  "review must route data-pipeline review through the active data-engineer critic prompt"

expect_match \
  "plugins/clo-author/skills/write/SKILL.md" \
  "active-critics/writer-critic\\.md" \
  "write must route through the active writer critic prompt"

expect_match \
  "plugins/clo-author/skills/talk/SKILL.md" \
  "active-critics/storyteller-critic\\.md" \
  "talk must route through the active storyteller critic prompt"

expect_match \
  "plugins/clo-author/skills/new-project/SKILL.md" \
  "data-engineer-critic" \
  "new-project must update the pipeline to reflect the dedicated data-engineer critic"

expect_match \
  "guide/architecture.qmd" \
  "active-critics/" \
  "architecture guide must document the active critic prompt layer"

expect_match \
  "guide/agents.qmd" \
  "active-critics/" \
  "agents guide must document the active critic prompt layer"

expect_match \
  "guide/customization.qmd" \
  "active-critics/" \
  "customization guide must document the active critic prompt layer"

expect_match \
  "guide/agents.qmd" \
  "legacy-agents/" \
  "agents guide must keep legacy prompts clearly archival"

expect_match \
  "plugins/clo-author/references/active-critics/librarian-critic.md" \
  "## Scoring" \
  "active librarian critic must preserve a scoring section"

expect_match \
  "plugins/clo-author/references/active-critics/coder-critic.md" \
  "## 12 Check Categories" \
  "active coder critic must preserve the detailed category structure"

expect_match \
  "plugins/clo-author/references/active-critics/strategist-critic.md" \
  "## Phase 1: What's the Claim\\?" \
  "active strategist critic must preserve the phased review structure"

expect_match \
  "plugins/clo-author/references/active-critics/writer-critic.md" \
  "## 6 Check Categories" \
  "active writer critic must preserve the detailed category structure"

expect_match \
  "plugins/clo-author/references/active-critics/data-engineer-critic.md" \
  "merge diagnostics" \
  "active data-engineer critic must cover merge diagnostics"

expect_match \
  "plugins/clo-author/references/active-critics/data-engineer-critic.md" \
  "sample-loss accounting" \
  "active data-engineer critic must cover sample-loss accounting"

expect_match \
  "plugins/clo-author/references/active-critics/data-engineer-critic.md" \
  "variable-construction fidelity" \
  "active data-engineer critic must cover variable-construction fidelity"

echo "critic prompt parity checks passed"
