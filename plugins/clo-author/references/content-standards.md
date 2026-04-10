# Content Standards

These are the active Codex-native standards for tables, figures, PDF handling, and exploratory work. Use this reference alongside `AGENTS.md` whenever the task touches manuscript outputs or supporting materials.

## 1. Table Standards

- Put tables inline in the manuscript unless the user explicitly wants an appendix bundle.
- Use `booktabs` rules. Do not use vertical rules or repeated `\hline`.
- Put titles, notes, and labels in LaTeX, not in generated script output.
- Generated table fragments should normally contain the `tabular` material only, not a full floating environment.
- Use `threeparttable` when notes are required.
- Keep one outcome concept per table block unless the comparison is explicitly part of the design.
- Column headers should explain what varies across specifications.

## 2. Figure Standards

- Do not embed full titles or subtitles inside plots. Put context in the file name and the LaTeX `\caption{}`.
- Keep axis labels publication-ready. Use clear labels such as "Employment Rate" rather than raw variable names.
- Use serif fonts or another paper-compatible type treatment in exported figures.
- Prefer PDF output for line charts, coefficient plots, and other vector-friendly figures.
- Use colorblind-friendly palettes and make the design readable in grayscale through shape or linetype.
- Show all years on the x-axis when the series is short enough to remain legible.
- Treat panel labels such as "Panel A" and "Panel B" as acceptable in-figure structure.

## 3. PDF Processing

When supporting papers, referee reports, or slide decks arrive as PDFs:

1. Save them under `master_supporting_docs/` in a descriptive subfolder.
2. Inspect size and page count before reading:

   ```bash
   pdfinfo paper_name.pdf | grep "Pages:"
   ls -lh paper_name.pdf
   ```

3. Do not try to load large PDFs all at once. Split large files into manageable chunks first:

   ```bash
   mkdir -p paper_name/
   for i in {0..9}; do
     start=$((i*5 + 1))
     end=$(((i+1)*5))
     gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=$start -dLastPage=$end \
       -sOutputFile="paper_name/paper_name_p$(printf '%03d' $start)-$(printf '%03d' $end).pdf" \
       paper_name.pdf 2>/dev/null
   done
   ```

4. Read chunks selectively and progressively. Skip appendices and references unless they matter to the task.
5. If chunking fails, document the gap and try narrower page ranges or an alternate tool such as `pdftk`.

## 4. Exploration Protocol

- Exploratory work belongs in `explorations/`.
- Create `explorations/<slug>/README.md` with the goal, hypotheses, stop conditions, and promotion criteria.
- Keep speculative work out of `paper/`, `scripts/`, and `data/cleaned/` until it clears the normal quality bar.
- When an exploration graduates, move only the validated outputs into the production paths and record the transition in a session log.
