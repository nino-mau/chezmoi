#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Screenshot
# @vicinae.mode silent
# @vicinae.icon https://api.iconify.design/material-symbols/screenshot-region-rounded.svg?color=%23ccd5f3
printf 'Select an area\n'
exec </dev/null >/dev/null 2>&1
setsid -f bash -lc '
  sleep 0.2
  dir="$HOME/Pictures/Screenshots"
  timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
  file="$dir/$timestamp.png"
  mkdir -p "$dir"
  region="$(slurp)" || exit 0
  [ -n "$region" ] || exit 0
  if grim -g "$region" "$file"; then
    notify-send "Screenshot saved" "$file"
  else
    notify-send -u critical "Screenshot failed" "grim could not capture the selected area"
    exit 1
  fi
' </dev/null >/dev/null 2>&1
