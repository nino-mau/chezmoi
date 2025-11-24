#!/usr/bin/env bash

WALLDIR="$HOME/.local/share/wallpapers/"

# pick a random image
PIC=$(find "$WALLDIR" -type f | shuf -n 1)

# set wallpaper
swww img "$PIC"
