#!/usr/bin/env sh

DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then
hyprctl dispatch dpms off eDP-1

# Zeilen, die hinzugefügt oder ersetzt werden sollen
LINE1="monitor   = HDMI-A-1, 2560x1440@75, 1280x720, 1"
LINE2="monitor   = eDP-1, disable"

# Ersetze die entsprechenden Zeilen in der Datei
sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE1" "$CONFIG_FILE"
sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE2" "$CONFIG_FILE"

else
hyprctl dispatch dpms on eDP-1 

# Zeilen, die hinzugefügt oder ersetzt werden sollen
LINE1="monitor   = HDMI-A-1, 2560x1440@75, 1280x720, 1"
LINE2="monitor   = eDP-1, disable"

# Ersetze die entsprechenden Zeilen in der Datei
sed -i "/^monitor\s*=\s*HDMI-A-1/c\\$LINE1" "$CONFIG_FILE"
sed -i "/^monitor\s*=\s*eDP-1/c\\$LINE2" "$CONFIG_FILE"

fi
