#!/bin/sh

feh --bg-scale ~/.config/backgrounds/nord.jpg
#setxkbmap us,ru -option 'grp:caps_toggle'
picom &
dwmblocks &

while true; do
  # Log stderror to a file
  dwm 2>~/.dwm.log
  # No error logging
  #dwm >/dev/null 2>&1
done
