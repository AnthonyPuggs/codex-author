# Session Log: 2026-04-11 -- Diagnose Blocked Runtime Activation

**Status:** COMPLETED

## Objective

Determine why the restored Clo-Author workflow was still reported as blocked in Codex, and implement the correct activation path for this machine.

## Runtime State

- Repo contract: PASS
- Machine-level skill discovery path: CONFIRMED
- Machine-level Clo-Author skill link: INSTALLED
- Current live session: STILL BLOCKED UNTIL RESTART

## Root Cause

The repo-local plugin contract was correct on disk, but this Codex harness was not loading repo-local skills from `.agents/plugins/marketplace.json` into the live skill surface. Evidence from the machine configuration showed that native Codex skill discovery on this harness scans `~/.agents/skills/` at startup instead.

This meant the remaining blocker was not the repo content. It was the absence of a machine-level `clo-author` skill link under `~/.agents/skills/`.

## Evidence

| Evidence | Result | Interpretation |
|----------|--------|----------------|
| `.agents/plugins/marketplace.json` | `clo-author` set to `INSTALLED_BY_DEFAULT` | Repo-level marketplace contract was not the active blocker |
| `plugins/clo-author/.codex-plugin/plugin.json` | Present and valid | Plugin manifest existed on disk |
| `plugins/clo-author/skills/` | 10 skill folders present | Skill bundle existed on disk |
| `tests/workflow_parity.sh` | Passed | Active repo control plane was internally consistent |
| `~/.codex/plugins/` | Curated plugin cache only | No evidence that repo-local plugin metadata was being loaded here |
| `~/.codex/config.toml` | Curated plugins enabled explicitly | No explicit machine-level registration for `clo-author` |
| `~/.codex/superpowers/docs/README.codex.md` | Documents Codex-native discovery through `~/.agents/skills/` | Established the actual startup discovery path |
| `~/.agents/skills/superpowers` | Present as a symlink | Confirmed the machine-level discovery pattern already in use |

## Changes Made

| File | Change | Reason |
|------|--------|--------|
| `scripts/install_codex_skill_link.sh` | Added installer and `--check` mode | Provide a repeatable way to install the machine-level skill link |
| `plugins/clo-author/references/runtime-activation.md` | Updated runtime contract to the actual Codex discovery path | Prevent future misdiagnosis of repo-local activation failures |
| `README.md`, `AGENTS.md`, `guide/*.qmd` | Documented the machine-level fallback path | Keep public docs aligned with actual runtime behaviour |
| `tests/workflow_parity.sh` | Added assertions for the installer and machine-level activation contract | Protect the new runtime contract against regression |

## Incremental Work Log

**11:40 AEST:** Confirmed that repo-level parity checks passed while the live skill surface still omitted `clo-author`.

**11:50 AEST:** Inspected `~/.codex/config.toml`, `~/.codex/plugins/`, `~/.agents/skills/`, and Superpowers' Codex installation docs to identify the actual discovery path.

**12:05 AEST:** Determined that this Codex harness discovers local skills from `~/.agents/skills/` at startup rather than from the repo-local marketplace file.

**12:12 AEST:** Added `scripts/install_codex_skill_link.sh` and updated the runtime reference, README, AGENTS, guide pages, and parity test to reflect the machine-level installation path.

**12:18 AEST:** Fixed the parity test matcher so it validated the actual runtime-activation wording rather than a stale phrase.

**12:21 AEST:** Installed `~/.agents/skills/clo-author -> /Users/anthonyp/Desktop/Coding/clo-author-codex/plugins/clo-author/skills`.

## Verification Results

| Check | Result | Status |
|-------|--------|--------|
| Repo workflow parity | `bash tests/workflow_parity.sh` -> `workflow parity checks passed` | PASS |
| Repo diff hygiene | `git diff --check` -> no output | PASS |
| Skill link install check | `bash scripts/install_codex_skill_link.sh --check` -> `OK: /Users/anthonyp/.agents/skills/clo-author -> /Users/anthonyp/Desktop/Coding/clo-author-codex/plugins/clo-author/skills` | PASS |
| Symlink inspection | `ls -la /Users/anthonyp/.agents/skills/clo-author` -> symlink present | PASS |
| Live skill surface in current session | Not refreshable without restarting Codex | PENDING |

## Learnings & Corrections

- [LEARN:activation] On this Codex harness, repo-local plugin metadata is not sufficient evidence of native skill activation; startup discovery depends on `~/.agents/skills/`.
- [LEARN:installation] A machine-level symlink is the reliable path for making local skill bundles discoverable across fresh Codex sessions.

## Next Steps

- [ ] Restart Codex completely.
- [ ] Reopen `/Users/anthonyp/Desktop/Coding/clo-author-codex`.
- [ ] Confirm `clo-author` appears in the live skill surface with all 10 skills before prompting.
- [ ] If the skill surface is still absent after restart, escalate the issue as a Codex-level discovery failure rather than a repo configuration problem.
