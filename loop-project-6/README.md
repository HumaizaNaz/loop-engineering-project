# Practice Project 6 — The Doorbell Loop

**Loop Engineering, Concept 7 — event-driven, Concept 10 — connectors.**

A loop that fires itself, with zero prompting, whenever a pull request
touches `loop-project-6/`. It's a GitHub Actions workflow
(`.github/workflows/pr-review.yml`) that reads the PR's diff, sends it to
Claude for review, and posts the result back as a PR comment.

## Setup (one-time, done by a human — never paste an API key into a chat)

1. Go to the repo on GitHub → **Settings → Secrets and variables →
   Actions → New repository secret**
2. Name: `ANTHROPIC_API_KEY`, value: your Anthropic API key
3. Save. GitHub encrypts it — it's never visible again, even to you, only
   usable by workflows in this repo

## How it fires (the actual "doorbell")

```
Someone opens or updates a PR touching loop-project-6/
              ↓
GitHub fires the `pull_request` event (opened / synchronize)
              ↓
.github/workflows/pr-review.yml runs, no human involved
              ↓
Gets the diff → sends to Claude → posts the review as a PR comment
```

Pushing new commits to an open PR fires `synchronize` — the loop runs
again automatically. That re-fire on every push is the event heartbeat
actually working.

## The planted bug (for testing this once, live)

`src/validator.py`'s `is_valid_age` has a `None` check:

```python
if age is None:
    return False
```

The test PR removes exactly this check — a deleted null check, calling
`is_valid_age(None)` would then crash instead of returning `False`.

## Done when (the course's checklist)

- [ ] A PR gets a review nobody asked for
- [ ] The review flags the planted bug specifically (not just "looks fine")
- [ ] Pushing a new commit to that PR fires the review again automatically
      (proves the `synchronize` event heartbeat, not just `opened`)

If the review misses the bug, the prompt in `pr-review.yml`'s "Ask Claude
to review the diff" step needs to be tightened — that's the actual lesson,
same as Project 4's checker.

## The four heartbeats, complete

| Project | Heartbeat | Trigger |
|---|---|---|
| 1 | In-session | You type a command, terminal stays open |
| 2 | Conditional | A command's exit code decides |
| 3 | Scheduled | A clock (simulated here as manual "beats") |
| **6** | **Event-driven** | **A GitHub event (PR opened/updated) — no human, no clock** |
