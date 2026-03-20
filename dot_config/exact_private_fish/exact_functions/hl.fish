function hl -d 'List fish functions with descriptions'
    set -l entries

    for fn in (functions | sort)
        set -l meta (functions --details --verbose $fn)
        set -l desc $meta[5]

        if test "$desc" = n/a
            set desc 'no description'
        end

        set -a entries (string shorten -m 44 -- "$fn - $desc")
    end

    set -l term_width $COLUMNS
    if not string match -qr '^[0-9]+$' -- "$term_width"
        set term_width (tput cols 2>/dev/null)
    end
    if not string match -qr '^[0-9]+$' -- "$term_width"
        set term_width 120
    end

    set -l gap 4
    set -l cell_width 44
    set -l cols (math "max(1, floor(($term_width + $gap) / ($cell_width + $gap)))")
    set -l rows (math "ceil("(count $entries)" / $cols)")
    set -l spacer (string repeat -n $gap ' ')

    for row in (seq 1 $rows)
        set -l line

        for col in (seq 0 (math "$cols - 1"))
            set -l idx (math "$row + ($col * $rows)")

            if test $idx -le (count $entries)
                set -a line (string pad -w $cell_width -- $entries[$idx])
            end
        end

        printf '%s\n' (string join -- $spacer $line)
    end
end
