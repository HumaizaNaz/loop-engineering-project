# Codified fix-loop engine

This repo has 3 independent candidate bugs under `candidates/`. The engine
(`run_fix_loop.sh`) handles worktree setup and test-based verification —
it has no memory between runs by design (see README's Run 2).

When drafting a fix for one candidate: work only inside your assigned
worktree, follow `.claude/skills/fix-loop/SKILL.md`, never edit the
candidate's `test_module.py`, and commit your fix on that candidate's own
`fix/<candidate>` branch — never on `main`.
