# Loop Engineering Crash Course — Practice Projects

My work through the [Loop Engineering crash course](https://agentfactory.panaversity.org/docs/loop-engineering-crash-course#practice-projects) — 4 of 8 practice projects done so far. Full progress log below (also in `TASKS.md`).

Each project has its own folder (`loop-project-N/`) with its own `README.md`, `AGENTS.md`, `CLAUDE.md`, `.claude/settings.json`, and its own git history (preserved here via `git subtree` — see each folder's commits in `git log` for the real attempt-by-attempt progress).

---

## ✅ Project 1 — A watch loop
**Folder:** `loop-project-1/`
**Concept:** 4 (in-session loop) · Difficulty: easy
**Command used:** `/loop 1m check if long_task.sh has finished (test -f done.flag); if it has, read done.flag, tell me it's done, and stop the loop yourself`
**What happened:** `long_task.sh` ran in the background; the loop checked every beat, said "not finished yet" once, then found `done.flag` and stopped itself.
**Status:** DONE — loop noticed finish, said so once, stopped cleanly.

---

## ✅ Project 2 — Make the tests pass, then stop
**Folder:** `loop-project-2/`
**Concept:** 5 (conditional loop) + 11 (maker-checker) · Difficulty: easy-medium
**Command used:** `/goal Fix calculator.py so that running python3 test_calculator.py exits with code 0 and prints "ALL TESTS PASSED"...` (also tried as a plain sentence, and via pytest)
**What happened:** `calculator.py` had swapped operators (add/multiply/subtract wrong). Attempt 1 failed, code fixed, attempt 2 passed. Test runner's exit code was the only stopping signal — never "looks correct."
**Status:** DONE — stopped because tests passed, not because it hit the 6-try cap.

---

## ✅ Project 3 — The morning brief with a memory
**Folder:** `loop-project-3/`
**Concept:** 6 (unattended schedule) + 12 (the spine) · Difficulty: medium
**Command used:** no `/loop` or `/goal` — this concept needs a real scheduled Routine (cron-like), so it was simulated as two separate "beats" (two fresh sessions), each given this plain prompt:
```
This is one beat of a scheduled loop. Do these steps in order:
1. Read progress.md fully first — this is your only memory of past runs.
2. Search the src/ folder for all "TODO" comments (grep for TODO).
3. Compare against what is already in progress.md's run history.
4. Write a short summary: total TODOs, new since last run, list new ones
   (or say "no new TODOs" if none).
5. Append a new dated entry to progress.md — do not delete old entries,
   only append.
6. Show me the new entry.
```
**What happened:** Beat 1 found 3 TODOs (all new, empty spine). A 4th TODO was added to simulate a day passing. Beat 2 found 4 TODOs but reported only 1 as new — `progress.md` (the spine) was the only memory used, not conversation history.
**Status:** DONE — second run built on the first; nothing was re-reported.

---

## ✅ Project 4 — A fix loop with a real checker
**Folder:** `loop-project-4/`
**Concept:** 8 (worktree) + 9 (skill) + 11 (maker-checker) · Difficulty: medium-hard, 1-2 hrs
**Bug:** `src/inventory.py` `apply_discount` added the discount instead of subtracting it.
**Skill used:** `.claude/skills/fix-loop/SKILL.md` — run tests, fix `src/` only, never hardcode to test inputs.
**What happened:**
- `fix/good-discount` worktree — real fix (`+` → `-`). Checker read the diff → `PASS` → PR opened (`pr/fix-good-discount.md`).
- `fix/bad-discount` worktree — deliberately planted a lookup table hardcoding the 3 test inputs, silently falling back to the original bug for anything else. All 3 tests still passed. Checker read the diff → caught the hardcoding → `FAIL` (`pr/fix-bad-discount-REJECTED.md`). Verified by hand: `apply_discount(300, 10)` still returned `330` instead of `270`.
**Bonus:** added a real `.claude/agents/reviewer.md` subagent (Claude Code format, haiku model) and dispatched two genuinely fresh, isolated agents (no memory of this conversation) to re-review both diffs from scratch. Both independently reached the same verdicts: good fix → PASS, bad fix → FAIL (caught the hardcoded lookup table on their own, then proved it with `apply_discount(300, 10)` → `330.0` instead of `270`).
**Status:** DONE — good fix got PASS+PR, bad fix got FAIL with reasons, checker was not fooled by green tests alone. Verdicts independently confirmed by a fresh subagent.

---

## ⬜ Project 5 — Codify the body
**Concept:** dynamic-workflows interlude + Concept 8, 11 · Difficulty: medium-hard, 1-1.5 hrs
**Build:** Turn Project 4's fix-loop into one re-runnable command/script (an "engine"): fan out to several candidate bugs in parallel worktrees, reviewer grades each. Run it twice.
**Done when:** one command runs the whole draft-and-review body with no step-by-step prompting, **and** you prove a fresh session/shell remembers nothing from the last run — then name the two things it would need to become a real loop (a heartbeat + a progress file). That's the difference between an "engine" and a "loop."
**Status:** not started.

---

## ⬜ Project 6 — The doorbell loop
**Concept:** 7 (event-driven) + 10 (connectors) · Difficulty: medium, 45-60 min
**Build:** Make a throwaway repo review its own pull requests automatically — a GitHub PR-trigger Routine (or `opencode github install`). Open a PR with one planted bug (e.g. off-by-one, deleted null check) and wait.
**Done when:** the PR gets an unprompted review that flags the planted bug. Pushing again re-fires the loop via the `synchronize` event — completes all 4 heartbeat types (in-session, conditional, scheduled, event-driven) across Projects 1, 2, 3, 6.
**Status:** not started.

---

## ⬜ Project 7 — Break it on purpose
**Concept:** Observability + Concept 13 (cost) + 14 · Difficulty: medium, 45-60 min
**Build:** Take the Project 3 loop. Measure one beat's token cost, multiply by cadence → monthly cost. Then sabotage it (point at a nonexistent file, or an impossible success condition, with a limit set) and let it fail on schedule.
**Done when:** you can say what failed and when, using **only** the spine (log + `progress.md`) — no replaying the run. The loop must leave a clear "needs a human" note instead of failing silently, and you know its monthly cost.
**Status:** not started.

---

## ⬜ Project 8 — Your own daily loop (capstone)
**Concept:** all six parts (heartbeat, worktree, skill, maker-checker, connector, spine) · Difficulty: capstone, 2-4 hrs
**Build:** Pick one real, boring, recurring chore (dependency audit, docs-freshness check, changelog draft, lint sweep). Build the full 6-part loop with budget guards. Let it run.
**Done when:** it has run unattended for a week and you trust what it ships **because you read it**, not because you stopped reading.
**Status:** not started.
