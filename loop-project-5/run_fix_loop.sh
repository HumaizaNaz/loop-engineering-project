#!/usr/bin/env bash
# run_fix_loop.sh — the codified "body" of the Project 4 fix-loop, fanned out
# over N candidates. This is the ENGINE: it does the deterministic parts
# (worktree creation, running tests as the checker) with no AI involved.
# The actual fix-drafting is a separate step dispatched by the runtime
# (parallel, isolated agents) between `setup` and `verify`.
#
# Usage:
#   ./run_fix_loop.sh setup     create/reset a worktree+branch per candidate
#   ./run_fix_loop.sh verify    run each candidate's tests in its worktree,
#                                print a PASS/FAIL verdict per candidate —
#                                the test command's exit code IS the checker
set -uo pipefail

CANDIDATES=(candidate-a candidate-b candidate-c)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

setup() {
  for c in "${CANDIDATES[@]}"; do
    branch="fix/$c"
    worktree_dir="$REPO_ROOT/../loop-project-5-worktree-$c"
    if git -C "$REPO_ROOT" show-ref --verify --quiet "refs/heads/$branch"; then
      echo "[$c] branch $branch already exists — not touching it (run 'reset' first for a clean run)"
      continue
    fi
    echo "[$c] creating worktree at $worktree_dir on branch $branch"
    git -C "$REPO_ROOT" worktree add -b "$branch" "$worktree_dir" main >/dev/null
  done
}

verify() {
  overall=0
  for c in "${CANDIDATES[@]}"; do
    worktree_dir="$REPO_ROOT/../loop-project-5-worktree-$c"
    echo "=== $c ==="
    if [ ! -d "$worktree_dir" ]; then
      echo "[$c] no worktree found — run setup first"
      overall=1
      continue
    fi
    if (cd "$worktree_dir/candidates/$c" && python -m pytest test_module.py -q); then
      echo "[$c] VERDICT: PASS — checker exit code 0, opening PR"
    else
      code=$?
      echo "[$c] VERDICT: FAIL — checker exit code $code, not opening PR"
      overall=1
    fi
  done
  return $overall
}

reset_all() {
  for c in "${CANDIDATES[@]}"; do
    branch="fix/$c"
    worktree_dir="$REPO_ROOT/../loop-project-5-worktree-$c"
    git -C "$REPO_ROOT" worktree remove --force "$worktree_dir" 2>/dev/null || true
    git -C "$REPO_ROOT" branch -D "$branch" 2>/dev/null || true
  done
  echo "all candidate worktrees and branches removed"
}

case "${1:-}" in
  setup) setup ;;
  verify) verify ;;
  reset) reset_all ;;
  *) echo "Usage: $0 {setup|verify|reset}"; exit 1 ;;
esac
