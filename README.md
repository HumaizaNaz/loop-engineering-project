# Practice Project 2 — Make the Tests Pass, Then Stop

**Loop Engineering, Concept 5 — conditional loop, and Concept 11 — maker-checker.**

A loop that fixes `calculator.py` and reruns `python -m pytest`, over and
over, until the tests themselves report success — capped at 6 attempts.
The agent never gets to decide it's done; only the test runner's exit code
does.

## Setup (do this once)

```bash
cd loop-project-2
git add -A
git commit -m "throwaway project 2 setup"
```

## Why `/loop` is NOT used here

`/loop` is for **time-interval** repeats (e.g. Project 1: "check every 1
minute"). This project doesn't need to wait between attempts — Claude should
fix and retest immediately, back to back. So there's no slash command here:
you give Claude **one plain-English instruction in a normal `claude` session**,
and it keeps calling `python -m pytest` and editing the file, on its own,
inside that same reply, until the stopping condition (tests pass) is met or
the 6-attempt cap is hit.

## Run it — one terminal

```bash
cd loop-project-2
claude
```

Say **yes** to the trust prompt (activates `.claude/settings.json`, so the
loop doesn't stop to ask permission on every attempt).

Then type one sentence:

```
Build a loop that runs `python -m pytest`, fixes the failing tests, and keeps
retrying until the test command exits successfully. Use a maximum of 6
attempts. The test runner must be the only stopping condition: do not stop
early just because the code looks correct. After each failed run, inspect
the failure, fix the code, and run the tests again. Stop immediately once
all tests pass.
```

## What should happen

- Attempt 1: `python -m pytest` → 3 failed (add subtracts, multiply adds,
  subtract multiplies — deliberately swapped operators).
- Claude reads the failure, fixes `calculator.py`.
- Attempt 2: `python -m pytest` → 3 passed → loop stops itself.

## Demo log — what already happened in this repo

Before you run it yourself, this exact loop was demonstrated once, by hand,
inside a Claude Code chat session (not a fresh `claude` run in this folder —
the assistant played maker *and* checker directly with its own tools, just
to show the mechanics):

1. `throwaway project 2 setup` commit — buggy `calculator.py` + correct
   `test_calculator.py`.
2. Attempt 1: `python -m pytest` → **3 failed** (operators were swapped:
   `add` subtracted, `multiply` added, `subtract` multiplied).
3. Fix applied to `calculator.py` (operators corrected) — `test_calculator.py`
   left untouched.
4. Attempt 2: `python -m pytest` → **3 passed** → stopped.
5. `fix calculator...` commit, then this README/AGENTS.md/CLAUDE.md/
   `.claude/settings.json` scaffolding was added and committed
   (`bba181c`) to match Project 1's structure.
6. `calculator.py` was reset back to its buggy version so a fresh,
   real `claude` run — done by the person, not the assistant — would have
   real failing tests to fix.

Check `git log --oneline` and `git status` in this folder any time to see
exactly where things stand versus this log.

## Your own live run (the real point of this project)

After the demo above, the person opened their **own** `claude` session in
this folder (no `/loop`, just a plain message) and pasted the prompt below.
Keeping the exact prompt here so it doesn't get lost:

```
Build a loop that runs `python -m pytest`, fixes the failing tests, and keeps
retrying until the test command exits successfully. Use a maximum of 6
attempts. The test runner must be the only stopping condition: do not stop
early just because the code looks correct. After each failed run, inspect
the failure, fix the code, and run the tests again. Stop immediately once
all tests pass.
```

Result: Claude read the failing `pytest` output, fixed the swapped operators
in `calculator.py`, reran `python -m pytest`, and stopped once it saw
`3 passed` — the same outcome as the demo, but this time it was the
person's own `claude` session doing the maker-checker work, not the
assistant.

## Done when (the course's checklist)

- [ ] The loop stops because the tests actually passed, not because it hit
      the 6-attempt cap
- [ ] Each fix was based on reading the real failure output, not a guess
- [ ] Claude never claimed success without running `python -m pytest` first
- [ ] `test_calculator.py` was never edited — only `calculator.py`

If it keeps hitting the cap without passing, the stop condition or the
prompt needs work — that's the actual lesson of this project.

## The concept underneath

Project 1's stopping condition was "a file exists." This one's stopping
condition is "a command exits 0." Same shape (Concept 5: conditional loop),
different proof. And because the thing fixing the code (Claude) is not the
same thing that decides if it's fixed (`pytest`'s exit code), this is also
**Concept 11 — maker-checker**: the maker is never allowed to be its own
checker.
