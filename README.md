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

## Step 5 — write down what you saw

Fill this in based on what actually happened (don't guess):

```
What I observed on the second run:
-

Did it reference anything from the first run's verdicts? (yes/no):
-

What would this need to become a real loop instead of an engine?
- A heartbeat: ___________________________
- A spine (progress file): ___________________________
```

## Done when (the course's checklist)

- [ ] One command (the saved `/fix-three-issues`) ran the whole
      draft-and-review body — 3 issues, isolated worktrees, a verdict for
      each — with no step-by-step prompting after you typed it
- [ ] You confirmed on your own machine that a fresh session running that
      same command has no memory of the previous run
- [ ] You can name the two things (heartbeat + spine) this would need to
      become a real loop

## How this differs from `loop-project-5/`

| | `loop-project-5/` | `loop-project-5-b/` (this one) |
|---|---|---|
| Approach | OpenCode-style: hand-written `run_fix_loop.sh` | Claude Code-style: `/workflows` → `/command` |
| Who writes the orchestration script | You (well, the assistant) | Claude Code itself, from your plain-English description |
| Fan-out mechanism | Dispatched isolated agents, one per candidate | `/workflows`'s own internal parallel worktree handling |
| Reusable as | Re-run the `.sh` file | Re-run `/fix-three-issues` inside any `claude` session in this folder |

Both are valid answers to the same brief — the course explicitly offers
both. The lesson (engine vs. loop) is identical either way.
