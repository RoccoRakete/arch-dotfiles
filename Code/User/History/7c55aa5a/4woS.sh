#!/usr/bin/env sh

# Überprüfen, ob das Gerät angedockt ist
DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

# Hyprland monitor.conf path
CONFIG_FILE="$HOME/.config/hypr/monitors.conf"

if [ "$DOCKED" = "yes" ]; then
    hyprctl dispatch dpms off eDP-1

    # Define lines for docked state
    LINE1="monitor   = HDMI-A-1 , 2560x1440@75, 1280x720, 1"
    LINE2="monitor   = eDP-1    , disable"

    # replace lines in monitors.conf
    sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE1" "$CONFIG_FILE"
    sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE2" "$CONFIG_FILE"

else
    hyprctl dispatch dpms on eDP-1

    # Define lines for undocked state
    LINE3="monitor   = HDMI-A-1 , 2560x1440@75, 1280x720, 1"
    LINE4="monitor   = eDP-1    , preferred, 0x0, 1"

    # replace lines in monitors.conf
    sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE3" "$CONFIG_FILE"
    sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE4" "$CONFIG_FILE"
fi