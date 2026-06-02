function zy --description 'Open a zoxide-matched directory in yazi'
    set -l argc (count $argv)
    set -l target

    if test $argc -eq 0
        set target $HOME
    else if test "$argv" = -
        if not set -q OLDPWD
            echo 'zy: OLDPWD is not set' >&2
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
        echo "zy: not a directory: $target" >&2
        return 1
    end

    command zoxide add -- $target
    command yazi -- $target
end
