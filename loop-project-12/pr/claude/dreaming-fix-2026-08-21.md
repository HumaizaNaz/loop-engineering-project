# Dreaming-loop fix — claude/dreaming-fix-2026-08-21

**Watched loop:** Project 8 (docs-freshness)
**Files changed:** `loop-project-8/.claude/skills/docs-freshness/SKILL.md` (step 3 only)
**Not merged, not pushed.** Draft for human review.

## Evidence — repeated pattern (2 occurrences)

`loop-project-8/progress.md`:

> ### Beat 6 — 2026-08-21T08:00:00Z — FAILED
>
> Beat was invoked from a different working directory than usual. The
> skill's step 3 resolves `TASKS.md`/`README.md` via the hardcoded
> relative path `../TASKS.md` / `../README.md` ("one level up from
> `loop-project-8/`") — from the actual working directory this beat ran
> in, that path did not point at the real files. `TASKS.md` could not be
> found. No scan performed, no comparison against prior history possible.

> ### Beat 7 — 2026-08-21T08:30:00Z — FAILED
>
> Same failure recurred: beat run from a different working directory
> again, `TASKS.md` again not found at the hardcoded relative path
> `../TASKS.md`. This is the second occurrence of the exact same root
> cause as Beat 6.

`loop-project-8/beat.log`:

> `2026-08-21T08:00:00Z | FAILED | TASKS.md not found at relative path ../TASKS.md (beat run from a different working directory) | NEEDS HUMAN: confirm invocation directory or make path resolution robust`
>
> `2026-08-21T08:30:00Z | FAILED | TASKS.md not found at relative path ../TASKS.md (beat run from a different working directory, second occurrence) | NEEDS HUMAN: confirm invocation directory or make path resolution robust`

**Count:** 2 separate beats (Beat 6, Beat 7), same root cause both times, both explicitly asking for human help with the identical wording.

**Why this specific rule change stops it:** the root cause named in both entries is that `SKILL.md` step 3 tells the agent to find `TASKS.md`/`README.md` via a hardcoded relative path (`../TASKS.md`, "one level up from `loop-project-8/`"), which silently assumes the beat is always invoked with `loop-project-8/` as the working directory. Any invocation from elsewhere breaks the same way. Replacing the fixed relative path with a working-directory-independent resolution (`git rev-parse --show-toplevel`) removes the assumption both failures depended on.

## The diff

```diff
--- a/loop-project-8/.claude/skills/docs-freshness/SKILL.md
+++ b/loop-project-8/.claude/skills/docs-freshness/SKILL.md
@@ -28,8 +28,11 @@ beats where fewer than 2 prior entries exist.)
 
 ## 3. Scan for drift
 
-Read root `TASKS.md` and root `README.md` (repo root, one level up from
-`loop-project-8/`). For each numbered project section in `TASKS.md`:
+Read root `TASKS.md` and root `README.md`. Resolve the repo root
+robustly — e.g. via `git rev-parse --show-toplevel` — never via a fixed
+relative path like `../TASKS.md`; the beat must find the right files
+regardless of the working directory it happens to be invoked from. For
+each numbered project section in `TASKS.md`:
 
 - Find every line starting with `**Status:**` inside that section.
   - **More than one such line = a CONTRADICTION.** TASKS.md is
```

Nothing else in the file was touched — steps 0, 1, 2, 4, 5, 6 and the CONTRADICTION/MISMATCH logic inside step 3 are untouched.

## Deletion candidate (exactly one, honest call)

**Candidate considered:** the MISMATCH check — the second bullet of step 3 ("Find the matching `## <emoji> Project N` heading in `README.md` and compare its emoji/status word to TASKS.md's heading marker... Different emoji/status word = a MISMATCH").

**Evidence for weakness:** across every scan beat in the reviewed window (Beat 1, Beat 3, Beat 4 — `progress.md` lines 5–90), this check ran 3 times and found **zero** real mismatches, every time: Beat 1 — "No MISMATCHes found — every project heading emoji in `TASKS.md`... matches the corresponding heading emoji in `README.md`"; Beat 3 — "no MISMATCHes"; Beat 4 — same. Contrast with the adjacent CONTRADICTION check in the same step, which caught 2 real issues in Beat 1 and was confirmed fixed in Beat 3 — that check has earned its place with real evidence; the MISMATCH check, so far, has not.

**Honest call: don't delete it.** Three clean beats is too small a sample to conclude the check is dead weight, and unlike a rule that costs its own dedicated pass, the MISMATCH check is bundled into the same `TASKS.md`/`README.md` reads the CONTRADICTION check already requires — there is no marginal read or extra beat cost to keep it. Deleting it would remove exactly the class of drift (heading emoji/status word disagreeing between the two files) that this whole loop exists to catch, right at the moment when nothing has needed it yet — which is what a still-useful, simply-quiet check looks like, not what a dead one looks like. Recommend keeping it under future review rather than deleting it now.

## Note on evidence provenance (disclosed for honesty, not hidden)

`git log` shows Beat 6 and Beat 7 were added by a hand-authored commit
(`0152daf`, "plant 2 realistic repeated FAILED entries in loop-project-8
(test data for Project 12)"), not produced by an actual autonomous beat
run hitting the bug live. The commit message states this was deliberate:
"a plausible, real fragility in the skill as written (not an invented
scenario), planted to give Project 12's dreaming loop genuine, verifiable
evidence of a repeated failure to find and propose a fix for." The
underlying bug (hardcoded relative path) is real and really would break
under the described conditions — the fix above is justified on that
basis — but a human reviewing this PR should know the two log entries
were hand-written test fixtures for this course exercise, not organic
failures observed in the wild.
