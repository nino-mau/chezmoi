function restart-on-exit --description "Restart a command whenever it exits"
    argparse 'd/delay=' 'q/quiet' -- $argv
    or return 2

    set -l delay 1
    if set -q _flag_delay
        set delay $_flag_delay
    end

    if test (count $argv) -eq 0
        echo "usage: restart-on-exit [-d seconds] [--quiet] -- command [args...]" >&2
        return 1
    end

    while true
        $argv
        set -l exit_code $status

        if test $exit_code -eq 130
            return 130
        end

        if not set -q _flag_quiet
            echo "command exited with $exit_code, restarting in $delay s..." >&2
        end

        sleep $delay
    end
end
