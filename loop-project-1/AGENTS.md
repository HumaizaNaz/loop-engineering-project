# Watching a long task finish

This project has one job: watch `long_task.sh` and tell the person the moment
it finishes — no sooner, no later.

**How to check if the task is finished — never guess, always check:**

    test -f done.flag && cat done.flag

- If `done.flag` does NOT exist yet: the task is still running. Say one short
  line ("still running, checked at <time>") and wait for the next beat. Do
  not re-run `long_task.sh` — it is already running in another terminal.
- If `done.flag` DOES exist: read it, report what it says, say the task is
  finished, and stop the loop. Do not keep checking after this.

Never say "it's probably done by now" or estimate based on elapsed time.
The flag file is the only source of truth, exactly like the ISS project's
rule: a guess that looks right is worse than an honest "not yet."
