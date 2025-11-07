# Open specified fish configurations files
function cfish -d 'Open specified fish configurations files'
    set subcommand $argv[1]
    set config_path ~/.config/fish/conf.d
    switch $subcommand
        case nvim
            nvim $config_path/tools/nvim.fish
        case docker
            nvim $config_path/tools/docker.fish
        case lsd
            nvim $config_path/tools/lsd.fish
        case ssh
            nvim $config_path/tools/ssh.fish
        case python
            nvim $config_path/tools/python.fish
        case tmux
            nvim $config_path/tools/tmux.fish
        case nav
            nvim $config_path/navigation.fish
        case shortcuts
            nvim $config_path/shortcuts.fish
        case projects
            nvim $config_path/projects.fish
        case utils
            nvim $config_path/utils.fish
        case functions
            nvim (realpath $config_path/../functions)
        case all
            nvim (realpath $config_path/../)
        case '*'
            nvim (realpath $config_path/../config.fish)
    end
end
