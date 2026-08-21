# Practice Project 10 — The secrets drill

**Loop Engineering — Appendix on Routines, Uses A4 (secrets), A2 (the environment).**

## Split into two halves — one fully real, one partially real (honest gap)

### Half 1 — "gitignored files never reach GitHub" — proven for real, locally

The exact mechanic the drill is about doesn't need a cloud routine at
all: it's ordinary git behavior. Reproduced it directly:

```
$ echo "DUMMY_API_TOKEN=sk-fake-1234567890abcdef" > .env
$ echo ".env" > .gitignore
$ git add README.md .gitignore && git commit -m "init"

$ git status --short --ignored
!! .env

$ git ls-files
.gitignore
README.md

$ git check-ignore -v .env
.gitignore:1:.env	.env

$ git clone p10-origin p10-clone
$ ls p10-clone
.git  .gitignore  README.md        ← no .env

$ test -f p10-clone/.env && echo FOUND || echo "NOT FOUND (expected)"
NOT FOUND (expected)
```

**This is the literal mechanism** the appendix cites: "gitignored files
never reach GitHub, and the cloud clone therefore never contains them."
A cloud Routine's fresh clone would behave identically to this local
clone — same `git clone` mechanic, same result. No simulation of the
*logic*, just no cloud infrastructure needed to prove it.

### Half 2 — the environment-variables panel — mechanism proven, custom secret deferred (honest gap)

Created and fired one real Claude Code Routine
(`trig_01MPoRpb9XTaJSfbQhp9VJY8`, now disabled), no repo attached,
asking it to (1) check for a `.env` file, (2) read a made-up variable
`PROJECT10_DUMMY_TOKEN`, (3) list what environment variable *names* are
actually present.

**Real result** (`cse_011W4hPJ4c6VjzpHdyZXhXU3`):
```
1. .env file: Not found in home or working directory.
2. PROJECT10_DUMMY_TOKEN: UNSET (variable does not exist).
3. Env var names: enumeration works fine (~140 vars set).
```

This proves the **mechanism** works exactly as A4 describes — a
routine's Bash tool can read environment variables directly, no `.env`
lookup needed — but it also proves the honest gap: `PROJECT10_DUMMY_TOKEN`
came back unset because **adding a new custom variable requires the
claude.ai web UI's Environment Variables panel**, which (same as
Project 9/11) has no tool-accessible equivalent. Nothing in this build
can create that variable — only fire a routine and observe what's
already there.

**Side finding, worth noting honestly:** the "Default" environment
already has ~140 platform-managed environment variables for its own
tooling, and a few of their *names* look credential-shaped
(`AWS_ACCESS_KEY_ID`, `GH_TOKEN`, `GITHUB_TOKEN`,
`CLOUDSDK_AUTH_ACCESS_TOKEN`, etc.) — only names were read (per the
prompt's own instruction not to print values), and nothing was done
with them. These clearly belong to the platform's own internal tooling,
not to any account the user controls, so this build treats them as
off-limits and does not attempt to use them for anything — noting their
existence is as far as this goes.

## Done when (the course's checklist)

- [x] Explained the mechanical reason the first path fails: gitignored
      files never reach GitHub, proven with a real local clone, not
      just asserted
- [ ] "The second run reads the token from the environment" — **not
      yet**, because adding *our own* token requires the same web-UI
      Environment step documented in Project 9/11. The mechanism
      (reading env vars via Bash) is proven; only the "add our own
      secret" click remains, same gap as the rest of this build.

## Status: mostly real (gitignore mechanic proven for real; env-var mechanism proven for real; only adding a custom secret is deferred to the same UI step as Projects 9/11)
