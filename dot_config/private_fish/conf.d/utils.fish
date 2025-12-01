# Restart terminal
alias restart="exec $SHELL"

# Open tmux cheatsheet image
alias helptmux="feh ~/Pictures/cheatsheets/tmux.png"

# Execute script that open clipboard history in fzf
alias fzfclip="fish ~/Documents/dev/scripts/utils/clipboard_history_fzf.fish"

# Print clipboard history
alias cliph="qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu"

# Display image
alias icat="kitten icat"

# Display images in a grid
abbr --add lsimg "timg --grid=3x2 --title *.{jpg,JPG,png,jpeg,webp}"
