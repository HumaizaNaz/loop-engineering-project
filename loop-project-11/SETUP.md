# Setup order — do these in sequence, on your own Claude account

1. Create **Routine A** (see `ROUTINE-A-SPEC.md`). Fire it once
   ("Run now"). Read its transcript.
2. **Review the draft yourself** — open your Calendar (or the `claude/`
   branch, if you used the GitHub version instead) and confirm the
   draft is what you expect. Don't trust the routine's own summary
   alone.
3. Create **Routine B** (see `ROUTINE-B-SPEC.md`). Enable its **API
   trigger**. Copy the bearer token immediately — shown once.
4. Decide: approve or don't. If you approve, fire Routine B with the
   curl call in `ROUTINE-B-SPEC.md`, passing the event ID (or branch
   name) Routine A reported.
5. Open Routine B's run and confirm the action actually happened.

## The A6 checklist — run this over both routines before trusting them

From Appendix A6, the "one minute before you save a cloud Routine"
checklist:

- [ ] **Repositories** (if using the GitHub version instead of
      Calendar): the correct repo only, unrestricted branch pushes off.
- [ ] **Prompt:** self-contained, success condition included, limit
      included. (Both prompts above are self-contained — no external
      context needed beyond the fired-in event ID/branch name.)
- [ ] **Connectors:** every connector the job doesn't need, removed.
      Routine A needs only Calendar (or GitHub). Routine B needs only
      Calendar (or GitHub). Remove Gmail/Canva/anything else if they're
      attached by default.
- [ ] **Environment:** secrets in the variables panel, not `.env`;
      network access as narrow as the job allows. (Neither routine
      above needs secrets if using the Calendar version. The GitHub
      version needs the fine-grained PAT here — see the main repo's
      Project 9/10 notes on why a scoped PAT beats the GitHub App.)
- [ ] **Trigger:** Routine A = one-off only, never recurring. Routine B
      = API trigger only, never a schedule — that's what makes the gate
      real.
- [ ] **State:** not strictly needed for this small drill (no
      progress.md dependency), but note the event ID / branch name is
      the de facto hand-off state between A and B.
- [ ] **Human gate:** Routine A only drafts (a Calendar event marked
      "TEST DRAFT", or a `claude/` branch — never a merge, send, or
      payment). Routine B performs exactly one small, reversible action
      (delete a test event) — nothing destructive or irreversible.
- [ ] **Test run:** fire Routine A once with "Run now", read the
      transcript (not the status color) before trusting it.

## Done when (the course's checklist) — check off once you've done it for real

- [ ] B ran only because you fired it (via the curl call, not "Run
      now" or a schedule)
- [ ] B's transcript shows the action actually happened (event deleted,
      confirmed by opening the run)
- [ ] You've run the A6 checklist above over both routines
