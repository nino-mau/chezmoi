#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
VARIANTS_DIR="$HOME/.config/waybar/variants"

WAYBAR_PID="$(pgrep -o -x waybar || true)"
if [ -z "$WAYBAR_PID" ]; then
  printf '%s\n' 'waybar is not running' >&2
  exit 1
fi

CURRENT_VARIANT="$(
  while IFS= read -r arg; do
    case "$arg" in
      "$VARIANTS_DIR"/*/config.jsonc|"$VARIANTS_DIR"/*/style.css)
        arg="${arg#"$VARIANTS_DIR"/}"
        printf '%s\n' "${arg%%/*}"
        break
        ;;
    esac
  done < <(tr '\0' '\n' < "/proc/$WAYBAR_PID/cmdline")
)"

if [ -z "$CURRENT_VARIANT" ]; then
  printf '%s\n' 'could not detect the current waybar variant' >&2
  exit 1
fi

exec "$SCRIPT_DIR/launch.sh" "$CURRENT_VARIANT"
