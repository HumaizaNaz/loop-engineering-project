---
name: fix-loop
description: Steps for drafting a fix to a failing test in this repo, for the maker role in the Project 4 fix-loop.
---

# Fix loop — maker steps

1. Run `python -m pytest test/ -v` and read the **actual** failure output.
2. Open only the source file the failing test imports from (`src/inventory.py`).
   Do not touch anything under `test/`.
3. Understand *why* the function is wrong in general — not just for the one
   input the test happens to use. A fix that only works for the exact
   numbers in the test is not a fix, it's a trick.
4. Apply the smallest correct change to the source file.
5. Re-run `python -m pytest test/ -v` and confirm it actually passes.
6. Stop. Do not open a PR yourself — a separate reviewer decides that.
