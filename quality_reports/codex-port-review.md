# Code Review: Codex Port vs Original `scunning1975/clo-author`

## Architecture Changes (Correct and Intentional)

These are expected differences that reflect the Codex platform correctly:

| Change | Verdict |
|--------|---------|
| `AGENTS.md` replaces `CLAUDE.md` as control plane | Correct |
| Skills condensed and moved to `plugins/clo-author/skills/` | Correct — Codex trigger model is different |
| No event hooks (pre-compact, post-compact, protect-files) | Correct — Codex doesn't support Claude Code hooks; `hook-replacements.md` documents the manual equivalents |
| Agent prompts moved to `legacy-agents/` reference material | Correct |
| `plugin.json` added | New Codex infrastructure, not in original |
| `REWRITE` classification added to `revise` skill | Actually an improvement — the original `.claude/rules/revision.md` was missing it |

---

## Real Issues

### 1. `AGENTS.md` compile commands use `bibtex` instead of `biber`

`AGENTS.md:105-106`:
```bash
BIBINPUTS=..:$BIBINPUTS bibtex main
```

The working-paper-format standard (`.claude/rules/working-paper-format.md`, also at `plugins/clo-author/references/legacy-rules/working-paper-format.md`) explicitly requires `biblatex` + `biber`. The compile block in `AGENTS.md` is the one Codex reads every session, so it will produce wrong compilation instructions. Should be:
```bash
biber main
```

### 2. `content-standards.md` contains Claude-specific language

`.claude/rules/content-standards.md:307` (and the copy at `plugins/clo-author/references/legacy-rules/`):
> "Claude DOES NOT attempt to read it directly"

This is Claude Code-specific language in the PDF processing section. Since `content-standards.md` is still active (it's in `.claude/rules/` and still loaded by Claude Code in this session), it needs updating. More importantly, if a Codex-native version of this file needs to exist, it should live under `plugins/clo-author/references/` not just in the legacy path.

### 3. `content-standards.md` has no Codex-native home

The original's `content-standards.md` covers table formatting, figure standards, PDF processing, and exploration protocol — critical standards that apply to any session. It exists in `.claude/rules/` (Claude Code path) but there is **no copy or reference to it under `plugins/clo-author/references/`**, meaning a pure Codex session won't find it when it reads the active reference set from `AGENTS.md`. This is probably the most impactful functional gap.

### 4. Quality scoring weights absent from active Codex references

`codex-workflow.md` only states the gate thresholds (80/90/95). The weighted component scoring (identification 25%, paper 25%, code 15%, etc.) that determines whether a component score blocks submission is only in `plugins/clo-author/references/legacy-rules/quality.md`. Since `agent-catalog.md` doesn't reference it and `AGENTS.md` doesn't list it in Active References, a Codex session running the `review` or `submit` skill has no path to the rubric.

### 5. Session/research journal logging format not in Codex active references

The original's `logging.md` defines two precise output formats: `SESSION_REPORT.md` (append-only, bullet-points per operation) and `quality_reports/research_journal.md` (one entry per agent invocation, used for pipeline state coordination). These are key for multi-agent coordination — the editor reads the journal to know what strategist-critic scored. `codex-workflow.md` says to save session logs but doesn't define the format. Agents won't produce compatible entries without it.

### 6. `tools` skill missing plugin upgrade path

The original's `tools` SKILL included an `upgrade` subcommand that replaces the `.claude/` infrastructure without touching user content. The Codex `tools` skill has no equivalent (`/tools upgrade` → update the plugin). Users forking this repo have no documented mechanism to pull in plugin updates.

### 7. `AGENTS.md` template placeholders left unfilled

`AGENTS.md:10-13` still has `[YOUR PROJECT NAME]`, `[YOUR INSTITUTION]`, `[YOUR FIELD]`. This is correct for a template repo, but the `Current Project State` table at the bottom has the same pattern. If this repo is meant to be both template and working project (as `meta-governance.md` says it is), these need to be filled in for the working-project use case.

---

## Summary

| Issue | Severity | Location |
|-------|----------|----------|
| `bibtex` instead of `biber` in compile commands | High — will produce wrong output | `AGENTS.md:105-106` |
| `content-standards.md` not reachable from Codex active references | High — table/figure standards silently dropped | `AGENTS.md` Active References section |
| Quality scoring weights only in legacy path | Medium — `review`/`submit` skill scoring untethered | `codex-workflow.md` |
| Research journal logging format not in active references | Medium — multi-agent coordination degrades | `codex-workflow.md` |
| Claude-specific language in `content-standards.md` | Low — cosmetic but confusing for Codex users | `.claude/rules/content-standards.md:307` |
| No plugin upgrade path in `tools` skill | Low — operational gap | `plugins/clo-author/skills/tools/SKILL.md` |

The port is structurally sound. The architecture choices (AGENTS.md, plugin layout, no hooks) are all correct. The gaps are mostly around which reference files are linked from the active control plane — `content-standards.md` and the quality scoring rubric need to be surfaced in `plugins/clo-author/references/` and listed in `AGENTS.md`.
