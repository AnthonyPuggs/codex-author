# Content Invariants

These are non-negotiable. Every agent checks against them. Violations are deductions, not suggestions. Critics cite invariant numbers (for example, `violates INV-3`) in their reports.

---

## Paper

**INV-1.** Every table uses `threeparttable` with `tablenotes` explaining key variables, sample, and data source.

**INV-2.** Every figure has a `\caption{}` with a note explaining what is shown, how to read it, and the data source.

**INV-3.** No `\hline` and no vertical rules. Use `\toprule`, `\midrule`, and `\bottomrule`.

**INV-4.** Significance stars follow the journal profile. AEA journals: no stars. Default: stars with a note defining thresholds.

**INV-5.** Abstract is 150 words or fewer.

**INV-6.** JEL codes and keywords appear after the abstract.

**INV-7.** Notation is consistent across all sections. The same symbol means the same thing everywhere.

**INV-8.** Every causal claim has a corresponding identification section. No causal language in descriptive papers.

**INV-9.** Use `biblatex` with `biber`, not `natbib` with `bibtex`.

**INV-10.** `hyperref` loads last in the preamble.

**INV-11.** Numbers in text match the tables and figures exactly. No stale values or silent rounding discrepancies.

**INV-12.** No titles inside ggplot or matplotlib figures. Titles belong in LaTeX `\caption{}`. Panel labels are acceptable.

**INV-13.** Scripts export bare `tabular` environments only. The manuscript source wraps them.

## Code

**INV-14.** `set.seed()` or the language equivalent appears once near the top of the main script when the workflow has any stochastic element.

**INV-15.** All packages and imports load near the top of the script before data loading or computation.

**INV-16.** No absolute paths. Use project-relative path helpers.

**INV-17.** No growing vectors or lists in loops when a pre-allocated or vectorized approach is feasible.

**INV-18.** Output files follow the `Output Organization` setting in `CLAUDE.md` or the active project constitution.

**INV-19.** Do not use prohibited functions such as `setwd()`, `os.chdir()`, `cd()`, `rm(list = ls())`, `install.packages()` in scripts, or `attach()` / `detach()`.

## Talk

**INV-20.** Notation in the talk matches the paper exactly.

**INV-21.** Every slide claim is traceable to the paper or a saved project artifact.
