function restart-waybar --description "Restart waybar"
    pkill -9 waybar

    if pgrep -x Hyprland >/dev/null
      rbg waybar
    else if pgrep -x niri >/dev/null
      rbg waybar -c ~/.config/waybar/config-bar-niri.jsonc -s ~/.config/waybar/style-bar-niri.css
    end
end
