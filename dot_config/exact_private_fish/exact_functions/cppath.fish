function cppath -d 'Copy path of file clipboard'
    if test -z "$argv"
        echo "Usage: cppath <file>"
        return 1
    end

    set file $argv[1]

    if not test -r "$file"
        echo "Error: Cannot read '$file'"
        return 1
    end

    realpath "$file" | fish_clipboard_copy
end
