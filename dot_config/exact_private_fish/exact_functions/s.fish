function s -d "Search a package"
    set -l package "$argv[1]"
    if not set -q package
        begin
            set_color red
            printf '%s\n' 'Missing package.'
            set_color normal
        end >&2
        return 2
    end

    if test "$os" = Darwin
        command port search "$package"
    else
        command tv paru-search --exact --source-command "paru -Ss $package --color=always | awk '/^[^[:space:]]/'"
    end
end
