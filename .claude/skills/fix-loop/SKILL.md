---
name: fix-loop
description: Steps for drafting a fix to one candidate's failing test in this repo.
---

1. Run `python -m pytest candidates/<candidate>/test_module.py -v` and read
   the real failure output.
2. Edit only `candidates/<candidate>/module.py`. Never touch the test file.
3. Fix the real logic bug, not a hardcoded answer for the exact test inputs.
4. Re-run the test and confirm it actually passes.
5. Report PASS or FAIL, with your reasoning, in one short paragraph.
