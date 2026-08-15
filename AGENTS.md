# Fix loop with a real checker

This repo has two roles that must never be the same run.

## Maker (implementer)

Works in its own worktree/branch (never directly on `main`). Follow the
`fix-loop` skill exactly: read the real failing test output, fix the root
cause in `src/`, never touch `test/`, never special-case the exact numbers
a test uses. A fix that only works for the inputs already in the test
suite is not a fix.

## Checker (reviewer)

Never trusts a green test run by itself. Always reads the actual `git diff`
of the change before deciding. Looks specifically for: hardcoded/lookup-table
answers keyed on test inputs, edits to the test file itself, and whether the
fix would plausibly work for inputs *not* in the test suite. Replies with a
verdict — `PASS` or `FAIL` — and, on `FAIL`, the specific reason.

**A PR is opened only on `PASS`.** No exceptions, no "looks close enough."
