#!/usr/bin/env fish

# Use qdbus to get history
set -l qdbus (type -p qdbus-qt5 qdbus6 qdbus | head -n 1)
test -z "$qdbus" && echo "qdbus not found" && exit 1

set -l raw ($qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu)
test -z "$raw" && echo "No clipboard history available" && exit 1

# Format lines with index: entry
set -l selected (printf "%s\n" $raw | fzf --prompt="Clipboard > ")

# If nothing selected
test -z "$selected" && exit 0

# Extract index
set -l idx (string match -r '^\d+' -- $selected)

# Get full clipboard content
set -l content ($qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryItem $idx)

# Restore to clipboard
echo "$content" | wl-copy

# Optionally, also paste it to terminal or notify
notify-send "Clipboard Restored" "$content"
