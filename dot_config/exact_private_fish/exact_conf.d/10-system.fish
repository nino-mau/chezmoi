# System & shell utilities

abbr -a i "paru -S"
abbr -a oc opencode
abbr -a chz chezmoi
abbr -a rmr "rm -r"
abbr -a rfc "source ~/.config/fish/config.fish"
abbr -a tml "tmuxp load"

# Paru 

abbr -a pr paru
# List explicitly installed packages
abbr -a pl "paru -Qe"
# Search packages
abbr -a ps "paru -Ss"

alias restart="exec $SHELL"
alias rand="openssl rand -base64 32 | tr -d '/+='"
alias icat="kitten icat"
# Show images in a grid in terminal
abbr -a lsimg "timg --grid=3x2 --title *.{jpg,JPG,png,jpeg,webp}"

# Cheatsheets
alias helptmux="feh ~/Pictures/cheatsheets/tmux.png"
