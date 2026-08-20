# Fix: remove duplicate/contradictory Status lines in TASKS.md

**Branch:** `fix/docs-sync-2026-08-20`
**Base:** `main` @ `d0a7696`

## Bug

`TASKS.md` had a leftover stray `**Status:** not started.` line directly under
the real, correct status line in two project sections:

- **Project 6** — the real line (`**Status:** PARTIAL — honest stopping point,
  fully documented in \`loop-project-6/README.md\`.`) was immediately followed
  by a contradictory `**Status:** not started.` line.
- **Project 7** — the real line (`**Status:** DONE — all three "done when"
  conditions met for real.`) was immediately followed by the same stray
  `**Status:** not started.` line.

Both projects are actually finished (PARTIAL and DONE respectively), so the
duplicate "not started" lines were stale leftovers contradicting the real
status directly above them — likely an artifact of an earlier template/copy
step that was never cleaned up.

## Fix

Removed only the two stray `**Status:** not started.` lines, one in the
Project 6 section and one in the Project 7 section. No other content,
wording, or sections were changed.

## Diff

```diff
diff --git a/TASKS.md b/TASKS.md
index b252fb3..3cef16c 100644
--- a/TASKS.md
+++ b/TASKS.md
@@ -90,7 +90,6 @@ This is one beat of a scheduled loop. Do these steps in order:
 **What was done instead:** a real PR (**#1**, opened via GitHub API) with the real bug, reviewed for real (diff read, bug reasoned about) and the review **posted as a real GitHub PR comment** — https://github.com/HumaizaNaz/loop-engineering-project/pull/1 — just triggered by hand instead of by a webhook.
 **Done when:** review-flags-the-bug ✅ done for real. Automatic zero-prompt firing ❌ blocked (documented, reproducible if account restrictions change).
 **Status:** PARTIAL — honest stopping point, fully documented in `loop-project-6/README.md`.
-**Status:** not started.
 
 ---
 
@@ -102,7 +101,6 @@ This is one beat of a scheduled loop. Do these steps in order:
 **Result:** did NOT fail silently — `beat.log` got `FAILED | src_incoming: No such file or directory | NEEDS HUMAN: ...`, and `progress.md`'s Beat 4 entry recorded the same in full.
 **Diagnosis:** read only `beat.log` + `progress.md` (no replay) → correctly identified what failed (`src_incoming/` missing) and exactly when (`2026-08-17T00:12:43Z`).
 **Status:** DONE — all three "done when" conditions met for real.
-**Status:** not started.
 
 ---
```

## Notes

This is a local-only draft PR description prepared by the docs-freshness loop
(maker role, beat 2). Nothing was pushed and no real GitHub PR was opened.
The commit exists only on the local branch `fix/docs-sync-2026-08-20`
(created via `git worktree add -b fix/docs-sync-2026-08-20 ../loop-project-8-worktree-fix`).
`main` was not touched.
