# Copy file content to clip board
function cpf -d 'Copy file content to clipboard'
    if test -z "$argv"
        echo "Usage: cpf <file>"
        return 1
    end

    set file $argv[1]

    if not test -r "$file"
        echo "Error: Cannot read '$file'"
        return 1
    end

    cat "$file" | fish_clipboard_copy
end
