function clipimg -d 'Save current clipboard image'
    set -l mime (wl-paste --list-types | rg '^image/' | head -n1)
    test -n "$mime"; or begin
        echo "No image in clipboard" >&2
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
        case 'svg+xml'
            set ext svg
    end

    set -l dst "./$name.$ext"

    if test -e $dst
        echo "File already exists: $dst" >&2
        return 1
    end

    wl-paste --type $mime > "$dst"
    echo "Saved $dst"
end
