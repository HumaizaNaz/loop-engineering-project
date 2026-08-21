# Routine A — the drafter (spec, not yet created)

<!-- AI ROUTINE NEEDS TO BE CREATED HERE — this routine has not been
     created on any account yet. Follow SETUP.md to create it for
     real when you're on your own Claude account. -->

**Role:** drafts something reviewable, on a one-off schedule. A human
reviews the draft. Nothing it does is final.

## Why this isn't live yet

Creating this for real on the shared account would write a real event
into the account owner's real Google Calendar — an action that touches
someone else's personal account, which this build deliberately avoids
(see `loop-project-11/README.md` for the full reasoning). This spec is
complete and ready to use — only the "click create" step is deferred to
your own account.

## Trigger

One-off schedule (`run_once_at`), fired manually with "Run now" once —
never a repeating schedule. (Course reference: A3, "one-off scheduled
runs do not count against the daily routine cap.")

## Environment

Default environment is fine — no secrets needed for this version.

## Connector needed

Google Calendar (or swap for a `claude/` branch on a repo you own, per
the course's own "a `claude/` branch, or a short summary posted through
a connector" — either satisfies the drill).

## Prompt (paste this exactly as the routine's instructions)

```
This is Routine A of a two-routine human-approval-gate exercise (Loop
Engineering course, Project 11). You have access to a Google Calendar
connector. Do exactly this: create ONE calendar event on the primary
calendar with:
- title: "Project 11 TEST DRAFT - DO NOT ATTEND (delete after review)"
- start: tomorrow at 10:00 (your local time)
- end: tomorrow at 10:15
- description: "This is a reviewable draft created by Routine A for a
  course exercise on the human-approval-gate pattern (Concept 11 /
  Appendix A3-A4). A human will review this event, then a separate
  Routine B will remove it once approved."

After creating it, report the exact event ID in your final message —
Routine B will need it.
```

## After creating and firing it once

1. Open the routine's run transcript — confirm the event was actually
   created (don't just trust the routine's own claim; check the
   calendar directly, or ask a fresh session to `list_events` and
   confirm).
2. Note the event ID it reports — you'll pass this to Routine B.
