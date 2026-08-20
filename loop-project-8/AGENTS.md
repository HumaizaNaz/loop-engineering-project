# Docs-freshness loop — Project 8 capstone

This repo has two roles that must never be the same run: **maker** (scans
and drafts a fix) and **checker** (independently reviews the fix). Both
follow the `docs-freshness` skill exactly — see
`.claude/skills/docs-freshness/SKILL.md`.

## Observability (carried over from Project 7)

Every single beat, no matter what happens, appends exactly one line to
`beat.log` before anything else is reported — `SUCCESS`, `FAILED`, or
`STOPPED`. A beat must never fail silently, and a stop (hard cap or
soft "nothing to do") must be logged just as visibly as a failure.

## Budget guards

- **Hard cap:** 20 beats total, enforced inside the skill itself, not
  optional.
- **Soft stop:** 2 consecutive clean beats (no drift found) stop the
  loop early — there's nothing left to check.
- Real per-beat token cost is measured (not estimated) and written to
  `COST.md`, same method as Project 7.

## Connector

`gh` CLI, authenticated with the user's own GitHub credentials (already
verified safe in Project 6 — identity only, no broad account access).
**Not exercised for a real push in this build** — the user asked not to
push anything for now, so the connector step stops at a local PR draft
file (`pr/fix-docs-sync-<date>.md`) instead of `gh pr create`. The
mechanism is proven; firing it for real is a one-line follow-up once
pushing is OK.

## Heartbeat — the honest gap

A real scheduled cron (`CronCreate`) was **not re-attempted** here.
Project 8's own repo already proved, 3 days earlier, that this shared
Claude account is blocked by the same org-admin restriction on "Claude
Code Web" (see `loop-project-6/README.md`). Re-running the same
experiment would either fail identically or create another disabled,
undeletable test routine cluttering a friend's account for a second
time, for zero new information. So this build goes straight to the
documented fallback: multiple independent simulated beats (fresh,
memory-isolated dispatches — never relying on this conversation's
history, only on `progress.md` and `beat.log`), honestly labeled as
simulated, not a real week of unattended cron.
