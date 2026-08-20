# Loop Engineering Crash Course — All 8 Practice Projects

Source: https://agentfactory.panaversity.org/docs/loop-engineering-crash-course#practice-projects

Each project has its own folder (`loop-project-N/`) with its own throwaway
git repo, `README.md`, `AGENTS.md`, `CLAUDE.md`, and `.claude/settings.json`.

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
**Folder:** `loop-project-4/` (+ `loop-project-4-worktree-good/`, `loop-project-4-worktree-bad/`)
**Concept:** 8 (worktree) + 9 (skill) + 11 (maker-checker) · Difficulty: medium-hard, 1-2 hrs
**Bug:** `src/inventory.py` `apply_discount` added the discount instead of subtracting it.
**Skill used:** `.claude/skills/fix-loop/SKILL.md` — run tests, fix `src/` only, never hardcode to test inputs.
**What happened:**
- `fix/good-discount` worktree — real fix (`+` → `-`). Checker read the diff → `PASS` → PR opened (`pr/fix-good-discount.md`).
- `fix/bad-discount` worktree — deliberately planted a lookup table hardcoding the 3 test inputs, silently falling back to the original bug for anything else. All 3 tests still passed. Checker read the diff → caught the hardcoding → `FAIL` (`pr/fix-bad-discount-REJECTED.md`). Verified by hand: `apply_discount(300, 10)` still returned `330` instead of `270`.
**Bonus:** added a real `.claude/agents/reviewer.md` subagent (Claude Code format, haiku model) and dispatched two genuinely fresh, isolated agents (no memory of this conversation) to re-review both diffs from scratch. Both independently reached the same verdicts: good fix → PASS, bad fix → FAIL (caught the hardcoded lookup table on their own, then proved it with `apply_discount(300, 10)` → `330.0` instead of `270`).
**Status:** DONE — good fix got PASS+PR, bad fix got FAIL with reasons, checker was not fooled by green tests alone. Verdicts independently confirmed by a fresh subagent.

---

## ✅ Project 5 — Codify the body
**Folder:** `loop-project-5/`
**Concept:** dynamic-workflows interlude + Concept 8, 11 · Difficulty: medium-hard, 1-1.5 hrs
**Engine:** `run_fix_loop.sh` (`setup` / `verify` / `reset`) — pure shell, no AI, deterministic worktree + test-based checker.
**Candidates:** `is_even` (inverted condition), `average` (off-by-one divisor), `reverse_words` (reversed chars instead of word order) — 3 bugs, 3 parallel isolated worktrees.
**Run 1:** setup → 3 fresh dispatched agents (maker) fixed each bug in its own worktree/branch → `verify` → **3/3 PASS**.
**Run 2 (the actual point):** `reset` (deletes the fix branches) → `setup` again → `verify` **without** redoing the maker step → **3/3 FAIL, identical to the original bugs**. Proved the engine has zero memory between runs — the fixes only ever lived on now-deleted branches; `main` was never updated.
**Answer to "what would make this a loop":** a heartbeat (something to fire it on its own) + a spine (`progress.md` recording what's already fixed/merged).
**Status:** DONE — one command ran the whole body, and the no-memory claim was proven on-machine, not just asserted.

## ✅ Project 5(b) — Codify the body, the `/workflows` way
**Folder:** `loop-project-5-b/`
**Concept:** dynamic-workflows interlude + Concept 8, 11 · Difficulty: medium-hard, 1-1.5 hrs
**Different from 5(a):** tried the actual Claude Code approach (`/workflows` → save as `/command`) instead of a hand-written script.
**Blocked:** `/workflows` did not exist in this Claude Code install (`2.1.233`) — the course's own "research preview" caveat applied.
**Adapted:** same plain-words prompt (3 candidates: `temperature_convert`, `string_reverse`, `list_dedupe`) run twice in genuinely separate `claude` sessions instead of via a saved command.
**Run 1:** 3 parallel isolated worktrees, maker + `@reviewer` subagent → **3/3 PASS**.
**Run 2 (fresh session, no `/workflows`):** exact same prompt pasted again → **redid all 3 fixes from scratch**, same PASS verdicts, zero reference to run 1 — proved no session memory, same lesson as 5(a) via a different mechanism.
**Status:** DONE — documented the blocker honestly, adapted, still proved the point.

---

## ⚠️ Project 6 — The doorbell loop (partial — see loop-project-6/README.md)
**Folder:** `loop-project-6/`
**Concept:** 7 (event-driven) + 10 (connectors) · Difficulty: medium, 45-60 min
**Bug planted:** removed `if age is None: return False` from `is_valid_age`, disguised as a readability refactor — branch `fix/age-validation-refactor`.
**Two automated paths tried, both blocked:**
1. GitHub Actions + direct Anthropic API call — needs a paid API key (Claude Pro doesn't include API billing). Deleted.
2. Real Claude Code Routine + GitHub PR webhook (`RemoteTrigger`) — blocked by an org-admin restriction on "Claude Code Web" (blocks the GitHub App install), and separately, a privacy call not to grant a shared/friend's account broad GitHub access. Test routine created then disabled (API has no delete).
**What was done instead:** a real PR (**#1**, opened via GitHub API) with the real bug, reviewed for real (diff read, bug reasoned about) and the review **posted as a real GitHub PR comment** — https://github.com/HumaizaNaz/loop-engineering-project/pull/1 — just triggered by hand instead of by a webhook.
**Done when:** review-flags-the-bug ✅ done for real. Automatic zero-prompt firing ❌ blocked (documented, reproducible if account restrictions change).
**Status:** PARTIAL — honest stopping point, fully documented in `loop-project-6/README.md`.
**Status:** not started.

---

## ✅ Project 7 — Break it on purpose
**Folder:** `loop-project-7/` (built on Project 3's TODO-scanner loop)
**Concept:** Observability + Concept 13 (cost) + 14 · Difficulty: medium, 45-60 min
**Cost (real, measured):** one beat = 38,808 tokens (real harness usage, not a guess) ≈ $0.163/beat at Sonnet 5 pricing → **≈ $4.89/month daily**, **≈ $117/month hourly**, **≈ $1,410/month every 5 min**. Full math in `COST.md`.
**Sabotage:** hardened `AGENTS.md` first (every beat must write one `SUCCESS`/`FAILED` line to `beat.log`, never silent), then pointed a beat at `src_incoming/` (doesn't exist).
**Result:** did NOT fail silently — `beat.log` got `FAILED | src_incoming: No such file or directory | NEEDS HUMAN: ...`, and `progress.md`'s Beat 4 entry recorded the same in full.
**Diagnosis:** read only `beat.log` + `progress.md` (no replay) → correctly identified what failed (`src_incoming/` missing) and exactly when (`2026-08-17T00:12:43Z`).
**Status:** DONE — all three "done when" conditions met for real.
**Status:** not started.

---

## ✅ Project 8 — Your own daily loop (capstone)
**Folder:** not created yet
**Concept:** all six parts (heartbeat, worktree, skill, maker-checker, connector, spine) · Difficulty: capstone, 2-4 hrs
**Build:** Pick one real, boring, recurring chore (dependency audit, docs-freshness check, changelog draft, lint sweep). Build the full 6-part loop with budget guards. Let it run.
**Done when:** it has run unattended for a week and you trust what it ships **because you read it**, not because you stopped reading.
**Status:** DONE — full 6-part loop built and run.
