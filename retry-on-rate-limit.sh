#!/usr/bin/env bash
# Runs a command and runs it again when the registry rate-limits it ("toomanyrequests").
# Any other failure is returned straight away.
set -o pipefail

attempts=${RETRY_ATTEMPTS:-4}

for ((attempt = 1; ; attempt++)); do
  log=$(mktemp)
  "$@" 2>&1 | tee "$log"
  status=${PIPESTATUS[0]}
  rate_limited=$(grep -c toomanyrequests "$log")
  rm -f "$log"

  if [ "$status" -eq 0 ] || [ "$rate_limited" -eq 0 ] || [ "$attempt" -ge "$attempts" ]; then
    exit "$status"
  fi

  delay=$((30 * attempt))
  echo "Rate limited by the registry, retrying in ${delay}s (attempt $((attempt + 1)) of ${attempts})..." >&2
  sleep "$delay"
done
