---
name: fix-loop
description: Steps for drafting a fix to one issue's failing test in this repo, in an isolated worktree.
---

1. Run the issue's test file (e.g. `python -m pytest test_temperature_convert.py -v`) and read the real failure.
2. Edit only the source file (e.g. `temperature_convert.py`). Never touch the test file.
3. Fix the real logic bug — not a hardcoded answer for the exact test inputs.
4. Re-run the test yourself and confirm it actually passes; show the real output.
5. Show the diff and hand it to @reviewer for a PASS/FAIL verdict before considering this done.
