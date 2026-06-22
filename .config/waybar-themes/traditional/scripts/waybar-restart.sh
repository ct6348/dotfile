#!/bin/bash

# Kill any running Waybar processes
pkill -x waybar

# Wait briefly to ensure Waybar is fully terminated
sleep 1

# Start Waybar again
nohup waybar -c ~/.config/waybar2/config.jsonc -s ~/.config/waybar2/style.css >/dev/null 2>&1 &
