# Practice Project 5 — Codify the Body

**Loop Engineering — the dynamic-workflows interlude, Concept 8 (worktree), Concept 11 (maker-checker).**

Project 4's fix-loop, done by hand for one bug, turned into a single
reusable **engine**: `run_fix_loop.sh`. It fans out over 3 candidate bugs
in parallel, isolated worktrees, and uses each candidate's test exit code
as the checker — no step-by-step prompting needed once it starts.

## The 3 candidates

| Candidate | Bug | File |
|---|---|---|
| `candidate-a` | `is_even` — inverted condition (`== 1` instead of `== 0`) | `candidates/candidate-a/module.py` |
| `candidate-b` | `average` — off-by-one divisor (`len(numbers) + 1`) | `candidates/candidate-b/module.py` |
| `candidate-c` | `reverse_words` — reverses characters, not word order | `candidates/candidate-c/module.py` |

## The engine: `run_fix_loop.sh`

```bash
./run_fix_loop.sh setup    # create/reset a worktree + branch per candidate
./run_fix_loop.sh verify   # run each candidate's tests, print PASS/FAIL —
                            # the test command's exit code IS the checker
./run_fix_loop.sh reset    # remove all candidate worktrees and branches
```

`setup` and `verify` are pure shell — no AI involved, fully deterministic.
The actual fix-drafting (the "maker") is a separate step: three fresh,
isolated agents dispatched in parallel, one per candidate worktree, each
following `.claude/skills/fix-loop/SKILL.md`. That combination — script
for the mechanical parts, dispatched agents for the drafting — is what
"one command runs the whole draft-and-review body" means here.

## Run 1 — full cycle

1. `./run_fix_loop.sh setup` → 3 worktrees created, branches `fix/candidate-a/b/c`
2. 3 parallel, isolated agents dispatched, one per worktree — each read
   the real failing test, fixed the actual logic bug (not a hardcoded
   answer), reran the test, committed on its own branch
3. `./run_fix_loop.sh verify` → **all 3 PASS**, exit code 0

## Run 2 — proving it's an engine, not a loop

To prove the interlude's warning — that a codified workflow remembers
nothing between runs — this repo was reset and rerun **without repeating
the maker step**:

```bash
./run_fix_loop.sh reset     # deletes all 3 fix/* branches + worktrees
./run_fix_loop.sh setup     # fresh worktrees, checked out from `main`
./run_fix_loop.sh verify    # no maker step run this time
```

**Result: all 3 candidates FAILED again**, with the exact same failures as
before any fix was drafted. This is not a bug — this is the whole point.
The fixes only ever existed on the `fix/candidate-*` branches. `main` was
never updated. A fresh worktree checked out from `main` has zero knowledge
that candidate-a, b, and c were ever fixed in Run 1. The engine has no
memory of its own history — every run starts from the same baseline.

## Done when (the course's checklist)

- [x] One command (`run_fix_loop.sh` + the runtime's parallel dispatch)
      runs the whole draft-and-review body — 3 candidates, isolated
      checkouts, a verdict for each — with no step-by-step prompting once
      started
- [x] Proved on this machine that a fresh run remembers nothing: Run 2's
      `verify` failed identically to Run 1's starting state, because
      resetting removed the only place the fix lived (the branch)

## What this engine would need to become a real loop

Two things, per Concept 6 and Concept 12:

1. **A heartbeat** — something that fires `run_fix_loop.sh` on its own
   (a schedule, or a GitHub event), instead of a person typing the command.
2. **A spine** — a `progress.md` (or similar) that each run reads *before*
   doing anything and writes to *after* — recording which candidates were
   already fixed and merged, so a new run only processes what's actually
   new, instead of re-discovering (or re-losing) the same 3 candidates
   every single time.

Without both, `run_fix_loop.sh` is a well-organized **engine**: powerful,
reusable, one command — but it is not a loop. Naming this gap is the
actual lesson of Project 5.
