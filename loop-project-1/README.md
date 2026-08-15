# Practice Project 1 — Watch a Long Task Finish

**Loop Engineering, Concept 4 — in-session loop with a stopping condition.**

An in-session loop that checks a real long-running task every minute, and
tells you the moment it finishes — once, cleanly, and then stops.

## Setup (do this once)

```bash
cd loop-project-1
git add -A
git commit -m "throwaway project 1 setup"
```

(Committing isn't required, but it matches the course's "use a throwaway
git repo" rule — you now have a clean point to reset to if a loop ever
misbehaves.)

## Run it — two terminals

**Terminal 1 — start the long task first.**
Use a short time so you don't have to wait 3 real minutes:

```bash
cd loop-project-1
./long_task.sh 90        # finishes in 90 seconds
```

Leave this terminal running. Watch it print "started" and, 90 seconds
later, "finished... wrote done.flag".

**Terminal 2 — start Claude Code and the loop.**

```bash
cd loop-project-1
claude
```

Say **yes** to the trust prompt (that's what activates `.claude/settings.json`,
so the loop never stops to ask permission each minute).

Then type one sentence:

```
/loop 1m check if long_task.sh has finished (test -f done.flag); if it has, read done.flag, tell me it's done, and stop the loop yourself
```

## What should happen

- Minute 1: "Not finished yet — done.flag doesn't exist."
- Minute 2 (task finishes around 90s in): "✅ Finished! status: finished, ran_for_seconds: 90" — and the loop stops itself.
- You never had to sit staring at the terminal. You glanced back once, at the end.

## Done when (the course's checklist)

- [ ] The loop notices the task finished
- [ ] It says so **once**, not repeatedly
- [ ] It stops cleanly (either it stops itself, or you can `/loop clear` / cancel it in one command)
- [ ] You never sat watching the terminal the whole time

## Try it harder (optional)

Change the task time to something longer than your check interval isn't
a multiple of, e.g. `./long_task.sh 200` with a `2m` loop, and see how many
"not finished yet" beats happen before the real one.

## The concept underneath

A fixed-timer loop (`/loop`) by itself doesn't know when to stop — it just
keeps firing until you cancel it. What makes *this* loop stop on its own is
that you gave it something a command can prove: **the existence of a file**.
That's the same idea as `/goal`'s stopping condition (Concept 5), just done
by hand inside `/loop` instead of the built-in run-until-done command.
