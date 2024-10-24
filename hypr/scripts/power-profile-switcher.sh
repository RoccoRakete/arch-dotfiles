#!/usr/bin/env sh

# get current profile
current_profile=$(powerprofilesctl get)

# set app name for e.g. icon
app_name="org.gnome.Settings"

# set colors
green="#8ff0a4"
blue="#78aeed"
red="#ff7b63"

# set texts
header="Power Profile Status"
msg_prefix="Power Profile:"

# set timeout in ms
timeout="5000"

# change profiles / send notification
case "$current_profile" in
"power-saver")
    powerprofilesctl set balanced
    notify-send -t $timeout --app-name=$app_name "  $header" "  $msg_prefix<span foreground='$blue'>\n  $(powerprofilesctl get)</span>"
    ;;
"balanced")
    powerprofilesctl set performance
    notify-send -t $timeout --app-name=$app_name "  $header" "  $msg_prefix<span foreground='$red'>\n  $(powerprofilesctl get)</span>"
    ;;
"performance")
    powerprofilesctl set power-saver
    notify-send -t $timeout --app-name=$app_name "  $header" "  $msg_prefix<span foreground='$green'>\n  $(powerprofilesctl get)</span>"
    ;;
*)
    echo "Unknown Profile: $current_profile"
    ;;
esac
