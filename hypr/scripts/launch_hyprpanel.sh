#!/usr/bin/env bash

pkill gjs

# Launch hyprpanel
echo "---" | tee -a /tmp/hyprpanel/hyprpanel.log
hyprpanel 2>&1 | tee -a /tmp/hyprpanel/hyprpanel.log &
disown

echo "shell launched..."
