# Set up oh-my-posh theme
oh-my-posh init fish --config $HOME/.poshthemes/catppuccin_mocha.omp.json | source

# Run fastfetch
fastfetch

# Set up fzf key bindings
fzf --fish | source

# Set fish vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set up kwallet to remember ssh keys
set -x SSH_ASKPASS /usr/bin/ksshaskpass
set -x SSH_ASKPASS_REQUIRE prefer

# Set up pnpm global folder
set -gx PNPM_HOME "/home/nino/.local/share/pnpm"
if not string match -q -- "*$PNPM_HOME*" "$PATH"
    set -gx PATH "$PNPM_HOME" $PATH
end

# Source fish config files from conf.d/tools
for file in ~/.config/fish/conf.d/tools/*.fish
    source $file
end
