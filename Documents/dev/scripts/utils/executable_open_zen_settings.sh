#!/bin/bash

# Load full user environment
export $(dbus-launch)

# Set DISPLAY and Wayland variables explicitly
export DISPLAY=:0
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-0

# Export DBUS_SESSION_BUS_ADDRESS from plasmashell process (adjust if needed)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $USER plasmashell)/environ | tr -d '\0' | cut -d= -f2-)

zen-browser about:preferences

/home/nino/Documents/dev/scripts/nav/focus_zen.sh
