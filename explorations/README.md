# Explorations

This folder is a **sandbox** for experimental and exploratory work. All new ideas, prototypes, and research experiments go here first — never directly into production folders.

## How It Works

1. **Create a subfolder** for each exploration (e.g., `explorations/new-estimator/`)
2. **Work freely** — lower quality threshold (60/100) during exploration
3. **Decide:** graduate to production (80/100 required), keep exploring, or archive

## Rules

- See `plugins/clo-author/references/codex-workflow.md` for the active exploration and fast-track workflow
- Use `AGENTS.md` for the current quality thresholds and persistence rules

## Structure

```
explorations/
├── [active-project]/       # Work in progress
│   ├── README.md           # Goal, hypotheses, status
│   ├── R/                  # Experimental code
│   ├── scripts/            # Test scripts
│   └── output/             # Results
└── ARCHIVE/                # Completed or abandoned
    ├── completed_[name]/   # Graduated to production
    └── abandoned_[name]/   # Documented why stopped
```
