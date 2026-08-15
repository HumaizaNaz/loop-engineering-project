# Practice Project 4 — A Fix Loop With a Real Checker

**Loop Engineering, Concept 8 — worktree, Concept 9 — skill, Concept 11 — maker-checker.**

An implementer (maker) drafts a fix to a real bug **in its own worktree**,
following a written skill. A separate reviewer (checker) reads the actual
diff — not just the test exit code — and replies `PASS` or `FAIL`. A PR is
opened only on `PASS`.

## The bug

`src/inventory.py` — `apply_discount` **adds** the discount instead of
subtracting it. `test/test_inventory.py` has 3 tests over different
price/discount pairs.

## Setup (already done in this repo)

```bash
cd loop-project-4
git add -A
git commit -m "throwaway project 4 setup"
```

## Run it — the maker-checker cycle with worktrees

**1. Create an isolated worktree for the fix** (never edit `main` directly):

```bash
git worktree add -b fix/<name> ../loop-project-4-worktree-<name> main
```

**2. Maker:** in that worktree, `claude` → follow the `fix-loop` skill
(`.claude/skills/fix-loop/SKILL.md`) — run the tests, read the real
failure, fix `src/inventory.py` only, re-run tests, stop.

**3. Checker:** from the main repo, read the actual diff:

```bash
git diff main fix/<name> -- src/ test/
```

Reject anything that: touches `test/`, hardcodes/looks up the specific
test inputs instead of fixing the general formula, or you can't verify
works on an input the tests never tried.

**4. On `PASS`:** write a PR record under `pr/` (this repo has no GitHub
remote, so "opening a PR" means a markdown file with the diff + verdict,
living on an unmerged branch — the same shape as a real PR, minus the
GitHub UI. With a real remote, use `gh pr create` instead).

**On `FAIL`:** write the rejection under `pr/` with the specific reason,
and do not merge.

## What already happened in this repo (demo run)

- **`fix/good-discount`** — changed `+` to `-` (a real, general fix).
  Checker verdict: `PASS` (see `pr/fix-good-discount.md`). All 3 tests
  pass, and it wasn't hardcoded to any specific input.
- **`fix/bad-discount`** — a deliberately planted bad fix: a lookup table
  hardcoding the 3 exact test inputs, falling back to the *original buggy
  formula* for anything else. All 3 tests still passed. Checker verdict:
  `FAIL` (see `pr/fix-bad-discount-REJECTED.md`) — caught by reading the
  diff, then confirmed by hand: `apply_discount(300, 10)` returns `330`
  instead of `270`, proving the bug was never actually fixed, just hidden
  from the test suite.

## Done when (the course's checklist)

- [x] A genuinely good fix gets `PASS` and a PR (`fix/good-discount`)
- [x] A deliberately bad fix gets `FAIL`, with reasons (`fix/bad-discount`)
- [x] The reviewer caught the bad fix by reading the diff, not by trusting
      the green test run

If the reviewer had approved the bad fix too, the checker would be too
soft — "a checker that approves everything is no checker." That's the
actual lesson of this project.

## The concept underneath

Project 2's maker-checker used a command's exit code as the sole judge —
good enough when the only way to "cheat" is to not actually fix the bug.
Here the maker can cheat *and* still make the command exit 0, by gaming
the test inputs instead of the logic. So the checker has to be smarter
than "did it pass": it has to read the diff like a human reviewer would.
That's **Concept 11** taken further, plus **Concept 8** (worktree) for
isolating each attempt so a bad draft never touches `main`, plus
**Concept 9** (a written skill) so the maker's steps are consistent and
repeatable instead of reinvented each time.
