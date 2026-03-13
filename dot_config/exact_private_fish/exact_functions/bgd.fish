function bgd --description "Run a command in background and disown it"
    if test (count $argv) -eq 0
        echo "usage: bgd COMMAND [ARGS...]" >&2
        return 1
    end

    $argv </dev/null >/dev/null 2>&1 &
    set -l pid $last_pid

    if test -z "$pid"
        echo "bgd: failed to start command" >&2
        return 1
    end

    disown $pid
    echo "started PID $pid"
end
