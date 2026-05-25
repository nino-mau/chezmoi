#!/usr/bin/env bash

VARIANT="${1:-}"

case "$VARIANT" in
  bar|niri-bar|pill)
    CONFIG_DIR="$HOME/.config/waybar/variants/$VARIANT"
    ;;
  *)
    printf '%s\n' "Variant doesn't exist, use: bar, niri-bar, pill" >&2
    exit 1
    ;;
esac

pkill -x waybar 2>/dev/null || true
while pgrep -x waybar >/dev/null; do
  sleep 0.1
done

exec waybar -c "$CONFIG_DIR/config.jsonc" -s "$CONFIG_DIR/style.css"
