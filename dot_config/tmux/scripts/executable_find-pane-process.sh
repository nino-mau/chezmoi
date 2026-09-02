#!/usr/bin/env bash

set -euo pipefail

if (( $# != 1 )); then
  printf 'usage: %s <pane-tty>\n' "${0##*/}" >&2
  exit 64
fi

tty=${1#/dev/}
command=$(ps -o comm= -t "$tty" | tail -n 1)
command=${command##*/}

printf '%s\n' "${command#-}"
