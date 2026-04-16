---
name: discover
description: Discovery phase workflows for research interviews, literature review, data discovery, and ideation. Use when the user asks to scope a topic, review the literature, find datasets, or generate viable research designs.
---

# Discover

Launch the discovery phase and route to the appropriate worker-critic pair based on the user's need.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/critic-runtime-contract.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/logging.md`

## Modes

- interview / scoping
- literature review
- data discovery
- research ideation

## Interview / Scoping

Use a structured conversational interview when the project is still vague.

Suggested sequence:

1. big picture and motivation
2. theoretical intuition
3. data and setting
4. identification possibilities and threats
5. expected results
6. contribution relative to the literature

Produce a research specification in `quality_reports/` and calibrate the domain profile when the repo is still in template mode.

## Literature Review

Dispatch:

- Librarian to collect and synthesize sources
- librarian-critic via `plugins/clo-author/references/active-critics/librarian-critic.md` to check coverage, recency, gaps, and scope drift

Workflow:

1. read existing specs, notes, and bibliography files
2. browse when the frontier or publication status may have changed
3. search top journals, field journals, and working-paper venues
4. follow citation chains forward and backward from the most relevant papers
5. save the synthesis under `quality_reports/`

If the librarian-critic finds material gaps, re-dispatch Librarian once for a targeted follow-up rather than silently accepting incomplete coverage.

## Data Discovery

Dispatch:

- Explorer to build the ranked inventory
- explorer-critic via `plugins/clo-author/references/active-critics/explorer-critic.md` to stress-test feasibility and measurement

Each data candidate should report:

- source and access level
- key variables
- coverage
- likely unit of observation
- feasibility grade
- identification fit with the proposed question

Save the inventory in `quality_reports/`.

## Research Ideation

Use ideation when the user wants candidate paper ideas rather than a committed project.

Outputs should include:

- a short list of viable questions
- likely treatment/outcome variation
- candidate data sources
- the next best workflow step: strategize, more discovery, or abandon

## Outputs

- research spec or scoping memo in `quality_reports/`
- literature memo in `quality_reports/`
- data inventory in `quality_reports/`
- updated domain-profile inputs when field calibration changes

Append research-journal entries when discovery artefacts materially change project direction.
