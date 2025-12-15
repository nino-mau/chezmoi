# Reload ghostty terminal config
abbr -a rghost "source ~/.config/ghostty/config"

# Reload fish config file
abbr -a rconfig "source ~/.config/fish/config.fish"

#
# NVIM
#

abbr -a nv nvim

alias mvim="NVIM_APPNAME=mvim nvim"

#
# TMUX
#

# Kill all session but current
abbr -a tmka "tmux kill-session -a"

# Load a session with tmuxp 
abbr -a tml "tmuxp load"

#
# SSH
#

alias sshpi="TERM=xterm-256color ssh nino@nino-pi" # Connect to my pi
