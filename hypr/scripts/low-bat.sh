#!/usr/bin/env sh

# set battery limit
LIMIT=3

while true; do
  # check battery level
  BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

  # check if the device is discharging
  CHARGING_STATUS=$(acpi -b | grep -o 'Discharging')

  # execute if battery is discharging and level is below the limit
  if [ "$BATTERY_LEVEL" -le "$LIMIT" ] && [ "$CHARGING_STATUS" = "Discharging" ]; then
    playerctl pause
    hyprlock -q &
    sleep 1
    systemctl suspend

    break
  fi

  # Wait until next check
  sleep 60
done
