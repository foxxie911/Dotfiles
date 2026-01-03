#!/bin/sh

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
full)
  maim "$FILE"
  ;;
select)
  maim -s "$FILE"
  ;;
window)
  maim -i "$(xdotool getactivewindow)" "$FILE"
  ;;
*)
  echo "Usage: $0 {full|select|window}"
  exit 1
  ;;
esac
