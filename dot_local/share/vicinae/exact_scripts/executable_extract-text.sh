#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Extract Text (OCR)
# @vicinae.mode silent
# @vicinae.icon https://api.iconify.design/material-symbols/document-scanner-rounded.svg?color=%23ccd5f3
printf 'Select an area to extract text\n'
exec </dev/null >/dev/null 2>&1
setsid -f bash -lc '
  sleep 0.2
  for cmd in slurp grim tesseract wl-copy; do
    command -v "$cmd" >/dev/null 2>&1 || {
      notify-send -u critical "OCR failed" "Missing command: $cmd"
      exit 1
    }
  done
  region="$(slurp)" || exit 0
  [ -n "$region" ] || exit 0
  if text=$(grim -g "$region" - | tesseract stdin stdout -l eng 2>/dev/null); then
    if [ -z "${text//[[:space:]]/}" ]; then
      notify-send "OCR finished" "No text detected"
      exit 0
    fi
    printf "%s" "$text" | wl-copy
    notify-send "OCR copied" "Text copied to clipboard"
  else
    notify-send -u critical "OCR failed" "Tesseract could not process the selection"
    exit 1
  fi
' </dev/null >/dev/null 2>&1
