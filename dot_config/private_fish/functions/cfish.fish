# Open fish configurations files
function cfish -d 'Open fish configurations file'
    set subcommand $argv[1]
    set config_path ~/.config/fish/conf.d
    switch $subcommand
        case nvim
            lvima $config_path/tools/nvim.fish
        case docker
            lvima $config_path/tools/docker.fish
        case lsd
            lvima $config_path/tools/lsd.fish
        case ssh
            lvima $config_path/tools/ssh.fish
        case python
            lvima $config_path/tools/python.fish
        case tmux
            lvima $config_path/tools/tmux.fish
        case nav
            lvima $config_path/navigation.fish
        case shortcuts
            lvima $config_path/shortcuts.fish
        case utils
            lvima $config_path/utils.fish
        case functions
            lvima (realpath $config_path/../functions)
        case all
            lvima (realpath $config_path/../)
        case '*'
            lvima (realpath $config_path/../config.fish)
    end
end
