#!/bin/bash

MONITOR_URL="https://test.com/monitoring/test/api"
PROCESS_NAME="test"

is_process_running() {
  pgrep -f "$PROCESS_NAME" >/dev/null 2>&1
}

get_process_pid() {
  pgrep -f "$PROCESS_NAME"
}

is_server_reachable() {
  curl --fail --silent --location --head --request GET "$MONITOR_URL" --max-time 30 >/dev/null 2>&1
}

last_pid=$(get_process_pid)

while true; do
  if is_process_running; then
    current_pid=$(get_process_pid)

    if [[ "$current_pid" != "$last_pid" ]]; then
      echo "$(date) - test process restarted"
      last_pid="$current_pid"
    fi

    if !(is_server_reachable); then
      echo "$(date) - Service not available."

    fi
  fi

  sleep 60
done
