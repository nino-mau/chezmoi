#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title OCR Region
# @raycast.mode silent
# @raycast.icon 󰐳

tmp=$(mktemp /tmp/ocr_XXXXXX.png)
/usr/sbin/screencapture -i "$tmp" || { rm -f "$tmp"; exit 0; }
text=$(/Users/nino/.local/bin/vision-ocr "$tmp")
rm -f "$tmp"
echo "$text" | pbcopy
echo "Copied: $text"
