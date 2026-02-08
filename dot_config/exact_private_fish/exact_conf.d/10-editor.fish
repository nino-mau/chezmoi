# Editor & config editing

abbr -a nv nvim
alias mvim="NVIM_APPNAME=mvim nvim"
alias nchad="NVIM_APPNAME=nvchad nvim"

# Chezmoi-managed config editing
abbr -a che "chezmoi edit --apply"
abbr -a cghost "chezmoi edit --apply ~/.config/ghostty/config"
abbr -a ctmux "chezmoi edit --apply ~/.config/tmux/tmux.conf"
abbr -a czellij "chezmoi edit --apply ~/.config/zellij/config.kdl"
abbr -a chypr "chezmoi edit --apply ~/.config/hypr/hyprland.conf"

# Direct config editing
abbr -a cnvim "nvim ~/.config/nvim"
abbr -a chyprpanel "nvim ~/.config/hyprpanel"
