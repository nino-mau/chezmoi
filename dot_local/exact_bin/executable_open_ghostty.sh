#!/usr/bin/env bash
#!/usr/bin/env bash
# ~/bin/ghostty-open.sh

# $1 is the folder passed from the .desktop file
DIR="$1"
echo $DIR

# Fallback if no folder is provided
if [ -z "$DIR" ]; then
  DIR="$HOME"
fi

# Launch Ghostty in that directory
hyprctl dispatch exec "ghostty --working-directory='$DIR' --gtk-single-instance=false"
