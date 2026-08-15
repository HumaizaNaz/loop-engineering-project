#!/usr/bin/env bash
# long_task.sh — simulates a long-running job (a deploy, a build, a migration).
#
# It sleeps for SECONDS (default 180 = 3 minutes), then writes done.flag
# with a timestamp and a fake result. That flag file is the ONLY thing
# the loop is allowed to trust — never a guess, never "it's probably done".
#
# Usage:
#   ./long_task.sh          # runs for 3 minutes
#   ./long_task.sh 60       # runs for 60 seconds (faster to test with)

SECONDS_TO_RUN="${1:-180}"

echo "[long_task] started at $(date -u +%H:%M:%S) UTC — will finish in ${SECONDS_TO_RUN}s"

# Make sure we start clean: remove any old flag from a previous run.
rm -f done.flag

sleep "$SECONDS_TO_RUN"

{
  echo "status: finished"
  echo "finished_at_utc: $(date -u +%H:%M:%S)"
  echo "ran_for_seconds: ${SECONDS_TO_RUN}"
} > done.flag

echo "[long_task] finished at $(date -u +%H:%M:%S) UTC — wrote done.flag"
