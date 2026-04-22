# Environment variables

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx EZA_CONFIG_DIR "$HOME/.config/eza"
set -gx EXB_PATH "$HOME/Code/exb"
set -gx PI_CODING_AGENT_DIR "$HOME/.config/pi"
set -gx PI_CODING_AGENT_DIR "$HOME/.config/pi"
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"

# Vi mode
set -g fish_key_bindings fish_vi_key_bindings


