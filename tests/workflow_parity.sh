#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

expect_match() {
  local path="$1"
  local pattern="$2"
  local message="$3"

  if ! rg -q --multiline "$pattern" "$path"; then
    fail "$message ($path)"
  fi
}

expect_file() {
  local path="$1"
  local message="$2"

  if [[ ! -f "$path" ]]; then
    fail "$message ($path)"
  fi
}

expect_match \
  ".agents/plugins/marketplace.json" \
  '"installation":[[:space:]]*"INSTALLED_BY_DEFAULT"' \
  "repo-local marketplace entry must install the clo-author plugin by default"

expect_file \
  "plugins/clo-author/references/runtime-activation.md" \
  "active runtime activation reference must exist"

expect_file \
  "scripts/install_codex_skill_link.sh" \
  "Codex home-level skill-link installer must exist"

expect_match \
  "AGENTS.md" \
  'runtime-activation\.md' \
  "AGENTS.md must list the active runtime activation reference"

expect_match \
  "plugins/clo-author/references/runtime-activation.md" \
  "~/.agents/skills/clo-author" \
  "runtime activation contract must document the Codex home-level skill link"

expect_match \
  "plugins/clo-author/references/runtime-activation.md" \
  'native skill discovery scans `~/.agents/skills/` at startup' \
  "runtime activation contract must state the actual Codex discovery path"

expect_match \
  "plugins/clo-author/references/codex-workflow.md" \
  "No artifact advances to the next phase without its critic's score >= 80" \
  "active workflow must state the critic approval gate explicitly"

expect_match \
  "plugins/clo-author/references/agent-catalog.md" \
  "If a creator artifact exists without a critic score, it is not approved" \
  "active agent catalog must enforce creator-critic approval semantics"

expect_match \
  "plugins/clo-author/references/logging.md" \
  "\\*\\*Round:\\*\\*" \
  "active logging reference must require round tracking"

expect_match \
  "plugins/clo-author/references/logging.md" \
  "\\*\\*Approval:\\*\\*" \
  "active logging reference must require approval state tracking"

expect_match \
  "plugins/clo-author/skills/strategize/SKILL.md" \
  "If CRITICAL issues found, iterate \\(max 3 rounds" \
  "active strategize skill must restore the revision loop"

expect_match \
  "plugins/clo-author/skills/analyze/SKILL.md" \
  "Re-dispatch Coder with specific fixes \\(max 3 rounds\\)" \
  "active analyze skill must restore coder revision rounds"

expect_match \
  "plugins/clo-author/skills/review/SKILL.md" \
  "editor desk review -> referee dispatch -> editorial decision" \
  "active review skill must restore explicit peer-review routing"

expect_match \
  "plugins/clo-author/skills/new-project/SKILL.md" \
  "orchestrates the full dependency graph" \
  "active new-project skill must restore full pipeline orchestration semantics"

expect_match \
  "README.md" \
  "~/.agents/skills/clo-author" \
  "README must document the Codex home-level skill link fallback"

expect_match \
  "guide/index.qmd" \
  "~/.agents/skills/clo-author" \
  "guide quick start must mention the Codex home-level skill link fallback"

echo "workflow parity checks passed"
