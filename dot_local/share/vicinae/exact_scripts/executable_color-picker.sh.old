#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Hypr Color Picker
# @vicinae.mode silent
# @vicinae.icon https://api.iconify.design/material-symbols/colorize-rounded.svg?color=%23ccd5f3
printf 'Pick a color\n'
exec </dev/null >/dev/null 2>&1
setsid -f bash -lc '
  sleep 0.2
  for cmd in ie-r notify-send; do
    command -v "$cmd" >/dev/null 2>&1 || {
      notify-send -u critical "Color Picker failed" "Missing command: $cmd"
      exit 1
    }
  done
  color="$(pkill -SIGUSR1 ie-r)" || exit 0
  [ -n "$color" ] || exit 0
  notify-send "Color Picker" "Copied $color to clipboard"
' </dev/null >/dev/null 2>&1
