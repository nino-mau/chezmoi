function dot --description 'Helper for quickly editing common configurations'
    set -l options (fish_opt --short h --long help)

    argparse $options -- $argv
    or return

    if set -q _flag_help
        printf \
            '%b\n' \
            'Usage: \e[1mdot\e[0m [OPTIONS] <target>

Helper for quickly editing common configurations

\e[4mArguments:\e[0m
  \e[1m<target>\e[0m
    Configuration to edit 

    Possible values:

    ghost, fish, hypr, noctalia, lazygit, pi, opencode, vicinae, tmux, tmuxp,
    nvim, niri, sysc-greet, env, tv, tridactyl, chrome, zen, starship, kitty

\e[4mOptions:\e[0m
  -h, --help  Show this help message'
        return 0
    end

    set -l usage '\e[4mUsage:\e[0m \e[1mdot\e[0m [OPTIONS] <target>\n\nFor more information, try --help'

    set -l target "$argv[1]"

    if not set -q target
        begin
            set_color red
            printf '%s\n' 'Missing target. Use dot --help.'
            set_color normal
            echo
            printf '%b\n' "$usage"
        end >&2
        return 2
    end

    switch "$target"
        case ghost
            command nvim ~/.config/ghostty/config.ghostty
        case fish
            command nvim ~/.config/fish
        case hypr
            command nvim ~/.config/hypr
        case noctalia
            command nvim ~/.config/noctalia
        case lazygit
            command nvim ~/.config/lazygit/config.yml
        case pi
            command nvim ~/.config/pi/settings.json
        case opencode
            command nvim ~/.config/opencode/opencode.jsonc
        case vicinae
            command nvim ~/.config/vicinae
        case tmux
            command nvim ~/.config/tmux
        case tmuxp
            command nvim ~/.config/tmuxp
        case nvim
            command nvim ~/.config/nvim
        case niri
            command nvim ~/.config/niri
        case sysc-greet
            command nvim ~/.config/sysc-greet
        case env
            command nvim ~/.config/uwsm/env
        case tv
            command nvim ~/.config/television/config.toml
        case tridactyl
            command nvim ~/.config/tridactyl/tridactylrc
        case chrome
            command nvim ~/.config/zen-chrome/userChrome.css
        case zen
            command nvim ~/.config/zen/maq52mfa.Default\ \(twilight\)
        case starship
            command nvim ~/.config/starship/starship.toml
        case kitty
            command nvim ~/.config/kitty/kitty.conf

        case '*'
            begin
                set_color red
                printf '%s\n' 'Missing target. Use dot --help.'
                set_color normal
                echo
                printf '%b\n' "$usage"
            end >&2
            return 2
    end
end
