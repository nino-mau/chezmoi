function prestart --description "Kill a process then run it in background"
    if test (count $argv) -eq 0
        echo "usage: prestart COMMAND [ARGS...]" >&2
        return 1
    end
    set -l process $argv[1]
    set -l cmd $argv[1]
    set -l args $argv[2..-1]
    pkill -9 $process
    rbg $cmd $args
    echo "restarted $cmd $args"
end
