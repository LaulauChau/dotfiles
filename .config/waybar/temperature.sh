#!/bin/bash
# Toggle and status for wlsunset (Night Light)
# Temperature values: Day 6500K, Night 4000K
PID_FILE="/tmp/wlsunset.pid"
LAT="48.8" # Set your latitude (Paris example)
LON="2.3"  # Set your longitude

toggle() {
  if pgrep -x "wlsunset" >/dev/null; then
    pkill -x "wlsunset"
  else
    wlsunset -l "$LAT" -L "$LON" -t 4000 -T 6500 &
  fi
  pkill -RTMIN+8 waybar
}

get_status() {
  if pgrep -x "wlsunset" >/dev/null; then
    echo '{"text": "4000K", "class": "on", "percentage": 100}'
  else
    echo '{"text": "Off", "class": "off", "percentage": 0}'
  fi
}

case $1 in
toggle) toggle ;;
*) get_status ;;
esac
