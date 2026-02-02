# Install with paru
alias i="paru -S"

alias oc="opencode"

alias lg="lazygit"

# Reload ghostty terminal config
abbr -a rghost "source ~/.config/ghostty/config"

# Reload fish config file
abbr -a rconfig "source ~/.config/fish/config.fish"

abbr -a nv nvim

alias mvim="NVIM_APPNAME=mvim nvim"

# Load a session with tmuxp 
abbr -a tml "tmuxp load"

# Connect to my pi
alias sshpi="TERM=xterm-256color ssh nino@nino-pi"
