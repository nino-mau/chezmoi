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
  target  Configuration to edit [possible values: hypr, fish, ghost, niri] 

\e[4mOptions:\e[0m
  -h, --help  Show this help message'
        return 0
    end

    set -l usage '\e[4mUsage:\e[0m \e[1mdot\e[0m [OPTIONS] <target>\n\nFor more information, try --help'

    if not set -q argv[1]
        begin
            set_color red
            printf '%s\n' 'Missing target. Use dot --help.'
            set_color normal
            echo
            printf '%b\n' "$usage"
        end >&2
        return 2
    end

    set -l target "$argv[1]"

    switch "$target"
        case '*'
            begin
                set_color red
                printf '%s\n' 'Missing target. Use dot --help.'
                set_color normal
                echo
                printf '%b\n' "$usage"
            end >&2
            return 2
        case ghost
            command nvim ~/.config/ghostty/config.ghostty
        case fish
            command nvim ~/.config/fish
    end
end
