#!/bin/bash

# Define options with icons
# Using the format: Icon Name
SELECTION=$(echo -e "󰐥 Shutdown\n󰑐 Reboot\n󰍃 Logout\n󰌾 Lock" | fuzzel -d -p "󰐥 Power: " -w 20 -l 4)

case "$SELECTION" in
*Shutdown) systemctl poweroff ;;
*Reboot) systemctl reboot ;;
*Logout) swaymsg exit ;;
*Lock) ~/.config/sway/lock.sh ;;
esac
