#!/usr/bin/env sh

DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then
hyprctl dispatch dpms off eDP-1

else
hyprctl dispatch dpms on eDP-1 

fi
