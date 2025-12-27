#!/usr/bin/env bash

# Directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTFILE="$DIR/hugeicons.json"

PREFIX="hugeicons"
PARALLEL_JOBS=10

# Get all icon names
icons=$(curl -s "https://api.iconify.design/collection?prefix=$PREFIX" | jq -r '.uncategorized[]?')

# Start JSON object
echo -n '{"prefix":"'"$PREFIX"'","icons":{' >"$OUTFILE"

# Counter for total icons
total=$(echo "$icons" | wc -l)
count=0

# First icon flag for comma handling
first_icon=true

for icon in $icons; do
  count=$((count + 1))
  echo "Fetching $count/$total: $icon" >&2
  
  # Fetch SVG data
  svg=$(curl -s "https://api.iconify.design/$PREFIX/$icon.svg")
  
  # Escape the SVG for JSON
  svg_escaped=$(echo "$svg" | jq -Rs '.')
  
  # Add comma if not first icon
  if [ "$first_icon" = true ]; then
    first_icon=false
  else
    echo -n "," >>"$OUTFILE"
  fi
  
  # Write icon entry
  echo -n "\"$icon\":{\"name\":\"$icon\",\"svg\":$svg_escaped}" >>"$OUTFILE"
done

# Close JSON object
echo -n '}}' >>"$OUTFILE"

echo "All $total icons saved to $OUTFILE"
