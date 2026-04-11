# Content Invariants

These are non-negotiable. Every active worker, critic, and verifier should check them. When a reviewer finds a violation, cite the invariant number directly, for example `violates INV-3`.

---

## Paper

**INV-1.** Every table uses `threeparttable` with `tablenotes` explaining key variables, sample, and data source.

**INV-2.** Every figure has a `\caption{}` with a note explaining what is shown, how to read it, and the data source.

**INV-3.** No `\hline` and no vertical rules. Use `\toprule`, `\midrule`, and `\bottomrule`.

**INV-4.** Significance stars follow the journal profile. AEA-style journals default to no stars; other outlets may use stars if the note defines thresholds.

**INV-5.** Abstract is 150 words or fewer unless the target outlet explicitly requires something else.

**INV-6.** JEL codes and keywords appear after the abstract for economics-style working papers.

**INV-7.** Notation is consistent across all sections. The same symbol means the same thing everywhere.

**INV-8.** Every causal claim has a matching identification section. Descriptive papers should not use causal language.

**INV-9.** Use `biblatex` with `biber`, not `natbib` with `bibtex`, unless the project intentionally overrides the default.

**INV-10.** `hyperref` loads last in the preamble unless a package explicitly documents a later requirement.

**INV-11.** Numbers in text match the tables and figures exactly. No stale values and no silent rounding mismatches.

**INV-12.** No titles inside `ggplot2`, matplotlib, or similar figures. Titles belong in LaTeX `\caption{}`. Panel labels such as `Panel A` are acceptable.

**INV-13.** Scripts export bare `tabular` environments only. Floating environments, captions, and notes belong in the manuscript source.

## Code

**INV-14.** `set.seed()` or the language-equivalent appears exactly once near the top of the main script when the workflow has any stochastic element.

**INV-15.** All packages or imports load near the top of the script before data loading or computation.

**INV-16.** No absolute paths. Use project-relative paths through `here()` in R, `pathlib.Path` in Python, or `joinpath(@__DIR__, ...)` in Julia.

**INV-17.** No growing vectors or lists inside loops when a pre-allocated or vectorized approach is feasible.

**INV-18.** Output files follow the `Output Organization` setting in `AGENTS.md`.

**INV-19.** Do not use prohibited functions such as `setwd()`, `os.chdir()`, `cd()`, `rm(list = ls())`, `install.packages()` in scripts, or `attach()` / `detach()`.

## Talk

**INV-20.** Notation in the talk matches the paper exactly.

**INV-21.** Every substantive slide claim is traceable to the manuscript or a saved project artifact.

---

## How Roles Use This File

| Role | Primary checks | Default action |
|------|----------------|----------------|
| `writer-critic` | INV-1 through INV-13 | Deduct and cite invariant numbers |
| `coder-critic` | INV-13 through INV-19 | Deduct and cite invariant numbers |
| `storyteller-critic` | INV-20 and INV-21 | Deduct and cite invariant numbers |
| `Verifier` | INV-9, INV-10, INV-14, INV-15, INV-16, INV-19 | Fail verification when a hard violation remains |
| `tools` lint workflow | INV-14, INV-15, INV-16, INV-19 | Advisory warning before deeper review |
