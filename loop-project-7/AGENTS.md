# The morning brief with a memory — Project 7 hardened version

Same job as Project 3: find TODO comments in `src/`, compare against
`progress.md`, append only what's new.

**New rule for this project (Concept 14 — observability):**

Every single beat, no matter what happens, append exactly one line to
`beat.log` in this format, before doing anything else is reported:

```
<ISO8601 UTC timestamp> | <SUCCESS|FAILED> | <one-line summary>
```

- On success: `SUCCESS | found N TODOs, M new`
- On failure (a file/folder doesn't exist, a command errors, anything
  unexpected): `FAILED | <exact error> | NEEDS HUMAN: <one-line reason
  a person would need to act on>`

**A beat must never fail silently.** If the beat cannot complete its
normal job, it must still write a `FAILED` line to `beat.log` explaining
exactly what broke, before stopping. Never skip the log line because
something went wrong — that is precisely when it matters most.

Never guess. If `src/` (or whatever path you're told to scan) doesn't
exist, don't assume the TODOs are just "zero" — that is a failure, not a
clean result, and must be logged as `FAILED`.
