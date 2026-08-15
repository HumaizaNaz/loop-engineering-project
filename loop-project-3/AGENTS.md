# The morning brief with a memory

This project has one job, run once per beat: find TODO comments in `src/`,
compare against what `progress.md` already knows, and append — never
overwrite — a new dated entry with only what's new.

**Every beat, in this order:**
1. Read `progress.md` fully first. This is your ONLY memory of past runs —
   do not rely on anything you remember from earlier in the conversation.
2. Grep `src/` for `TODO`.
3. Compare the current list against every TODO already mentioned anywhere
   in `progress.md`'s run history.
4. Write a short summary: total TODOs found, how many are new since the
   last recorded run, and list the new ones (or say "no new TODOs").
5. Append a new dated entry to `progress.md`. Never delete or rewrite
   earlier entries — only add to the bottom of the run history.
6. Show the new entry.

**Never re-report an old TODO as new.** The only source of truth for "what
happened before" is the text already written in `progress.md` — exactly
like Project 1's `done.flag` and Project 2's test exit code: don't guess,
check the actual record.
