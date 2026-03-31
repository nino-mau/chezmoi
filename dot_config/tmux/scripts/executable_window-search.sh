#!/usr/bin/env bash

set -euo pipefail

selection="$({
  tmux list-windows -a -F $'#{session_name}:#{window_index}\t#{window_name}\t#{pane_current_path}\t#{window_id}'
} | fzf \
  --prompt='window> ' \
  --delimiter=$'\t' \
  --with-nth=1,2,3 \
  --layout=reverse \
  --height=100%)"

[ -n "$selection" ] || exit 0

window_id="${selection##*$'\t'}"
tmux switch-client -t "$window_id"
