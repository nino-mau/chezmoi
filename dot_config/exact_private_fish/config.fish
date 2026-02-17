# Suppress vim mode indicator
function fish_mode_prompt
end

if status is-interactive
    # Theme
    fish_theme $HOME/.config/fish/themes/catppuccin.fish

    if not set -q TMUX
        clear
        fastfetch
    end
end
