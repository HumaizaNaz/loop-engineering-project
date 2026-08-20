# Project 8 — Cost math (Concept 13), measured for real

## Real token usage, every dispatched beat/role (not a guess)

Every maker/checker/scan step in this build was dispatched as a genuinely
isolated agent, and each one's real `subagent_tokens` figure was read from
the harness after it finished:

| Role | Task | Real tokens |
|---|---|---|
| Scan (beat 1) | detect drift in TASKS.md/README.md | 56,112 |
| Maker | draft the real docs-sync fix (worktree) | 48,508 |
| Maker | plant the deliberate bad fix (worktree) | 46,919 |
| Checker | review the real fix → PASS | 45,766 |
| Checker | review the bad fix → FAIL | 50,986 |

This is more data than Project 7 had (which measured one beat): five real,
independent measurements across every role this loop actually uses.

## Pricing used (Claude Sonnet 5, confirmed via the claude-api skill)

| | Input | Output |
|---|---|---|
| Standard | $3.00 / 1M tokens | $15.00 / 1M tokens |
| Introductory (through 2026-08-31 — applies today, 2026-08-20) | $2.00 / 1M tokens | $10.00 / 1M tokens |

## The one honest gap (same as Project 7)

The harness reports one combined `subagent_tokens` number per dispatch, not
an input/output split. Using the same defensible assumption as Project 7 —
these are read-heavy steps (files, diffs, tool-result echoes dominate;
output is a short verdict/summary) — a 90% input / 10% output split at
introductory pricing:

| Role | Cost |
|---|---|
| Scan beat | **≈ $0.157** |
| Maker (real fix) | ≈ $0.136 |
| Maker (bad fix) | ≈ $0.131 |
| Checker (PASS) | ≈ $0.128 |
| Checker (FAIL) | ≈ $0.143 |

## What actually recurs vs. what's occasional

A scan beat runs **every single beat** — that's the real recurring cost.
Maker + checker only fire on the (hopefully rare) beats where the scan
actually finds drift — in this build's real run, that was 1 out of 2 scan
beats so far.

## Monthly cost by cadence — the scan alone

| Cadence | Beats/month | Monthly cost |
|---|---|---|
| Daily | 30 | **≈ $4.71/month** |
| Hourly | 720 | **≈ $113.09/month** |
| Every 5 minutes | ~8,640 | **≈ $1,357/month** |

Add **≈ $0.26** (one real maker+checker round trip) only on beats where
drift is actually found — bounded by the hard cap (20 beats total) and the
soft stop (2 clean beats in a row ends the loop), so this can never run
away unbounded even in the worst case.

**The lesson, same as Project 7:** cadence dominates cost, not task
complexity. Daily is pocket change; every-5-minutes is a real monthly bill
— for a docs-freshness check, daily (or even weekly) is obviously enough,
so that's the cadence this build recommends if it were ever wired to a
real heartbeat.
