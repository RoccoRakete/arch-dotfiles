#!/usr/bin/env sh

DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then
hyprctl dispatch dpms off eDP-1

# Zeilen, die hinzugefügt oder ersetzt werden sollen
LINE1="monitor   = HDMI-A-1, 2560x1440@75, 1280x720, 1"
LINE2="monitor   = eDP-1, disable"

# Ersetze die entsprechenden Zeilen in der Datei
sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE1"
sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE2"

else
hyprctl dispatch dpms on eDP-1 

# Zeilen, die hinzugefügt oder ersetzt werden sollen
LINE3="monitor   = HDMI-A-1, 2560x1440@75, 1280x720, 1"
LINE4="monitor   = eDP-1, disable"

# Ersetze die entsprechenden Zeilen in der Datei
sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE3"
sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE4"

fi
