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

(This repo has already been run once by hand — see the two commits in
`git log`. Reset to the first commit with `git reset --hard <first-hash>`
if you want a clean run.)

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
