# Practice Project 11 — Build the two-routine gate

**Loop Engineering — Appendix on Routines, Uses A3 (the API trigger), A4 (the gate), A6 (the checklist).**

## Honest status: spec complete, not live yet — and here's exactly why

This build hit two separate blockers, both real, both worth naming
plainly rather than working around quietly:

1. **Routine A would write into someone else's real account.** This
   session runs on a friend's shared Claude account (see
   `loop-project-6/README.md` and `loop-project-8/AGENTS.md` for the
   full context). Creating Routine A for real means it actually creates
   a Google Calendar event on *her* real Google Calendar — an action
   that touches a real, personal, external account. When attempted
   directly, the harness itself flagged this as exactly the kind of
   action that needs a human's explicit go-ahead, not an assistant's
   own judgment call. Rather than force it through, this build stopped
   and asked — and then chose not to write into someone else's personal
   Calendar just to complete a practice drill.

2. **Routine B's trigger can't be created by any tool.** Independent of
   the account-sharing issue: an **API trigger** — the specific
   mechanism Project 11 is testing — can only be enabled through the
   claude.ai web UI. There is no CLI command and no API call that
   creates one; the only tool available (`RemoteTrigger`) can *fire* an
   already-enabled API trigger, not *create* one. So even on a fully
   private, single-owner account, this one step requires a human at a
   keyboard.

## What this build actually produced

Full, ready-to-use specifications for both routines:

- **`ROUTINE-A-SPEC.md`** — the drafter. Complete prompt, trigger
  config, connector choice. Marked `<!-- AI ROUTINE NEEDS TO BE CREATED
  HERE -->` at the top.
- **`ROUTINE-B-SPEC.md`** — the approver's action. Complete prompt, the
  exact `curl` call to fire it for real once its API trigger is
  enabled, and the reasoning for why an API trigger (not "Run now") is
  what makes "B ran only because you fired it" literally true.
- **`SETUP.md`** — the exact order of operations, plus the full
  Appendix A6 checklist pre-filled in for this specific pair of
  routines, ready to check off once built for real.

This is deliberately built the way Project 6 was: everything that can
be proven or specified without an unsafe or impossible step *is*, and
the exact remaining gap is documented precisely enough that finishing
it later (on your own Claude account, where Routine A's Calendar
belongs to you) is a copy-paste-and-click job, not a rebuild.

## Done when (the course's checklist) — not yet met, by design

- [ ] B ran only because you fired it — **pending**, needs your own
      account (see above)
- [ ] B's transcript shows the action actually happened — **pending**
- [ ] A6 checklist run over both routines — **pre-filled and ready** in
      `SETUP.md`, needs the routines to exist first

## Status: NOT STARTED (specced, not built) — same honest category as choosing not to force a blocked path, see Project 6

Full setup instructions in `SETUP.md`. When you're on your own Claude
account, this should take under 10 minutes end-to-end.
