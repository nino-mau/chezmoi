# Set up oh-my-posh theme
oh-my-posh init fish --config $HOME/.poshthemes/catppuccin_mocha.omp.json | source

# Run fastfetch
fastfetch

# Set up fzf key bindings
fzf --fish | source

# Set fish vim mode
set -g fish_key_bindings fish_vi_key_bindings

# # Set up fnm
# fnm env --use-on-cd | source

# Set up kwallet to remember ssh keys
set -x SSH_ASKPASS /usr/bin/ksshaskpass
set -x SSH_ASKPASS_REQUIRE prefer

# Set up pnpm global folder
set -gx PNPM_HOME "/home/nino/.local/share/pnpm"
if not string match -q -- "*$PNPM_HOME*" "$PATH"
    set -gx PATH "$PNPM_HOME" $PATH
end

##
## PATH
##

# Open .config folder
abbr -a cdconf "cd ~/.config"

# Open dev folder
abbr -a cddev "cd ~/Documents/dev"

# Go to projects folder
abbr -a cdproj "cd ~/Documents/dev/projects"

# Go to download folder
abbr -a cddwl "cd ~/Downloads"

# Go to documents
abbr -a cddoc "cd ~/Documents"

# Go to tmp folder
abbr -a cdtmp "cd ~/tmp"

##
## PROJECTS
##

# Open gameverse project in lazyvim
abbr -a lvgv "lvima ~/Documents/dev/projects/gameverse"

# Open navilab project in lazyvim
abbr -a lvnl ="lvima ~/Documents/dev/projects/navilab"

# Go to navilab project 
abbr -a cdnl "cd ~/Documents/dev/projects/navilab"

##
## FISH
##

# Open fish config file
abbr -a fconfig "lvima ~/.config/fish/config.fish"

# Reload fish config file
abbr -a rconfig "source ~/.config/fish/config.fish"

##
## VPS
##

alias cvps="ssh ubuntu@51.75.123.189" # Connect to digital ocean droplet

alias crootvps="ssh root@51.75.123.189" # Connect to digital ocean droplet as root

##
## PYTHON
##

alias rvenv="source venv/bin/activate.fish" # Start python venv

alias dvenv="deactivate" # deactivate python venv

# Start and run python env
function svenv
    python3 -m venv venv
    source venv/bin/activate.fish
end

##
## NEOVIM
##

# Use nvim as ni
abbr -a nv lvim

# Open nvim using the lazyvim config version
abbr -a lvim "NVIM_APPNAME=lazyvim nvim"

# Open nvim using the lazyvim config version
alias lvima="NVIM_APPNAME=lazyvim nvim"

# Open nvim using the nvchad config version
abbr -a cvim "NVIM_APPNAME=nvchad nvim"

# Open nvim using the astrovim config version
abbr -a astrovim "NVIM_APPNAME=astrovim nvim"

# Open default lazyvim config in lazyvim
abbr -a lvconf "lvima ~/.config/lazyvim"

# Open default nvim config in nvim
abbr -a nvconf "nvim ~/.config/nvim"

# Execute lvim with root perm
function rlvim
    sudo NVIM_APPNAME=lazyvim nvim $argv
end

##
## TMUX
##

abbr -a ftmux "lvima ~/.config/tmux/tmux.conf"

##
## DOCKER
##

# Start docker
abbr -a dcud "docker compose up -d"

# Rebuild docker
abbr -a dcbd "docker compose up -d --build"

# Stop docker
abbr -a dcd "docker compose down"

# Restart docker
abbr -a dcr "docker compose restart"

# Remove docker volumes
abbr -a dcdv "docker compose down -v"

# Exec command to complete with container name
abbr -a dce "docker compose exec"

# Logs command to complete with container name
abbr -a dcl "docker compose logs"

##
## LS
##

# Custom ls: reverse sort
abbr -a ls "lsd -t --reverse"

# Custom ls: just names
abbr -a lss "lsd -l -t --reverse --blocks=name"

# Custom ls: with permissions
abbr -a lsp "lsd --blocks=user,group,permission,name"

# Custom ls: full listing
abbr -a lsl "lsd -latr --blocks=date,user,group,permission,name"

##
## GENERAL
##

# Open wezterm terminal config
abbr -a fwez "lvima ~/.config/wezterm/wezterm.lua"

# Open ghostty terminal config
abbr -a fghost "lvima ~/.config/ghostty/config"

# Reload ghostty terminal config
abbr -a rghost "source ~/.config/ghostty/config"

# Start gameverse project
function startgv
    # Start services
    sudo systemctl start nginx
    sudo systemctl start mysql

    # Open server directory in VS Code
    cd ~/Documents/GamesMatch/server
    code .

    # Open client directory in VS Code
    cd ~/Documents/GamesMatch/client
    code .

    # Start client development server
    npm run dev &

    # Open a new WezTerm tab for the server with nodemon
    wezterm cli spawn --cwd ~/Documents/GamesMatch/server -- nodemon app.js
end

##
## UTILS
##

# Restart terminal
alias restart="exec $SHELL"

# Open tmux cheatsheet image
alias helptmux="feh ~/Pictures/cheatsheets/tmux.png"

# Execute script that open clipboard history in fzf
alias fzfclip="fish ~/Documents/dev/scripts/utils/clipboard_history_fzf.fish"

# Print clipboard history
alias cliph="qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu"

# Copy file content to clip board
function cpf --description 'Copy file content to clipboard'
    if test -z "$argv"
        echo "Usage: cpf <file>"
        return 1
    end

    set file $argv[1]

    if not test -r "$file"
        echo "Error: Cannot read '$file'"
        return 1
    end

    cat "$file" | fish_clipboard_copy
end

# Execute nano with root perm
function rnano
    sudo nano $argv
end

# Create a new dir and go in it
function mkcd
    if test (count $argv) -eq 1
        sudo mkdir -p $argv[1]
        and cd $argv[1]
    else
        echo "Usage: mkcd <directory>"
    end
end

##
## INIT FUNCTIONS
##

# Start a tmux session for navilab project
function snavilab
    set session_name navilab
    set project_root ~/Documents/dev/projects/navilab

    # Check if tmux session exists
    tmux has-session -t $session_name 2>/dev/null
    if test $status -eq 0
        tmux attach-session -t $session_name
        return
    end

    if test -z "$TMUX"
        # outside any tmux
        tmux new-session -d -s $session_name

        tmux new-window -t $session_name:1 -c $project_root -n editor
        tmux send-keys -t $session_name:1 "lvim $project_root" C-m
        tmux new-window -t $session_name:2 -c $project_root -n shell

        tmux select-window -t $session_name:1
        tmux attach-session -t $session_name
    else
        # inside tmux
        TMUX= tmux new-session -d -s $session_name
        tmux switch-client -t $session_name

        tmux new-window -t $session_name:1 -c $project_root -n editor lvim .
        tmux send-keys -t $session_name:1 "lvim $project_root" C-m
        tmux new-window -t $session_name:2 -c $project_root -n shell

        tmux select-window -t $session_name:1
    end
end
