# Open fish configuration files by domain
function cfish -d 'Open fish configuration files'
    set subcommand $argv[1]
    set conf_dir ~/.config/fish/conf.d

    switch $subcommand
        case env
            chezmoi edit --apply $conf_dir/00-env.fish
        case path
            chezmoi edit --apply $conf_dir/01-path.fish
        case init
            chezmoi edit --apply $conf_dir/02-init.fish
        case bindings
            chezmoi edit --apply $conf_dir/03-bindings.fish
        case docker
            chezmoi edit --apply $conf_dir/10-docker.fish
        case editor
            chezmoi edit --apply $conf_dir/10-editor.fish
        case git
            chezmoi edit --apply $conf_dir/10-git.fish
        case lsd
            chezmoi edit --apply $conf_dir/10-lsd.fish
        case nav
            chezmoi edit --apply $conf_dir/10-navigation.fish
        case python
            chezmoi edit --apply $conf_dir/10-python.fish
        case ssh
            chezmoi edit --apply $conf_dir/10-ssh.fish
        case system
            chezmoi edit --apply $conf_dir/10-system.fish
        case projects
            chezmoi edit --apply $conf_dir/10-projects.fish
        case functions
            nvim (realpath $conf_dir/../functions)
        case all
            nvim (realpath $conf_dir/../)
        case '*'
            chezmoi edit --apply (realpath $conf_dir/../config.fish)
    end
end
