function zn --description 'Open a zoxide-matched directory in nvim'
    set -l argc (count $argv)
    set -l target

    if test $argc -eq 0
        set target $HOME
    else if test $argc -eq 1 -a $argv[1] = -
        if not set -q OLDPWD
            echo 'zn: OLDPWD is not set' >&2
            return 1
        end

        set target $OLDPWD
    else if test $argc -eq 1 -a -d $argv[1]
        set target $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        set target $argv[2]
    else
        set target (command zoxide query --exclude (builtin pwd -L) -- $argv)
        or return
    end

    if not test -d $target
        echo "zn: not a directory: $target" >&2
        return 1
    end

    command zoxide add -- $target

    set -l previous_pwd (builtin pwd -L)
    builtin cd -- $target
    or return

    command nvim .
    set -l nvim_status $status

    builtin cd -- $previous_pwd
    or return

    return $nvim_status
end
