#!/usr/bin/env sh

DOCKED=$(loginctl show-seat seat0 -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then
    exit 1
else
    gtklock -d &
    sleep 2
    systemctl suspend
fi
