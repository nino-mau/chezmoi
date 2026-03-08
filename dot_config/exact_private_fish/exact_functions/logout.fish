function logout --description "Logout from Hyprland or niri"
    if set -q HYPRLAND_INSTANCE_SIGNATURE; and command -q hyprctl
        hyprctl dispatch exit
    else if set -q NIRI_SOCKET; and command -q niri
        niri msg action quit
    else
        echo "logout: could not detect Hyprland or niri" >&2
        return 1
    end
end
