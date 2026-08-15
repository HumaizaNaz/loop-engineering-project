# PR: fix: subtract discount instead of adding it

**Branch:** `fix/good-discount` (drafted in an isolated worktree, not on `main`)
**Status:** OPEN — reviewer verdict **PASS**

## Diff

```diff
 def apply_discount(price, discount_percent):
     """Return the price after applying a percent discount."""
-    # BUG: adds the discount instead of subtracting it
-    return price + (price * discount_percent / 100)
+    return price - (price * discount_percent / 100)
```

## Test result (checker, ran independently)

```
test/test_inventory.py::test_discount_reduces_price PASSED
test/test_inventory.py::test_zero_discount_is_unchanged PASSED
test/test_inventory.py::test_discount_scales_with_price PASSED
3 passed in 0.06s
```

## Reviewer verdict: PASS

- The fix corrects the general formula (`+` → `-`), it is not special-cased
  to any one input.
- `test/` was not touched.
- All three tests pass, covering three different price/discount pairs, not
  just the one the bug happened to break.

Approved to merge.

*(This repo has no GitHub remote, so "opening a PR" here means: the fix
lives on its own branch, unmerged into `main`, with this file as the
review record — exactly what a real PR is, minus the GitHub UI. Run
`gh pr create` here instead if you connect a real GitHub remote.)*

## Independent verification (real `.claude/agents/reviewer.md` subagent, fresh context)

Dispatched as a separate agent with zero knowledge of this conversation —
given only the worktree path and told to check everything itself.

**Verdict: PASS**
- Ran `git diff` and `pytest` itself; confirmed 3 passed, test file untouched.
- Independently tried inputs outside the test suite (300/10%, 50/33%,
  1000/100%) — all mathematically correct, confirming the fix generalizes.
