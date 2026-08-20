# Practice Project 8 — Your Own Daily Loop (capstone)

**Loop Engineering — all 6 parts: heartbeat, worktree, skill, maker-checker,
connector, spine.**

## The chore

A real, boring, recurring problem this repo already had: `TASKS.md` and
`README.md` have to be updated together every time a project's status
changes, and nothing checks that they actually stay in sync. This loop
checks that, for real, on this repo's own real files.

## Part 1 — Skill

`.claude/skills/docs-freshness/SKILL.md` — the exact steps a beat follows:
hard-cap check, soft-stop check, scan for CONTRADICTIONs (two `**Status:**`
lines in one TASKS.md section) and MISMATCHes (TASKS.md heading emoji vs.
README.md heading emoji), log, and — only when asked to fix — maker/checker
steps in an isolated worktree.

## Part 2 — Spine

`progress.md` (full run history) + `beat.log` (one line per beat,
`SUCCESS`/`FAILED`/`STOPPED`, never silent — carried over from Project 7).
Every beat below was dispatched as a genuinely fresh, memory-isolated
agent — none of them had access to this conversation, only to these two
files. That's the actual proof the spine works, not conversation memory.

## Part 3 — Worktree

Two isolated worktrees, both branched from `main`, neither touching it
directly: `loop-project-8-worktree-fix` (`fix/docs-sync-2026-08-20`) and
`loop-project-8-worktree-badfix` (`fix/docs-badfix-demo`).

## Part 4 — Maker-checker (two real scenarios, not one)

**Scenario A — a genuine bug, a genuine fix.** Beat 1 found a real,
pre-existing bug: `TASKS.md`'s Project 6 and Project 7 sections each had
*two* contradictory `**Status:**` lines (a correct one, followed by a
stale leftover `not started.` line). The maker fixed it in a worktree —
a two-line deletion, nothing else touched. A fresh checker independently
re-read the diff and the surrounding entry text, confirmed the retained
status was fully supported by each project's own "Done when" narrative,
and returned **PASS**. Merged into local `main` (fast-forward, not
pushed) after a human check-in.

**Scenario B — a deliberately bad fix, planted on purpose.** A second
maker, given no information about what was actually flagged, fabricated
an unrelated "fix": marking Project 8 itself `✅ DONE` in both files,
while leaving `**Folder:** not created yet` untouched two lines above it.
A fresh checker independently caught it — not just "looks wrong," but
specifically: (1) it doesn't touch either of the two real flagged issues,
(2) the entry's own "Done when" criterion (run unattended for a week)
is contradicted by `beat.log`, which shows beats minutes apart on one
day, and (3) it silently overwrites a status that the loop's own real
scan had already confirmed correct. Verdict: **FAIL**, never merged.

Full reasoning for both verdicts is in `progress.md`'s beat history and
was reported live during the build — not summarized after the fact.

## Part 5 — Connector

`gh` CLI, the user's own GitHub credentials (identity-scoped, already
verified safe in Project 6 — no broad account access). **Not fired for
real this time** — pushing was explicitly off the table for this build,
so the connector step stops at a local PR draft file
(`pr/fix-docs-sync-2026-08-20.md`) instead of an actual `gh pr create`.
The mechanism is proven end-to-end up to that last step.

## Part 6 — Heartbeat (the honest gap)

Real cron (`CronCreate`) was **not re-attempted**. Project 6, three days
earlier, already proved this shared Claude account is blocked by an
org-admin restriction on "Claude Code Web." Trying again would either
fail identically or create another disabled, undeletable test routine
cluttering a friend's account — for zero new information. So this build
went straight to the documented fallback: 5 independent, memory-isolated
beats, run in this one working session. **This is not a real week of
unattended cron — it's a simulation, labeled as one, same honest pattern
as Projects 3 and 5(b).**

## What actually happened, beat by beat

| Beat | Result |
|---|---|
| 1 | Scanned → found 2 real CONTRADICTIONs (Project 6, Project 7) |
| 2 | Maker drafted the real fix in a worktree; checker PASSed it; merged to local `main` |
| — | (bad-fix scenario run in parallel, on its own branch, checker FAILed it) |
| 3 | Fresh scan on updated `main` → 0 issues (first clean beat) |
| 4 | Fresh scan → 0 issues (second consecutive clean beat) |
| 5 | Soft-stop rule fired on its own — logged `STOPPED`, did not scan |

The loop found a real bug, fixed it for real, rejected a fake fix for
real reasons, confirmed its own fix worked, and then **stopped itself**
without being told to — using only `beat.log` and `progress.md`, the same
way Project 7's diagnosis worked from the spine alone.

## Budget guards

- **Hard cap:** 20 beats, enforced in the skill itself — checked before
  anything else, every beat.
- **Soft stop:** 2 consecutive clean beats end the loop early — proven
  above, not just described.
- **Cost, measured not estimated:** see `COST.md` — 5 real token
  measurements across every role this loop uses. A scan beat costs
  ≈ $0.157; daily cadence ≈ $4.71/month.

## Done when (the course's checklist) — honest status

- [x] All 6 parts built and exercised for real, on this repo's real files
- [x] A real bug found and really fixed, with a checker that actually
      caught a planted bad fix instead of rubber-stamping it
- [x] The loop stopped itself using only its own spine, no prompting
- [ ] **Ran unattended for a week** — not met. This build proves the
      loop's logic end-to-end in one session; it has not been left
      running against a real calendar week, because the only real
      heartbeat mechanism available on this account is blocked (see
      Part 6). Documented here instead of quietly claimed.

**Status: PARTIAL** — same honest category as Project 6, for the same
underlying reason (the account's cron/Routine restriction), but every
other part of the loop is real, tested, and standing on its own evidence.
