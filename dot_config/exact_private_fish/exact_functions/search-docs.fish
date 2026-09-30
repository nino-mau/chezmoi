function search-docs
    if test (count $argv) -eq 0
        echo "Usage: search-docs <text> [directory]"
        return 2
    end

    set -l term $argv[1]
    set -l directory .
    if test (count $argv) -ge 2
        set directory $argv[2]
    end

    find "$directory" \( -iname '*.pdf' -o -iname '*.docx' \) -print0 | while read -lz file
        set -l text
        switch "$file"
            case '*.pdf'
                set text (pdftotext "$file" - 2>/dev/null)
            case '*.docx'
                set text (pandoc "$file" -t plain 2>/dev/null)
        end

        if string match -iq -- "$term" "$text"
            echo "$file"
        end
    end
end
