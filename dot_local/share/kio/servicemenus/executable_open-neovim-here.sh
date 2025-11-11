#!/bin/bash
cd "$1" || exit
NVIM_APPNAME=lazyvim ghostty --gtk-single-instance=false -e nvim
