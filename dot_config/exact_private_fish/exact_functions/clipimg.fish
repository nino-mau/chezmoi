function clipimg -d 'Save current clipboard image'
    set -l types (wl-paste --list-types)
    set -l mime
    set -l src
    set -l src_kind clipboard
    set -l has_uri_list 0

    for type in $types
        set -l base (string lower -- (string replace -r ';.*$' '' -- $type))
        if test "$base" = text/uri-list
            set has_uri_list 1
        end

        if contains -- $base image/svg+xml image/svg
            set mime $base
            break
        end
    end

    if test -z "$mime"
        for type in $types
            set -l base (string lower -- (string replace -r ';.*$' '' -- $type))
            if string match -qr '^image/' -- $base
                set mime $base
                break
            end
        end
    end

    if test -z "$mime"; and test $has_uri_list -eq 1
        for line in (wl-paste --no-newline --type text/uri-list)
            set line (string trim -- $line)
            if test -n "$line"; and not string match -qr '^#' -- $line
                set src $line
                break
            end
        end

        test -n "$src"; or begin
            echo "Clipboard URI list is empty" >&2
            return 1
        end

        if string match -qr '^file://' -- $src
            set src_kind file
            set src (string replace -r '^file://[^/]*' '' -- $src)
            set src (string unescape --style=url -- $src)

            test -e "$src"; or begin
                echo "Clipboard file does not exist: $src" >&2
                return 1
            end

            set mime (string lower -- (file --brief --mime-type -- "$src"))
        else if string match -qr '^https?://' -- $src
            set src_kind url
            set mime (string lower -- (curl -fsSLI -o /dev/null -w '%{content_type}' -- "$src"))
            set mime (string replace -r ';.*$' '' -- $mime)

            if test -z "$mime"
                set -l src_path (string lower -- (string replace -r '[?#].*$' '' -- $src))
                switch $src_path
                    case '*.svg' '*.svgz'
                        set mime image/svg+xml
                    case '*.png'
                        set mime image/png
                    case '*.jpg' '*.jpeg'
                        set mime image/jpeg
                    case '*.webp'
                        set mime image/webp
                    case '*.gif'
                        set mime image/gif
                    case '*.avif'
                        set mime image/avif
                end
            end
        else
            echo "Unsupported clipboard URI: $src" >&2
            return 1
        end
    end

    test -n "$mime"; or begin
        echo "No image in clipboard" >&2
        return 1
    end

    string match -qr '^image/' -- $mime; or begin
        echo "Clipboard content is not an image: $mime" >&2
        return 1
    end

    set -l name $argv[1]
    if test -z "$name"
        read -P 'File name (without extension): ' name
    end
    test -n "$name"; or return 1

    set -l ext (string replace -r '^image/' '' -- $mime)
    switch $ext
        case jpeg
            set ext jpg
        case svg
            set ext svg
        case 'svg+xml'
            set ext svg
    end

    set -l dst "./$name.$ext"

    if test -e $dst
        echo "File already exists: $dst" >&2
        return 1
    end

    switch $src_kind
        case clipboard
            wl-paste --type $mime > "$dst"
        case file
            cp -- "$src" "$dst"
        case url
            curl -fsSL -- "$src" > "$dst"
    end

    echo "Saved $dst"
end
