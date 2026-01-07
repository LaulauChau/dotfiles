#!/bin/bash
# Use ddcutil to get/set brightness. VCP code 10 is brightness.
STATE_FILE="/tmp/waybar_brightness"
STEP=5

get_brightness() {
  if [ ! -f "$STATE_FILE" ]; then
    # Initialize if file doesn't exist
    val=$(ddcutil getvcp 10 -t | awk '{print $4}' || echo "50")
    echo "$val" >"$STATE_FILE"
  fi
  cat "$STATE_FILE"
}

set_brightness() {
  echo "$1" >"$STATE_FILE"
  # Run ddcutil in background to avoid blocking waybar
  (ddcutil setvcp 10 "$1" &)
  pkill -RTMIN+9 waybar
}

curr=$(get_brightness)

case $1 in
up)
  new=$((curr + STEP))
  [ $new -gt 100 ] && new=100
  set_brightness $new
  ;;
down)
  new=$((curr - STEP))
  [ $new -lt 0 ] && new=0
  set_brightness $new
  ;;
get)
  echo "$curr"
  ;;
esac
