#!/usr/bin/env bash
#
# reminder.sh — Simple desktop reminder using notify-send
#

set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "$0")"

# ---------- Functions ----------

usage() {
  cat <<EOF
Usage:
  $SCRIPT_NAME <time> <message>

Time formats:
  <seconds>        e.g. 30
  <minutes>m       e.g. 10m

Examples:
  $SCRIPT_NAME 30 "Stand up"
  $SCRIPT_NAME 10m "Take a break"
EOF
}

error() {
  echo "Error: $*" >&2
  exit 1
}

cleanup() {
  echo "Cancelled."
  exit 130
}

# ---------- Signal handling ----------

trap cleanup INT TERM

# ---------- Dependency check ----------

command -v notify-send >/dev/null 2>&1 ||
  error "'notify-send' not found. Please install libnotify."

# ---------- Argument parsing ----------

[[ $# -lt 2 ]] && {
  usage
  exit 1
}

TIME_INPUT="$1"
shift
MESSAGE="$*"

# ---------- Time conversion ----------

if [[ "$TIME_INPUT" =~ ^[0-9]+m$ ]]; then
  MINUTES="${TIME_INPUT%m}"
  TIME_SECONDS=$((MINUTES * 60))
elif [[ "$TIME_INPUT" =~ ^[0-9]+$ ]]; then
  TIME_SECONDS="$TIME_INPUT"
else
  error "Invalid time format. Use seconds (30) or minutes (10m)."
fi

((TIME_SECONDS > 0)) || error "Time must be greater than zero."

# ---------- Wait ----------

sleep "$TIME_SECONDS"

# ---------- Notify ----------

notify-send \
  --app-name="Reminder" \
  --urgency=normal \
  "Reminder" \
  "$MESSAGE"
