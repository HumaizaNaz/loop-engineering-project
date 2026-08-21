---
name: docs-freshness
description: Steps for one beat of the Project 8 docs-freshness loop — detects drift between root TASKS.md and README.md, and for the maker role when drafting a fix.
---

# Docs-freshness loop — one beat

## 0. Hard safety cap (check this first, every beat)

Read `loop-project-8/beat.log`. If it already has **20 or more** lines,
stop immediately: append one line
`<timestamp> | STOPPED | hard cap of 20 beats reached, no scan performed`
and do nothing else this beat. This cap applies no matter what — it is not
conditional on whether drift is being found.

## 1. Read the spine first

Read `loop-project-8/progress.md` in full — this is the only memory of
past runs. Do not rely on conversation history.

## 2. Soft stop-when-clean rule

If the **last 2 consecutive** entries in `progress.md` both say "no drift
found", stop the loop: append
`<timestamp> | STOPPED | 2 consecutive clean beats, nothing to check`
to `beat.log` and do not scan. (This does not apply to the very first
beats where fewer than 2 prior entries exist.)

## 3. Scan for drift

Read root `TASKS.md` and root `README.md`. Resolve the repo root
robustly — e.g. via `git rev-parse --show-toplevel` — never via a fixed
relative path like `../TASKS.md`; the beat must find the right files
regardless of the working directory it happens to be invoked from. For
each numbered project section in `TASKS.md`:

- Find every line starting with `**Status:**` inside that section.
  - **More than one such line = a CONTRADICTION.** TASKS.md is
    disagreeing with itself about that project's status. This is drift
    even before comparing to README.md.
  - Take the status implied by the section's own heading marker
    (✅ / ⚠️ / ⬜) as the section's intended status.
- Find the matching `## <emoji> Project N` heading in `README.md` and
  compare its emoji/status word to TASKS.md's heading marker.
  - Different emoji/status word = a MISMATCH.

## 4. Log every beat, success or failure — never silent

Append exactly one line to `loop-project-8/beat.log`:

```
<ISO8601 UTC timestamp> | SUCCESS | scanned N sections, found M issues
```

or, if the scan itself could not run (a file missing, unreadable, etc.):

```
<ISO8601 UTC timestamp> | FAILED | <exact error> | NEEDS HUMAN: <reason>
```

Then append a dated entry to `progress.md` listing exactly what was found
(or "no drift found") — do not delete old entries, only append.

## 5. If drift was found — maker steps (only when explicitly asked to fix)

1. Create an isolated worktree on a new branch
   `fix/docs-sync-<UTC-date>`, off `main`. Never edit `TASKS.md` or
   `README.md` directly on `main`.
2. Apply the **smallest correct change**: fix only the flagged
   line(s) — remove a genuinely contradictory duplicate `**Status:**`
   line, or correct a mismatched emoji/word — nothing else. Never
   reword unrelated sentences, never touch other projects' sections.
3. Do not merge to `main` yourself and do not push. Write a draft
   `loop-project-8/pr/fix-docs-sync-<date>.md` describing the diff and
   why it's correct, then stop. A separate checker (and the human)
   decide whether it merges.

## 6. Checker rules (separate role, never the same run as the maker)

Never approve based on "the diff looks small" alone. Read the actual
`git diff main <branch>` and confirm, line by line:

- The diff touches **only** the specific section(s) flagged as drift —
  nothing else changed.
- The resulting single status is actually supported by evidence already
  written in that project's own TASKS.md/README.md entry (its narrative,
  its own "Done when" checklist) — not just asserted.
- Nothing that was already correct got silently changed to something
  else (e.g. a project marked prematurely "Done" when its own text still
  describes open/blocked items).

Reply with a verdict, `PASS` or `FAIL`, and on `FAIL` the specific line(s)
and reason. A PR draft is finalized only on `PASS`.
