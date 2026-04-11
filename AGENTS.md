# AGENTS.md -- Codex Research Architecture for Empirical Social Science

<!--
HOW TO USE:
- Replace [BRACKETED PLACEHOLDERS] with your project details.
- Keep this file lean. Put detailed workflow guidance in `plugins/clo-author/references/`.
- Codex reads this file every session. Treat it as the project constitution.
-->

**Project:** [YOUR PROJECT NAME]
**Institution:** [YOUR INSTITUTION]
**Field:** [YOUR FIELD -- e.g., Economics, Finance, Marketing, Management, Accounting]
**Branch:** main

This repository ships in **template mode**. The placeholders and current-state stubs below are intentional until you bootstrap the repo into a specific working project.

---

## Core Principles

- **Plan first** -- for any non-trivial task, create and save a plan before editing files
- **Spec before plan when needed** -- for ambiguous or high-effort work, create `quality_reports/specs/YYYY-MM-DD_description.md` first
- **Verify after** -- compile, run, or inspect outputs before presenting results
- **Single source of truth** -- `paper/main.tex` is authoritative; talks and supplements derive from it
- **Quality gates** -- nothing ships below 80/100; PR quality starts at 90; submission requires 95 overall and every component >= 80
- **Worker-critic separation** -- creators draft; critics review; critics do not edit files
- **File-backed memory** -- durable lessons belong in `MEMORY.md`, not hidden session memory

---

## Codex Operating Model

- The active control plane is `AGENTS.md` plus the Clo-Author skill bundle at `plugins/clo-author/`
- In Codex, native skill discovery should expose that bundle through `~/.agents/skills/clo-author`
- The canonical Clo-Author upstream is `https://github.com/hugosantanna/clo-author`; use it as the infrastructure baseline for sync work
- Skills live in `plugins/clo-author/skills/` and trigger from natural-language requests
- Shared references live in `plugins/clo-author/references/`
- Use sub-agents only for bounded, parallelizable work with clear ownership
- Default parallelism target is **2-4 sub-agents**; more adds overhead without enough gain
- If sub-agents are unavailable, run the same worker-critic flow sequentially and save the same artifacts
- The legacy `.claude/` directory is migration source material only; do not treat it as the active runtime

---

## Persistence Rules

- Save approved plans to `quality_reports/plans/YYYY-MM-DD_description.md`
- Save requirements specs to `quality_reports/specs/YYYY-MM-DD_description.md`
- Save decision records to `quality_reports/decisions/YYYY-MM-DD_description.md` when discovery or strategy work closes an important choice
- Save session reasoning to `quality_reports/session_logs/YYYY-MM-DD_description.md`
- Save reviews, strategy memos, and discovery artifacts under `quality_reports/`
- Append durable corrections and preferences to `MEMORY.md` using `[LEARN:category]`
- Any interrupted task must be resumable from disk without relying on chat history

---

## Skill Map

| Skill | Typical Prompts |
|-------|-----------------|
| `new-project` | "Start a new empirical project on X", "set up this repo for labor economics" |
| `discover` | "Review the literature on X", "find data for Y", "help me scope a question" |
| `strategize` | "Design an identification strategy for X", "draft a PAP" |
| `analyze` | "Implement the analysis for this dataset", "run a dual-language replication" |
| `write` | "Draft the introduction", "rewrite the strategy section", "humanize this section" |
| `review` | "Review this paper", "peer review for JHR", "audit the code" |
| `revise` | "Turn this referee report into an action plan" |
| `talk` | "Build a seminar talk from the paper", "audit these slides" |
| `submit` | "Recommend journals", "build the replication package", "run the final gate" |
| `tools` | "Compile the paper", "initialize this template", "validate citations", "update project memory" |

Detailed guidance: `plugins/clo-author/references/skill-map.md`

---

## Folder Structure

```text
[YOUR-PROJECT]/
├── AGENTS.md                         # This file
├── plugins/clo-author/               # Codex plugin: skills, references, legacy migrations
├── Bibliography_base.bib             # Centralized bibliography
├── paper/                            # Main manuscript and derived assets
│   ├── main.tex
│   ├── sections/
│   ├── figures/
│   ├── tables/
│   ├── talks/
│   ├── quarto/
│   ├── preambles/
│   ├── supplementary/
│   └── replication/
├── data/
│   ├── raw/
│   └── cleaned/
├── scripts/                          # R, Stata, Python, Julia
├── quality_reports/                  # Plans, specs, decisions, session logs, reviews, scores
├── explorations/                     # Sandbox for fast-track work
├── templates/                        # Session log, report, decision-record, governance, spec templates
└── master_supporting_docs/           # Reference papers and data docs
```

---

## Commands

```bash
# Paper compilation (3-pass, XeLaTeX only)
cd paper && TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
biber main
TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex

# Talk compilation
cd paper/talks && TEXINPUTS=../preambles:$TEXINPUTS xelatex -interaction=nonstopmode talk.tex
```

---

## Active References

- `plugins/clo-author/references/codex-workflow.md` -- plan/spec protocol, delegation, artifact rules
- `plugins/clo-author/references/content-invariants.md` -- non-negotiable paper, code, and talk invariants cited by reviewers
- `plugins/clo-author/references/content-standards.md` -- table, figure, PDF, and exploration standards
- `plugins/clo-author/references/quality-scoring.md` -- weighted scoring rubric, thresholds, and critic severity
- `plugins/clo-author/references/logging.md` -- session-log and research-journal formats
- `plugins/clo-author/references/runtime-activation.md` -- plugin activation contract and startup smoke test
- `plugins/clo-author/references/agent-catalog.md` -- active role catalog for Codex delegation
- `plugins/clo-author/references/domain-profile.md` -- field calibration
- `plugins/clo-author/references/journal-profiles.md` -- journal-specific peer-review calibration
- `plugins/clo-author/references/hook-replacements.md` -- how legacy Claude hooks map to Codex workflows

---

## Output Organization

Output organization: by-script

---

## Current Project State

| Component | File | Status | Description |
|-----------|------|--------|-------------|
| Paper | `paper/main.tex` | [draft/submitted/R&R] | [Brief description] |
| Data | `scripts/R/` | [complete/in-progress] | [Analysis description] |
| Replication | `paper/replication/` | [not started/ready] | [Deposit status] |
| Job Market Talk | `paper/talks/job_market_talk.tex` | -- | [Status] |
