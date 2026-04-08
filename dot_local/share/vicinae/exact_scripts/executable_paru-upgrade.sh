#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Upgrade
# @vicinae.mode silent
# @vicinae.icon https://api.iconify.design/material-symbols/upgrade.svg?color=%23ccd5f3
notify() {
  command -v notify-send >/dev/null 2>&1 && notify-send "$@"
}

for cmd in ghostty paru; do
  command -v "$cmd" >/dev/null 2>&1 || {
    notify -u critical "Upgrade failed" "Missing command: $cmd"
    exit 1
  }
done

exec </dev/null >/dev/null 2>&1
setsid -f ghostty --gtk-single-instance=false -e bash -lc 'paru -Syu; status=$?; printf "\nparu exited with status %s\n" "$status"; read -rp "Press Enter to close..." _' </dev/null >/dev/null 2>&1
