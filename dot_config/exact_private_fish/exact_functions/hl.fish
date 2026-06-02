function hl -d 'Browse user-defined fish functions with fzf'
    set -l function_dir (realpath ~/.config/fish/functions)

    for fn in (functions | sort)
        set -l meta (functions --details --verbose $fn)
        set -l path (realpath $meta[1] 2>/dev/null)

        if not string match -q "$function_dir/*" $path
            continue
        end

        set -l desc $meta[5]

        if test "$desc" = n/a
            set desc 'no description'
        end

        printf '%s\t%s\n' $fn $desc
    end | fzf \
        --delimiter '\t' \
        --with-nth=1 \
        --preview 'printf "%s\n" {2}' \
        --preview-window=right:65%:wrap \
        --prompt 'functions> ' \
        --header 'preview shows description, enter copies name, ctrl-o opens in funced' \
        --bind 'enter:execute-silent(printf %s {1} | fish_clipboard_copy)+abort' \
        --bind 'ctrl-o:become(fish -ic "funced {1}")'
end
