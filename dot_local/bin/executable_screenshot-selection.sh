#!/usr/bin/env bash

set -eu

dir="$HOME/Pictures/screenshot"
timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
file="$dir/$timestamp.png"

mkdir -p "$dir"

region="$(slurp)"

if [ -z "$region" ]; then
  exit 1
fi

if grim -g "$region" "$file"; then
  notify-send "Screenshot saved" "$file"
else
  notify-send -u critical "Screenshot failed" "grim could not capture the selected area"
  exit 1
fi
