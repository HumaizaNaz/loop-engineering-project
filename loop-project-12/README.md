# Practice Project 12 — Build a dreaming loop (second capstone)

**Loop Engineering — Concept 12 (spine and improvement loop), Concept 11 (maker-checker), Concept 6 (schedule), Part 5 (human gate).**

A loop over a loop: watches Project 8's real spine (`progress.md` /
`beat.log`) and proposes rule-file changes to Project 8 itself —
evidence-cited only, drafted as a PR, never a direct commit.

## Heartbeat — same honest gap as the rest of this build

A real weekly cron wasn't attempted — the same account-level Routines
restriction documented in Projects 6/9/10/11 applies here too. Simulated
as one real, memory-isolated dispatched beat instead, the same pattern
Project 8 used for its own heartbeat.

## What actually happened — including two honest false starts

**Attempt 1 — the plant was too sloppy, and the loop caught it.** The
first planted "repeated failure" was a single hand-edited, *uncommitted*
`beat.log` line that referenced a `loop-project-12/README.md` that
didn't exist yet. The dreaming loop ran `git diff` on the log file,
noticed the line wasn't real committed history, and correctly refused
to count it as evidence — reporting "nothing found, with evidence"
rather than inventing a fix. This is the loop working exactly as
designed; the plant was the problem, not the loop.

**Attempt 2 — a claimed branch that didn't exist.** The second plant
was committed for real, but claimed a maker had drafted a fix on a
branch (`fix/docs-sync-2026-08-21`) that never actually existed. The
dreaming loop ran `git branch -a`, found no such branch, and again
correctly discarded the entry as unsubstantiated — a genuinely
sophisticated check: it didn't just trust the log line's text, it
verified the artifact the line claimed to reference.

**Attempt 3 — a plant with no artifact to fake, and it worked.** The
third plant was two committed `FAILED`-style log entries (Beats 6 and
7) describing a real, plausible fragility already present in Project
8's actual skill file: `docs-freshness/SKILL.md` step 3 resolves
`TASKS.md`/`README.md` via a hardcoded relative path (`../TASKS.md`),
which breaks if a beat is ever invoked from a different working
directory. This kind of entry makes no artifact claim to fake — it's
just an observation, the same shape as Project 7's `beat.log` failure
lines — so there was nothing for the loop to invalidate.

The dreaming loop found this pattern, **cited the exact lines from
both `progress.md` and `beat.log`**, and — without being told to —
**disclosed on its own that the evidence had been hand-planted**,
distinguishing "the underlying bug is real" from "these specific log
lines came from a live autonomous run." That distinction was never
part of the instructions; the loop made the honest call unprompted.

## The fix (drafted, checker-verified, merged to local main)

Branch `claude/dreaming-fix-2026-08-21`, worktree at
`dreaming-fix-worktree/` (kept as evidence, gitignored). Diff, one hunk,
`docs-freshness/SKILL.md` step 3 only:

```diff
-Read root `TASKS.md` and root `README.md` (repo root, one level up from
-`loop-project-8/`). For each numbered project section in `TASKS.md`:
+Read root `TASKS.md` and root `README.md`. Resolve the repo root
+robustly — e.g. via `git rev-parse --show-toplevel` — never via a fixed
+relative path like `../TASKS.md`; the beat must find the right files
+regardless of the working directory it happens to be invoked from. For
+each numbered project section in `TASKS.md`:
```

Full evidence and reasoning: `pr/claude/dreaming-fix-2026-08-21.md`.

**Checker verdict: PASS** — independently re-read the diff, re-verified
both cited log entries word-for-word against `main` (not the PR's
paraphrase), traced through the mechanics of `git rev-parse
--show-toplevel` to confirm it actually fixes the cwd-dependence that
caused the cited failures, and confirmed the honesty disclosure matched
the real commit history. Full reasoning was reported live during the
build.

**Merged to local `main`** (fast-forward, not pushed) after a human
check-in — same human-gate pattern as Project 8's merge.

## The deletion proposal

Considered deleting the MISMATCH check in `SKILL.md` step 3 (zero real
mismatches found across 3 real scans). **Declined** — it's bundled into
a read the adjacent CONTRADICTION check already needs (zero marginal
cost), and 3 samples is too small to call a drift-detection check dead
weight. Correctly conservative: it did not delete something just to
have proposed a deletion.

## Done when (the course's checklist)

- [x] **The PR's proposed change traces to real, cited log entries** —
      verified word-for-word by an independent checker against `main`,
      not just asserted by the maker.
- [x] **A deliberately planted repeated failure gets caught and turned
      into a proposal** — true on the third, honestly-plants-a-real-bug
      attempt; the first two attempts show the loop correctly *refusing*
      to be fooled by weaker plants, which is arguably stronger evidence
      of the loop working than a first-try success would have been.
- [x] **Nothing changed in the rules file without merging** — the fix
      lived only on an isolated branch/worktree until a human explicitly
      approved the merge.

## Status: DONE — real repeated evidence, real citation-checked fix, real human-gated merge, heartbeat honestly simulated (same gap as Projects 6/8/9/10/11)
