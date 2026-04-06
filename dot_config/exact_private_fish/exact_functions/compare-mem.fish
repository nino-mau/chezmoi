function compare-mem -d 'Compare memory used by two different processes'
    for pat in $argv[1] $argv[2]
        set pids (pgrep -f -- $pat)

        if test (count $pids) -gt 0
            set rss_kib (ps -o rss= -p (string join , $pids) | awk '{s+=$1} END {print s+0}')
        else
            set rss_kib 0
        end

        printf "%-20s %10.1f MiB\n" $pat (awk -v k="$rss_kib" 'BEGIN { print k / 1024 }')
    end
end
