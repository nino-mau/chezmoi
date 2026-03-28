# Environment variables

set -gx EZA_CONFIG_DIR "$HOME/.config/eza"

# Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Editor
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"
set -gx XDG_CONFIG_HOME "$HOME/.config"

