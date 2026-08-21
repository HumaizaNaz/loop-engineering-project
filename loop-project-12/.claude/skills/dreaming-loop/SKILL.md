---
name: dreaming-loop
description: Steps for one weekly beat of the Project 12 dreaming loop — reads Project 8's logs since the last check, finds repeated failures/corrections, and proposes a rules-file fix as a PR, with cited evidence only.
---

# Dreaming loop — one beat

This loop watches ANOTHER loop (Project 8's docs-freshness loop). It
never edits Project 8's `TASKS.md`/`README.md` work directly — it only
proposes changes to Project 8's own rules (`SKILL.md`/`AGENTS.md`).

## 1. Read your own state first

Read `loop-project-12/dreaming-state.md` — specifically the "Last
processed up to" date. This is the only memory of what you've already
reviewed. Do not re-flag anything already covered by a prior run.

## 2. Read the watched loop's logs, since that date only

Read `loop-project-8/progress.md` and `loop-project-8/beat.log` in
full. Only consider entries dated **after** the "Last processed up to"
timestamp.

## 3. Look for a repeated pattern — evidence required, no guessing

A repeated pattern means the **same kind** of failure or correction
appears in **two or more separate entries** (not two lines of the same
entry). For each candidate pattern, you must be able to cite:
- Which specific log lines (quote them, with their timestamps)
- How many times it happened
- Why that specific rule change would have prevented it

**If you cannot cite at least two separate real occurrences with exact
quoted lines, do not propose a rule change.** State plainly that no
repeated pattern was found with enough evidence this run. A guessed
"improvement" that isn't backed by cited log lines is worse than no
proposal — it steers every future run on nothing.

## 4. Draft the smallest fix, as a PR — never a direct commit

If (and only if) a real repeated pattern was found:

1. Create an isolated worktree, on branch `claude/dreaming-fix-<UTC-date>`,
   off `main`. Never edit `loop-project-8/.claude/skills/docs-freshness/SKILL.md`
   or `loop-project-8/AGENTS.md` directly on `main`.
2. Make the **smallest** change to those files that would have
   prevented the cited pattern — do not rewrite unrelated sections.
3. Write a PR description (as `loop-project-12/pr/<branch-name>.md`,
   local draft only, never pushed) that states, explicitly:
   - Which log lines are the evidence (quoted, with timestamps)
   - How many times the pattern occurred
   - The exact rule-file diff, and why this specific wording stops it
4. Do not merge it yourself. A human decides.

## 5. Propose exactly one deletion — a rule no recent run needed

Look at Project 8's current `SKILL.md`/`AGENTS.md` rules. For each one,
check whether any real (non-planted) log entry in the reviewed window
actually exercised it. Propose deleting the rule with the weakest real
evidence of ever mattering, and say so explicitly in the same PR
description — including the honest case *against* deleting it if the
evidence for keeping it is also real (e.g., a safety cap that's never
fired yet is still worth keeping; say so if that's the honest call,
rather than deleting something just to have proposed a deletion).

## 6. Update your own state

Append a dated entry to `loop-project-12/dreaming-state.md` recording:
what was reviewed, what was found (or "nothing found, with evidence"),
and what the new "Last processed up to" date is. Do not delete prior
entries.
