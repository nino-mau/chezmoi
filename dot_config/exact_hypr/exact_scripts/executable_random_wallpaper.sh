#!/usr/bin/env bash

WALLDIR="$HOME/.local/share/wallpapers/"

# pick a random image
PIC=$(find "$WALLDIR" -maxdepth 1 -type f | shuf -n 1)

# set wallpaper
set_wallpaper "$PIC"
