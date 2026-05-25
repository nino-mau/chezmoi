function restart-waybar --description "Restart waybar"
    set -l scripts_dir ~/.config/waybar/scripts

    if pgrep -x waybar >/dev/null
        rbg $scripts_dir/restart.sh
    else if pgrep -x Hyprland >/dev/null
        rbg $scripts_dir/launch.sh bar
    else if pgrep -x niri >/dev/null
        rbg $scripts_dir/launch.sh niri-bar
    else
        printf '%s\n' 'waybar is not running and no supported compositor is active' >&2
        return 1
    end
end
