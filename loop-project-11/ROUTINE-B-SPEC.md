# Routine B — the approver's action (spec, not yet created)

<!-- AI ROUTINE NEEDS TO BE CREATED HERE — this routine has not been
     created on any account yet, AND it needs an API trigger enabled
     (a web-UI-only step) before it can be fired the real way. Follow
     SETUP.md to create it and enable its API trigger. -->

**Role:** performs one small, real follow-up action — but only when a
human fires it, never on its own schedule. This is the actual "gate":
Routine A can draft anything it wants, but nothing happens until a
human reads the draft and decides to fire Routine B.

## Why this isn't live yet

Two separate things are both web-UI-only and can't be done through any
tool in this build: (1) creating the routine itself would touch the
account owner's real Calendar the same way Routine A would, and (2)
Routine B specifically needs an **API trigger** (Appendix A3) enabled —
that's a checkbox/section only available at claude.ai/code/routines,
with no CLI or API equivalent for *creating* it (only for *firing* an
already-enabled one).

## Trigger

**API trigger** (not schedule) — this is the whole point of the drill.
Enabling it generates a bearer token, shown exactly once.

## Prompt (paste this exactly as the routine's instructions)

```
This is Routine B of a two-routine human-approval-gate exercise (Loop
Engineering course, Project 11). You have access to a Google Calendar
connector. You will be given an event ID as run-specific context text
when fired. Do exactly this: delete that calendar event (confirming it
was the "Project 11 TEST DRAFT" event before deleting — do not delete
anything else). Report in your final message that the event was
removed, confirming this run only happened because a human approved it.
```

## Setup steps (do these on your own Claude account)

1. Create the routine at claude.ai/code/routines (or via `/schedule`),
   same prompt as above, Google Calendar connector attached, **no**
   recurring schedule.
2. Open the routine's settings, find **Triggers → API**, enable it.
3. **Copy the bearer token the moment it's shown** — it is shown once
   and cannot be retrieved again. Store it in a password manager or
   similar, not in a repo or chat.
4. Note the routine's ID (visible in its URL or the routines list).

## Firing it for real (the actual approval step)

Once Routine A's draft has been reviewed and you decide to approve it,
fire Routine B with the real curl call from Appendix A3 — this is what
makes "B ran only because you fired it" literally true, not just
claimed:

```bash
curl -X POST https://api.anthropic.com/v1/claude_code/routines/<routine-b-id>/fire \
  -H "Authorization: Bearer <routine-b-token>" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -H "anthropic-version: 2023-06-01" \
  -H "Content-Type: application/json" \
  -d '{"text": "Event ID to delete: <event-id-from-routine-A>"}'
```

Replace `<routine-b-id>`, `<routine-b-token>`, and
`<event-id-from-routine-A>` with the real values. The response returns
the new session's ID and URL — open it and confirm the deletion
actually happened, the same way you verified Routine A's draft.
