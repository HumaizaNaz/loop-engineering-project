# Practice Project 9 — Rehearse a routine for free

**Loop Engineering — Appendix on Routines, Uses A1, A3 (one-off schedules), A5 (reading runs).**

## Adapted from the course's literal instructions — honestly

The course's example task ("summarize yesterday's commits onto a
`claude/summary` branch") needs a GitHub repo attached to the routine.
This shared Claude account is blocked from attaching a repo the platform
way (Claude GitHub App / OAuth — proven blocked in Project 6). Rather
than force that connection just for this drill, this build uses a
**no-repo routine** instead — the A5 lesson (status column vs.
transcript) doesn't need a repo at all, only two runs to compare. This
is the same kind of honest substitution as Projects 3, 5(b), and 6.

## What was actually built

One real Claude Code Routine (`trig_01VUND8BZsjDN32HMjT7Aqrp`), created
via the `RemoteTrigger` API, on the `Default` environment, with no repo
sources — scheduled far in the future (`run_once_at: 2027-08-21`) so it
never fires on its own, then fired twice by hand with `run` ("Run now"),
exactly as the drill describes.

## Run 1 — the success task

**Prompt:** "compute 2026 + 20 + 8, then reply with ONLY the resulting
number."

**Real transcript** (`cse_01U1Q7DZ3PAVwT3N9xRiBNw2`):
```
assistant: 2054
result: success is_error=false turns=1 duration=2s — 2054
```
Correct (2026+20+8=2054). Status: green. Transcript: genuinely correct.

## Run 2 — the task that must fail

**Prompt changed to:** "read the file at path
`/home/user/does-not-exist-project9.txt` using the Read tool, then
report its exact contents. This file is expected to already exist; do
not create it yourself."

**Real transcript** (`cse_01U8iKjtER43QD4iLujC29ST`):
```
tool_use Read: {"file_path":"/home/user/does-not-exist-project9.txt"}
tool_result ERROR: File does not exist. Note: your current working
  directory is /home/user.
assistant: The file does not exist — the Read tool returned "File does
  not exist" for `/home/user/does-not-exist-project9.txt`. As
  instructed, I did not create it. This confirms the expected drill
  outcome, so no notification is warranted...
result: success is_error=false turns=2 duration=5s — The file does not
  exist...
```

**The task genuinely failed** — the file didn't exist, the requested
content was never reported — but the run-level `result` field still
says `success is_error=false`, identical in shape to Run 1's.

## Done when — the course's checklist

- [x] Two green runs seen (both `result: success is_error=false`)
- [x] One transcript shows real success (Run 1: correct arithmetic)
- [x] One transcript shows real failure (Run 2: the actual requested
      information was never obtained)

## The one-sentence answer (the A5 lesson)

**Why the status column couldn't tell them apart:** both sessions ended
normally, with Claude Code itself never crashing or hitting an
infrastructure error, so the platform marks both `success` — the status
column only reports *whether the session completed cleanly*, not
*whether the task you asked for actually happened*, which is why Run
2's real failure is only visible by opening the transcript and reading
what the tool actually returned.

## Cleanup

The routine (`trig_01VUND8BZsjDN32HMjT7Aqrp`) cannot be deleted (no
delete endpoint — confirmed in Project 6 too), only disabled. Since it's
scheduled for 2027 and was only ever fired manually, it's left as-is —
inert, not costing anything, visible at
`https://claude.ai/code/routines/trig_01VUND8BZsjDN32HMjT7Aqrp` if it
ever needs disabling by hand.
