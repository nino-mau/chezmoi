function notify --description "Send a desktop notification"
    set -l title "$argv[1]"
    set -l body "$argv[2]"

    set -l platform (uname)

    if set -q TMUX
        set -l attached_clients (tmux display-message -p '#{session_attached}' 2>/dev/null)
        if test "$attached_clients" = 0
            if test "$platform" = Linux; and command -q notify-send
                command notify-send --app-name="$title" "$title" "$body"
                return
            else if test "$platform" = Darwin; and command -q osascript
                printf '%s\n' \
                    'on run argv' \
                    'display notification (item 2 of argv) with title (item 1 of argv)' \
                    'end run' |
                    command osascript - "$title" "$body"
                return
            end
        end
    end

    if set -q KITTY_WINDOW_ID; or test "$TERM" = xterm-kitty
        if set -q TMUX
            printf '\ePtmux;\e\e]99;i=1:d=0;%s\e\e\\\e\\' "$title"
            printf '\ePtmux;\e\e]99;i=1:p=body;%s\e\e\\\e\\' "$body"
        else
            printf '\e]99;i=1:d=0;%s\e\\' "$title"
            printf '\e]99;i=1:p=body;%s\e\\' "$body"
        end
    else if set -q TMUX
        printf '\ePtmux;\e\e]777;notify;%s;%s\a\e\\' "$title" "$body"
    else if test "$platform" = Linux; and command -q notify-send
        command notify-send --app-name="$title" "$title" "$body"
    else if test "$platform" = Darwin; and command -q osascript
        printf '%s\n' \
            'on run argv' \
            'display notification (item 2 of argv) with title (item 1 of argv)' \
            'end run' |
            command osascript - "$title" "$body"
    else
        printf '\e]777;notify;%s;%s\a' "$title" "$body"
    end
end
