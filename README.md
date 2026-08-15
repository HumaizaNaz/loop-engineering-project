# Practice Project 3 — The Morning Brief With a Memory

**Loop Engineering, Concept 6 — unattended schedule, and Concept 12 — the spine.**

A loop that runs once per beat, greps `src/` for `TODO` comments, and
appends a dated summary to `progress.md` — but only reports what's *new*.
`progress.md` is the loop's spine: its only memory of what already happened.
No spine, no memory — every run would "discover" the same old TODOs again.

## Setup (do this once)

```bash
cd loop-project-3
git add -A
git commit -m "throwaway project 3 setup"
```

## Run it — two beats, two separate `claude` sessions

**Beat 1:**

```bash
cd loop-project-3
claude
```

Say **yes** to the trust prompt. Then:

```text
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

**Simulate a day passing** — add a new TODO:

```bash
echo "    # TODO: validate item prices are not negative" >> src/app.py
```

**Fully close the session and start a new one** (this matters — it's what
makes this a fair test of the spine, exactly like a real scheduled Routine
that has no memory except what it wrote to disk):

```bash
exit
claude
```

Paste the exact same beat prompt again.

## What should happen

- Beat 1: 3 TODOs found, all reported as new (no prior history).
- Beat 2: 4 TODOs found, only **1** reported as new — the other 3 are
  already in `progress.md` and must not be re-reported.

(This repo has already been run through both beats by hand once — see
`progress.md`'s two dated entries and `git log`. Reset to the first commit
if you want a clean run.)

## Done when (the course's checklist)

- [ ] You ran it twice, in two genuinely separate `claude` sessions
- [ ] The second run's entry lists only the TODO that didn't exist in beat 1
- [ ] The first entry is still in `progress.md`, untouched — appended to,
      not overwritten
- [ ] If instead the second run re-listed all 4 as "new," the spine isn't
      working — that's the actual lesson: a loop with no memory re-discovers
      everything, every time.

## The concept underneath

Concept 6 is a **scheduled/unattended loop** — it must work with zero
context carried over between runs, because in the real world (a Routine, a
cron job) each beat starts a brand new process on a machine that remembers
nothing. Concept 12, **the spine**, is the fix: a file (`progress.md`) that
each beat reads before doing anything and writes to before finishing. The
file *is* the memory — not the agent, not the conversation history.
