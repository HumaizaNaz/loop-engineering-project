# Practice Project 6 — The Doorbell Loop

**Loop Engineering, Concept 7 — event-driven, Concept 10 — connectors.**

A PR gets a review nobody asked for, flagging a planted bug. This is the
real, honest story of getting there — including the two automated paths
that got blocked, and what was done instead.

## What actually happened (in order)

### Attempt 1 — GitHub Actions workflow calling the Anthropic API directly

Built a `.github/workflows/pr-review.yml` that would `curl` the Anthropic
Messages API on every PR and post the review. **Abandoned**: this needs a
paid `ANTHROPIC_API_KEY` (separate from a Claude Pro subscription, which
does not include API billing). Deleted rather than left half-working.

### Attempt 2 — a real Claude Code Routine with a GitHub PR trigger

This is the actual "Claude Code approach" the course describes: a cloud
Routine, fired by a GitHub `pull_request` webhook, using the
`RemoteTrigger` API (`create` a routine, then `create_webhook_trigger` to
attach the GitHub event).

Blocked for two independent reasons, discovered in order:
1. **"Claude Code Web" is disabled by an org admin** on the account this
   session runs under — the GitHub App install flow lives behind that
   feature, so it couldn't be completed.
2. Even the fallback (`claude.ai/settings/connectors` → Connect GitHub)
   only granted **identity-level OAuth** ("verify identity", "know what
   resources you can access") — GitHub's own authorization page confirmed
   *"Claude has not been installed on any accounts you have access to"* —
   meaning no actual repository access was ever granted. Creating a
   routine with a `git_repository` source kept failing with
   `Connect your GitHub account before saving a routine that uses a
   GitHub repository`, even after the OAuth step.

There was also a legitimate reason not to push harder on this path: the
Claude account available in this session belongs to a friend, shared for
coursework. Granting it standing GitHub App access to a personal GitHub
account (beyond just this one throwaway repo) isn't something to do
without being certain of the scope — and GitHub App installs are normally
account-wide unless carefully restricted to specific repos. Stopping here
was the right call. A test routine created during this attempt was
disabled (the API has no delete — see `claude.ai/code/routines`).

### What was actually done — real PR, real (manually-triggered) review

Since full automation was blocked by account/billing constraints outside
this session's control, the event and the review were both done for
real, just not wired together automatically:

1. Branch `fix/age-validation-refactor` — plants the bug: removes the
   `if age is None: return False` check from
   `loop-project-6/src/validator.py`, disguised as an innocent-looking
   docstring/readability refactor.
2. **PR #1** opened for real via the GitHub API:
   https://github.com/HumaizaNaz/loop-engineering-project/pull/1
3. The diff was read for real (`git diff main fix/age-validation-refactor`),
   the bug reasoned about for real (calling `is_valid_age(None)` now
   raises `TypeError` instead of returning `False`), and the review was
   **posted as a real comment on the real PR** — not just described in
   chat.

This is the same shape as an automated doorbell (diff in → bug flagged →
comment posted), with one honest gap: a human (well, an assistant) had to
say "go" instead of a GitHub webhook doing it. That gap — and exactly
what's missing to close it — is documented above so it's reproducible
later if the account restrictions change.

## Done when (the course's checklist) — partial

- [x] The PR got a review flagging the planted bug, with reasoning, posted
      as a real GitHub PR comment
- [ ] The review fired **automatically**, with zero prompting — blocked,
      see above
- [ ] Pushing a new commit re-fires the review via `synchronize` —
      not testable without the automated trigger

## What it would take to finish this for real

- An account without the "Claude Code Web" org-admin restriction (or that
  restriction lifted), to complete the GitHub App install scoped to just
  this one repository
- Then: `RemoteTrigger create` a routine (prompt: read the PR diff, flag
  deleted null checks / off-by-one errors, post a PR comment) +
  `RemoteTrigger create_webhook_trigger` scoped to this repo's
  `pull_request` events (`opened`, `synchronize`)

## The four heartbeats — status

| Project | Heartbeat | Status |
|---|---|---|
| 1 | In-session | ✅ done |
| 2 | Conditional | ✅ done |
| 3 | Scheduled | ✅ done (simulated as manual "beats") |
| 6 | Event-driven | ⚠️ event + review both real, automatic wiring blocked by account restrictions (documented above) |
