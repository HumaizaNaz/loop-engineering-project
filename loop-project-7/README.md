# Practice Project 7 — Break It On Purpose

**Loop Engineering — Observability, Concept 13 (cost), Concept 14.**

Takes the Project 3 loop (TODO-scanner + `progress.md` spine), measures its
real cost, then sabotages it on purpose and diagnoses the failure using
only what the loop left behind — no replaying the run.

## Part 1 — Measure one beat's cost (see `COST.md`)

A real beat was dispatched and its actual token usage read from the
harness: **38,808 tokens**. Using Claude Sonnet 5 pricing (confirmed via
the `claude-api` skill, not memory) and an estimated 90/10 input/output
split: **≈ $0.163 per beat**.

| Cadence | Monthly cost |
|---|---|
| Daily | ≈ $4.89 |
| Hourly | ≈ $117 |
| Every 5 min | ≈ $1,410 |

Full math and the one honest assumption (no exact input/output split was
available from the harness) are in `COST.md`.

## Part 2 — Sabotage it

`AGENTS.md` was hardened first with an observability rule: **every beat
writes exactly one line to `beat.log`, success or failure — never
silent.** Then a beat was deliberately pointed at `src_incoming/`, a
folder that doesn't exist (real bug shape: a typo'd or moved path).

**Result — did NOT fail silently:**

```
beat.log:
2026-08-17T00:11:45Z | SUCCESS | found 4 TODOs, 0 new
2026-08-17T00:12:43Z | FAILED | src_incoming: No such file or directory | NEEDS HUMAN: create src_incoming/ or confirm the correct source path to scan
```

`progress.md`'s Beat 4 entry also records the failure in full, with a
`NEEDS HUMAN` note explaining exactly what a person needs to decide.

## Part 3 — Diagnose from the spine alone

Without replaying the run — reading only `beat.log` and `progress.md`:

- **What failed:** Beat 4 was told to scan `src_incoming/`, which doesn't exist.
- **When:** `2026-08-17T00:12:43Z` (from the `beat.log` timestamp).
- **How it was found:** one `FAILED` line in `beat.log` plus the matching
  `progress.md` entry — both written by the loop itself, before this
  diagnosis, with no additional investigation.

## Done when (the course's checklist)

- [x] Can say what failed, and when, from the spine alone
- [x] The loop left a clear "needs a human" note instead of failing silently
- [x] Know the loop's monthly cost at a given cadence

## The lesson

Before this project, `beat.log` didn't exist — Project 3's loop only had
`progress.md`, which records *what it found*, not *whether the beat
itself succeeded*. A loop with no failure log looks identical whether
it's working perfectly or silently doing nothing every single beat. The
fix — one log line, every beat, success or failure — is cheap to add and
is the difference between finding out at 9am from a clear note, or not
finding out at all.
