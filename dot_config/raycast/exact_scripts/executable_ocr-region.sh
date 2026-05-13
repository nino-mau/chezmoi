#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Extract Text OCR
# @raycast.mode silent
# @raycast.icon /Users/nino/.config/raycast/scripts/assets/ocr_script_icon.png

tmp=$(mktemp /tmp/ocr_XXXXXX.png)
/usr/sbin/screencapture -i "$tmp" || {
  rm -f "$tmp"
  exit 0
}

if [ ! -s "$tmp" ]; then
  rm -f "$tmp"
  echo "Error: screenshot empty (check Screen Recording permission for Raycast)"
  exit 1
fi

text=$(/Users/nino/.local/bin/vision-ocr "$tmp" 2>&1)
ocr_exit=$?
rm -f "$tmp"

if [ $ocr_exit -ne 0 ] || [ -z "$text" ]; then
  echo "OCR failed: ${text:-no output}"
  exit 1
fi

tmp_clip=$(mktemp)
printf '%s' "$text" >"$tmp_clip"
osascript -e "set the clipboard to (read POSIX file \"$tmp_clip\" as «class utf8»)"
rm -f "$tmp_clip"

echo "Copied: $text"
