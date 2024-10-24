#!/usr/bin/env bash

outputs=(HDMI-A-1 eDP-1)

for o in ${outputs[@]}; do
    grim -o $o /tmp/$o.png
    magick /tmp/$o.png -blur 0x8 -brightness-contrast -7x0 /tmp/$o.png &
done

wait < <(jobs -p)

gtklock -d --monitor-priority HDMI-A-1
