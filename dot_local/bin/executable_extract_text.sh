#!/usr/bin/env bash
set -u

notify() {
  command -v notify-send >/dev/null 2>&1 || return 0
  notify-send "$@"
}

need() {
  local missing=()
  local cmd
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
  done
  if ((${#missing[@]} > 0)); then
    printf 'Missing commands: %s\n' "${missing[*]}" >&2
    notify "OCR failed" "Missing commands: ${missing[*]}"
    exit 1
  fi
}

need slurp grim tesseract wl-copy

region=$(slurp) || exit 0

[[ -n "$region" ]] || exit 0

if text=$(grim -g "$region" - | tesseract stdin stdout -l eng 2>/dev/null); then
  if [[ -z "${text//[[:space:]]/}" ]]; then
    notify "OCR finished" "No text detected"
    exit 0
  fi
  printf '%s' "$text" | wl-copy
  notify "OCR copied" "Text copied to clipboard"
else
  printf 'OCR failed.\n' >&2
  notify "OCR failed" "Tesseract could not process the selection"
  exit 1
fi
