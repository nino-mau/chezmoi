function example --description 'Describe your command'
    set -l options (fish_opt --short h --long help)

    argparse $options -- $argv
    or return

    if set -q _flag_help
        printf \
'%b\n' \
'Describe your command

\e[4mUsage\e[0m: \e[1mexample\e[0m [OPTIONS] [ARGS...]

\e[4mArguments:\e[0m
  [ARGS...]  description

\e[4mOptions:\e[0m
  -h, --help  Show this help message'
        return 0
    end

    # Your command logic here
end
