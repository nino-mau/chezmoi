function repeat --description "Repeat a command a capped number of times"
    set -l max_repeats 100

    if set -q REPEAT_MAX
        set max_repeats $REPEAT_MAX[1]

        if not string match -qr '^[1-9][0-9]*$' -- $max_repeats
            echo "repeat: REPEAT_MAX must be a positive integer" >&2
            return 2
        end
    end

    if test (count $argv) -lt 2
        echo "usage: repeat COUNT command [args...]" >&2
        echo "COUNT must be between 0 and $max_repeats" >&2
        return 1
    end

    set -l repeat_count $argv[1]

    if not string match -qr '^(0|[1-9][0-9]*)$' -- $repeat_count
        echo "repeat: COUNT must be a non-negative integer" >&2
        return 1
    end

    if test $repeat_count -gt $max_repeats
        echo "repeat: refusing to run $repeat_count times (cap is $max_repeats)" >&2
        return 1
    end

    set -l cmd $argv[2..-1]
    set -l i 1
    set -l exit_code 0

    while test $i -le $repeat_count
        $cmd
        set exit_code $status

        if test $exit_code -eq 130
            return 130
        end

        set i (math $i + 1)
    end

    return $exit_code
end
