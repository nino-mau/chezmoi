#!/usr/bin/env bash

set -u

output="$(hyprctl -j monitors | jq -r '.[] | select(.focused==true).name')"
timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
file="$HOME/Pictures/Screenshots/$timestamp.png"

if grim -o "$output" "$file"; then
  notify-send "Screenshot saved" "$file"
else
  notify-send -u critical "Screenshot failed" "grim could not capture the focused monitor"
  exit 1
fi
