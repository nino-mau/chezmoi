function rmrf --description "Safe rm -rf"
    set -l protected_dirs / /home /home/nino /home/nino/test

    for arg in $argv
        if string match -q -r "^-" "$arg"
            continue
        end

        set -l abs_path (realpath --no-symlinks "$arg" 2>/dev/null)

        # Handle cases where realpath fails (e.g. file doesn't exist yet)
        if test -z "$abs_path"
            set abs_path $arg
        end

        set -l clean_path (string trim --right --chars=/ "$abs_path")

        if contains -- "$clean_path" $protected_dirs
            set_color red
            echo "srmrf: CRITICAL: Refusing to delete protected directory: $clean_path"
            set_color normal
            return 1
        end
    end

    command rm -rf $argv
end
