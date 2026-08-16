# Practice Project 5 (b) — Codify the Body, the `/workflows` Way

**Loop Engineering — the dynamic-workflows interlude, Concept 8 (worktree), Concept 11 (maker-checker).**

This is a **second version of Project 5**. `loop-project-5/` (the first
one) used a hand-written shell script (`run_fix_loop.sh`) + dispatched
agents — the "OpenCode approach" from the course. This folder uses the
**actual Claude Code approach**: describe the workflow in plain words, let
Claude Code's built-in `/workflows` feature write and run the script
itself, then save the working run as a reusable `/command`.

**Important:** `/workflows` is an *interactive terminal feature* — it only
works when a human types it into a real `claude` session. It cannot be
driven from this chat. Every step below must be run by you, in your own
terminal, in this folder.

## The 3 issues (already set up in this repo)

| File | Bug |
|---|---|
| `temperature_convert.py` | `celsius_to_fahrenheit` missing the `* 9/5` scaling |
| `string_reverse.py` | off-by-one slice, drops the last character |
| `list_dedupe.py` | uses `set()`, which does not preserve order |

Confirmed failing already: `4 failed, 2 passed` across the three test files
(see git log — `baseline: 3 issues with failing tests`).

## Step 1 — start Claude Code in this folder

```bash
cd loop-project-5-b
claude
```

Say **yes** to the trust prompt.

## Step 2 — give the plain-words workflow prompt

Paste this exactly:

```text
Use a workflow to draft fixes for these three issues in parallel
worktrees: temperature_convert.py (test_temperature_convert.py),
string_reverse.py (test_string_reverse.py), and list_dedupe.py
(test_list_dedupe.py). For each issue: create its own isolated
worktree, draft the smallest correct fix, run that issue's test file
yourself and show real output, then hand the diff to @reviewer and
ask for a PASS or FAIL verdict with reasons. At the end, show me all
three verdicts together, don't summarize them away.
```

Let it run fully — it will create separate worktrees, fix each issue, test
each one, and get a PASS/FAIL from the `reviewer` subagent
(`.claude/agents/reviewer.md`) for each. This can take a few minutes since
it's doing three real pieces of work.

When it's done and asks about committing/merging, tell it:

```text
leave them as-is for now, don't commit or merge yet
```

## Step 3 — save the run as a reusable command

In the same session:

```text
/workflows
```

Find the run you just did in that view, press **`s`** to save it, and name
it:

```
/fix-three-issues
```

## Step 4 — the actual test: does it remember anything?

This is the whole point of Project 5, done the `/workflows` way. Close
the session **completely**:

```bash
exit
```

Start a genuinely fresh session:

```bash
claude
```

Run the saved command:

```text
/fix-three-issues
```

Watch closely: does it act like the three issues are already fixed (it
shouldn't know that — a fresh session has no memory), or does it redo the
whole draft-and-review cycle from scratch, exactly like the first time?

## Step 5 — what actually happened (real run, not `/workflows` — see note below)

`/workflows` did not exist as a command in this Claude Code install
(`claude --version` → `2.1.233`) — typing it produced no match, and
`/workflow` only fuzzy-matched unrelated plugin skills (`vercel:workflow`,
`figma:figma-generate-design`). Per the course's own caveat ("dynamic
workflows are a research preview"), this feature simply wasn't available
here. So Step 3/4 were adapted: instead of saving and re-running a
`/command`, the exact same plain-words prompt from Step 2 was pasted again
into a **second, fully fresh `claude` session** (after `exit` + restart).

```
What was observed on the second run:
- All three issues were fixed again from scratch: temperature_convert
  (c + 32 → c * 9 / 5 + 32), string_reverse (s[-2::-1] → s[::-1]),
  list_dedupe (set() → an order-preserving loop) — identical fixes to
  run 1, independently re-derived.
- The reviewer (@reviewer) re-graded all three and gave PASS again, with
  its own fresh reasoning each time (e.g. re-verified temperature with
  extra cases: -40°C, 25°C, -273.15°C).

Did it reference anything from the first run's verdicts? NO.
- It never said "these are already fixed" or referred back to the first
  run in any way. It treated all three bugs as freshly discovered and
  did the full maker + checker cycle again, start to finish.

What would this need to become a real loop instead of an engine?
- A heartbeat: something that fires this prompt on its own — a schedule
  or a GitHub PR event — instead of a person pasting it into a new session.
- A spine (progress file): a progress.md that each run reads first and
  writes to after, recording which issues are already fixed/merged, so a
  new run only processes what's actually new instead of redoing
  everything every single time.
```

## Done when (the course's checklist)

- [x] One prompt ran the whole draft-and-review body — 3 issues, isolated
      worktrees, a verdict for each — with no step-by-step prompting after
      you typed it (both times)
- [x] Confirmed on this machine that a fresh session running the exact
      same prompt has no memory of the previous run — it redid all three
      fixes and both verdicts from scratch
- [x] Named the two things (heartbeat + spine) this would need to become
      a real loop

## How this differs from `loop-project-5/`

| | `loop-project-5/` | `loop-project-5-b/` (this one) |
|---|---|---|
| Approach | OpenCode-style: hand-written `run_fix_loop.sh` | Claude Code-style: `/workflows` → `/command` |
| Who writes the orchestration script | You (well, the assistant) | Claude Code itself, from your plain-English description |
| Fan-out mechanism | Dispatched isolated agents, one per candidate | `/workflows`'s own internal parallel worktree handling |
| Reusable as | Re-run the `.sh` file | Re-run `/fix-three-issues` inside any `claude` session in this folder |

Both are valid answers to the same brief — the course explicitly offers
both. The lesson (engine vs. loop) is identical either way.
