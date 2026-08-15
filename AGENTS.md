# Fixing calculator.py until tests pass

This project has one job: make `python -m pytest` exit successfully by fixing
`calculator.py` — nothing else.

**How to check if you are done — never guess, always run the command:**

    python -m pytest

- If it exits non-zero (any test FAILED): you are not done. Read the actual
  failure output, fix the specific bug it points to in `calculator.py`, then
  run `python -m pytest` again. Do not touch `test_calculator.py` — the tests
  are correct on purpose; the bug is always in `calculator.py`.
- If it exits zero (all tests PASSED): you are done. Say so once and stop.

**Never say "this looks correct" or "should pass now" without running the
command.** The test runner's exit code is the only source of truth, exactly
like Project 1's `done.flag` rule — a guess that looks right is worse than an
honest "still failing."

**Attempt budget:** you get a maximum of 6 run-fix-run cycles. If you reach 6
attempts and tests still fail, stop and report which tests are still failing
and why — do not claim success just because you hit the limit.
