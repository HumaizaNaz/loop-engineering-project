# Dreaming loop state

**Last processed up to:** 2026-08-21T08:30:00Z
(covers every Project 8 beat through Beat 7)

## Run history

### Run 1 — 2026-08-21 (cold start)

**Reviewed:** all of `loop-project-8/progress.md` and `loop-project-8/beat.log`
(entries dated after 2026-08-19T00:00:00Z — this was the first dreaming
run, so that covered Project 8's entire real history, Beats 1–7).

**Found:** one repeated pattern, evidence-backed.

- Beat 6 (`2026-08-21T08:00:00Z`) and Beat 7 (`2026-08-21T08:30:00Z`)
  both FAILED with the identical root cause: `docs-freshness/SKILL.md`
  step 3 locates `TASKS.md`/`README.md` via the hardcoded relative path
  `../TASKS.md`, which breaks when a beat runs from a working directory
  other than `loop-project-8/`. Both entries even ask for the same
  human fix ("NEEDS HUMAN: confirm invocation directory or make path
  resolution robust").
- **Honesty note:** `git log` shows these two entries were added by a
  single hand-authored commit (`0152daf`, "plant 2 realistic repeated
  FAILED entries in loop-project-8 (test data for Project 12)"),
  explicitly as course test fixtures, not organic failures from
  independent live beat runs. The underlying bug is real (a genuinely
  fragile hardcoded path), so the fix is justified, but this run's
  "repeated pattern" was planted rather than naturally occurring —
  disclosed here and in the PR description rather than presented as
  something it wasn't.

**Fix drafted:** branch `claude/dreaming-fix-2026-08-21`, isolated
worktree, not merged, not pushed. Changes
`loop-project-8/.claude/skills/docs-freshness/SKILL.md` step 3 only —
replaces the hardcoded relative path with `git rev-parse --show-toplevel`
resolution. Full evidence, diff, and reasoning:
`loop-project-12/pr/claude/dreaming-fix-2026-08-21.md`.

**Deletion candidate proposed:** the MISMATCH check (step 3, second
bullet of `docs-freshness/SKILL.md`) — ran 3 times in the reviewed
window (Beats 1, 3, 4), found zero real mismatches every time, unlike
the adjacent CONTRADICTION check which caught 2 real issues in Beat 1.
**Honest call: don't delete it** — it's bundled into reads the
CONTRADICTION check already requires (zero marginal cost), and 3 clean
beats is too small a sample to call it dead weight. Full reasoning in
the PR description above.

**Main branch:** untouched. Nothing pushed.
