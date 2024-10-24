#!/usr/bin/env sh

DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then
    exit 1
else
    hyprlock -d &
    sleep 2
    systemctl suspend
fi
