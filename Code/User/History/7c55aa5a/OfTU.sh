#!/usr/bin/env sh

DOCKED=$(loginctl show-seat -p Docked | cut -d= -f2)

if [ "$DOCKED" = "yes" ]; then

else

fi
