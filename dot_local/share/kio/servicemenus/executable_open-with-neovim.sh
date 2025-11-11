#!/bin/bash
FILE="$1"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "File does not exist: $FILE"
    exit 1
fi

# Launch Ghostty (or any terminal) with NVIM_APPNAME
NVIM_APPNAME=lazyvim ghostty --gtk-single-instance=false -e nvim "$FILE"

