function exb --description "Load an Experience Builder tmuxp workspace"
    set -l workspace exb
    set -l tmuxp_args

    if test (count $argv) -gt 0
        if string match -qr '^[0-9]+$' -- $argv[1]
            set -l version $argv[1]
            set workspace exb$version
            set tmuxp_args $argv[2..-1]
        else if string match -q -- '-*' $argv[1]
            set tmuxp_args $argv
        else
            echo "usage: exb [version] [tmuxp load options]" >&2
            return 1
        end
    end

    set -l config "$HOME/.config/tmuxp/$workspace.yml"
    if not test -f $config
        echo "exb: tmuxp workspace not found: $config" >&2
        return 1
    end

    tmuxp load $tmuxp_args $workspace
end
