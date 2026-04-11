# The Codex-Author: AI Research Architecture for Economics
## Clo-Author for Codex
> **Work in progress.** This repository is now being migrated from a Claude Code architecture to a Codex-native research architecture for empirical economics and other social science research.

An open-source Codex research assistant for workflow for primarily empirical economics, although it can be adapted to other fields (finance, marketing, management, accounting, public policy, etc.) by adjusting the domain profile and journal profiles. It is designed to plan, implement and review approaches for your project from literature review through analysis, writing, peer review simulation, and submission packaging. It also requires human review of these research approaches, and is not a substitute.

This repo keeps the research architecture that made the original Clo-Author effective, but re-expresses it in Codex-native primitives:

- `AGENTS.md` as the root constitution
- a repo-local Codex plugin in `plugins/clo-author/`
- natural-language skill triggering instead of slash commands
- file-backed memory and saved plans instead of hidden runtime memory

It is designed as a **hybrid template**: you can fork it as a starter repository, then convert it into a filled-in working project without changing the overall architecture.

**Original lineage:** [Pedro Sant'Anna's claude-code-my-workflow](https://github.com/pedrohcgs/claude-code-my-workflow), extended by Hugo Sant'Anna's Clo-Author and adapted here for Codex use.
**Canonical upstream:** [hugosantanna/clo-author](https://github.com/hugosantanna/clo-author)

This repository is the Codex-native port. Treat `hugosantanna/clo-author` as the upstream baseline for infrastructure refreshes and release comparisons; do not sync against stale downstream forks. My goal is to update Codex-Author regularly in line with new releases.

## Quick Start

```bash
#1. Fork and clone
gh repo fork anthonypuggs/codex-author --clone
cd codex-author

2. Open Codex
codex
```

If you are working in this Codex port, use the current repository as your runtime and use the canonical upstream only as the comparison baseline for template maintenance.

Then open the repository in your Codex environment and start with a prompt like:

> Read `AGENTS.md` and initialize this repository for a new empirical project in **[YOUR FIELD]** on **[YOUR TOPIC]**. Start by building the research spec, then run a literature review on **[YOUR TOPIC]**.

The placeholders in `AGENTS.md` are intentional until you do that bootstrap step.

Codex reads the configuration, fills in your project details, and plans the approach. You approve the plan, it implements and runs review agents, and you review the results.

Using **VS Code?** You can also download the Codex VS Code extension and work through the Codex chat panel (and the macOS Codex desktop app) instead. Everything works the same.


From there, describe work in plain English:

- "Review the literature on Medicaid crowd-out"
- "Find realistic datasets for teacher labor supply"
- "Design the identification strategy for this policy question"
- "Peer review this paper as if it were headed to JHR"

## What It Does

### Contractor Mode

You describe the task. Codex plans the work, uses specialised worker and critic roles, verifies outputs, and routes revisions until the task clears the relevant quality gate.

### Worker-Critic Pairs

Every creator has a paired critic. Critics review but do not edit. Creators draft but do not score themselves.

| Phase | Worker | Critic |
|-------|--------|--------|
| Discovery | Librarian | librarian-critic |
| Discovery | Explorer | explorer-critic |
| Strategy | Strategist | strategist-critic |
| Execution | Data-engineer | coder-critic |
| Execution | Coder | coder-critic |
| Paper | Writer | writer-critic |
| Peer Review | Editor + blind referees | editorial synthesis |
| Presentation | Storyteller | storyteller-critic |
| Infrastructure | Orchestrator, Verifier | — |

### Realistic Peer Review Simulation

The peer review workflow preserves the strongest part of the Clo-Author architecture:

1. Editor desk review
2. Blind domain referee
3. Blind methods referee
4. Editorial synthesis with FATAL / ADDRESSABLE / TASTE classification

### Ten Codex Skills

| Skill | Purpose |
|------|---------|
| `new-project` | Initialise a new research project and kick off the pipeline |
| `discover` | Research interview, literature review, data search, ideation |
| `strategize` | Identification strategy and PAP workflows |
| `analyze` | Data cleaning, estimation, robustness, figures, tables |
| `write` | Draft or revise paper sections |
| `review` | Code review, manuscript review, peer review simulation |
| `revise` | Route referee comments into an action plan |
| `talk` | Build or audit talks derived from the paper |
| `submit` | Journal targeting, replication packaging, final gate |
| `tools` | Compile, validate, summarize context, bootstrap the template, update memory |

### Quality Gates

| Score | Gate | Applies To |
|------|------|------------|
| 80 | Commit | Weighted aggregate |
| 90 | PR | Weighted aggregate |
| 95 | Submission | Aggregate + every component >= 80 |
| — | Advisory | Talks |

## Project Structure

```text
your-project/
├── AGENTS.md                         # Codex root constitution
├── plugins/clo-author/               # Repo-local Codex plugin
│   ├── .codex-plugin/plugin.json
│   ├── skills/
│   ├── references/
│   └── hooks/legacy/
├── Bibliography_base.bib
├── paper/
├── data/
├── scripts/
├── quality_reports/
├── explorations/
├── templates/
└── master_supporting_docs/
```

## Adapting It to Your Field

1. Fill in the placeholders and current project state in `AGENTS.md`.
2. Edit `plugins/clo-author/references/domain-profile.md` for your field's journals, datasets, conventions, and identification strategies.
3. Extend `plugins/clo-author/references/journal-profiles.md` if you need journals beyond the shipped profiles (which are mostly economics).
4. Customize or add skills under `plugins/clo-author/skills/` if your workflow has recurring domain-specific routines.
5. Decide whether to keep all legacy migration material under `.claude/` and `plugins/clo-author/references/legacy-*`, or trim it after bootstrap.

## Bootstrap a Working Project

Use this sequence when turning the template into a live project:

1. Replace the metadata placeholders in `AGENTS.md`.
2. Update the `Current Project State` table so it describes the real manuscript, analysis, replication, and talk status.
3. Calibrate `plugins/clo-author/references/domain-profile.md` to your field and subfield.
4. Save the first spec and plan under `quality_reports/specs/` and `quality_reports/plans/`.
5. Start using `quality_reports/session_logs/` as the running project record.

## Refresh the Infrastructure

When the upstream template changes, refresh the infrastructure selectively:

- update `plugins/clo-author/skills/`, `plugins/clo-author/references/`, `templates/`, and guide docs
- compare against `https://github.com/hugosantanna/clo-author` and translate relevant behavior into the Codex-native surfaces
- preserve `AGENTS.md`, `plugins/clo-author/`, `.agents/`, and other Codex-only control-plane files unless the change is intentionally part of the port
- preserve user research content under `paper/`, `scripts/`, `data/`, `quality_reports/`, and `MEMORY.md`
- preserve project-specific domain and journal calibrations unless you are intentionally replacing them

## Codex Runtime Model

The Codex-native version does **not** depend on Claude slash commands, Claude hooks, or Claude built-in memory.

Instead it uses:

- `AGENTS.md` for always-loaded project rules
- repo-local skills under `plugins/clo-author/skills/`
- field and journal references under `plugins/clo-author/references/`
- persisted plans, specs, session logs, and memory files under `quality_reports/` and `MEMORY.md`

The active operational references now include:

- `plugins/clo-author/references/content-standards.md`
- `plugins/clo-author/references/quality-scoring.md`
- `plugins/clo-author/references/logging.md`

The original `.claude/` directory is still present in this repository as migration source material. It is no longer the active runtime surface.

## Prerequisites

| Tool | Required For | Install |
|------|-------------|---------|
| Codex environment | All orchestration and skill use | Use your preferred Codex CLI or editor integration |
| XeLaTeX | Paper and talk compilation | TeX Live or MacTeX |
| R | Analysis and figures | [r-project.org](https://www.r-project.org/) |
| gh CLI | GitHub operations | [cli.github.com](https://cli.github.com/) |

Optional: Python, Julia, Quarto.

## License

MIT License.
