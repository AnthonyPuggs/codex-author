# Skill Map

The Codex-native Clo-Author keeps the same research phases as the Claude version, but skills trigger from natural language instead of slash commands.

| Skill | Typical User Prompt | Default Output | Legacy Slash Equivalent |
|------|----------------------|----------------|-------------------------|
| `new-project` | "Set up a new empirical project on X" | Project spec, initial plan, updated profile inputs | `/new-project` |
| `discover` | "Review the literature on X" | Discovery memo, bibliography notes, data inventory | `/discover` |
| `strategize` | "Design the identification strategy for X" | Strategy memo or PAP draft | `/strategize` |
| `analyze` | "Implement the analysis for this dataset" | Scripts, figures, tables, results summary | `/analyze` |
| `write` | "Draft the introduction/results section" | Updated manuscript section | `/write` |
| `review` | "Peer review this paper for JHR" | Review memo, findings, weighted score | `/review` |
| `revise` | "Turn this referee report into revisions" | Response plan, action routing, drafted replies | `/revise` |
| `talk` | "Build a seminar talk from the paper" | Beamer or Quarto slide deck | `/talk` |
| `submit` | "Prepare the replication package" | Package audit, checklist, journal targeting | `/submit` |
| `tools` | "Compile the paper" | Utility output, validation, memory updates | `/tools` |

## Prompting Pattern

Users do not need to memorize skill names. Natural prompts are preferred:

- "Read `AGENTS.md` and start a literature review on minimum wage spillovers."
- "Audit this code for reproducibility and fixed-effects mistakes."
- "Simulate a hostile peer review for JHR."
- "Create a short conference talk from `paper/main.tex`."
