#!/usr/bin/env bash

set -euo pipefail

config=""
pipeline_pid=""
status_pid=""
status_file=""

cleanup() {
  trap - TERM INT EXIT
  if [[ -n "$pipeline_pid" ]]; then
    kill "$pipeline_pid" 2>/dev/null || true
  fi
  if [[ -n "$status_pid" ]]; then
    kill "$status_pid" 2>/dev/null || true
  fi
  pkill -TERM -P "$$" 2>/dev/null || true
  if [[ -n "$config" ]]; then
    rm -f "$config"
  fi
  if [[ -n "$status_file" ]]; then
    rm -f "$status_file"
  fi
}

trap cleanup TERM INT EXIT

if ! command -v cava >/dev/null 2>&1; then
  printf '{"text":"","class":"silent"}\n'
  while true; do
    sleep 3600
  done
fi

config="$(mktemp --tmpdir waybar-cava.XXXXXX)"
status_file="$(mktemp --tmpdir waybar-player.XXXXXX)"

while true; do
  case "$(playerctl status 2>/dev/null || true)" in
    Playing)
      printf ' playing\n' >"$status_file"
      ;;
    Paused)
      printf ' paused\n' >"$status_file"
      ;;
    *)
      printf ' stopped\n' >"$status_file"
      ;;
  esac
  sleep 0.5
done &
status_pid="$!"

cat >"$config" <<'EOF'
[general]
framerate = 30
bars = 14
autosens = 1
sleep_timer = 2

[input]
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 32
frame_delimiter = 10
channels = mono
mono_option = average

[smoothing]
monstercat = 0
waves = 0
noise_reduction = 80
EOF

cava -p "$config" 2>/dev/null | awk -v status_file="$status_file" '
BEGIN {
  split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", bars, " ")
  idle = "▁▁▁▁▁▁▁▁▁▁▁▁▁▁"
}
{
  icon = ""
  player_class = "stopped"
  if ((getline status_line < status_file) > 0) {
    split(status_line, status, " ")
    if (status[1] != "") icon = status[1]
    if (status[2] != "") player_class = status[2]
  }
  close(status_file)

  out = ""
  active = 0
  for (i = 1; i <= NF; i++) {
    if (i == int(NF / 2) + 1) {
      out = out " " icon " "
    }
    level = int($i) + 1
    if (level > 1) active = 1
    if (level < 1) level = 1
    if (level > 8) level = 8
    out = out bars[level]
  }
  if (out == "") out = substr(idle, 1, 7) " " icon " " substr(idle, 8)
  class = player_class
  if (!active && player_class == "playing") class = "silent"
  printf "{\"text\":\"%s\",\"class\":\"%s\"}\n", out, class
  fflush()
}
' &

pipeline_pid="$!"
wait "$pipeline_pid"
