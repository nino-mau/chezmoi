# Environment variables

set -gx EXB_PATH "$HOME/Code/exb"
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"

# Vi mode
set -g fish_key_bindings fish_vi_key_bindings
