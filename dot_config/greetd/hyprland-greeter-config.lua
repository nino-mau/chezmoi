-- SYSC-Greet Hyprland config for the greetd greeter session.
-- Keep every connected monitor enabled. The startup script focuses the
-- preferred external display when one exists, leaving eDP as fallback.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.config({
    animations = {
        enabled = false,
    },

    decoration = {
        rounding = 0,
        blur = {
            enabled = false,
        },
    },

    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = "rgb(000000)",
        -- greetd does not pass the watchdog fd correctly to start-hyprland.
        disable_watchdog_warning = true,
    },

    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_options = "caps:swapescape",
        repeat_delay = 400,
        repeat_rate = 40,

        touchpad = {
            tap_to_click = true,
        },
    },
})

-- No keybindings are registered in the greeter session.
hl.window_rule({
    name = "kitty-greeter",
    match = { class = "^(kitty)$" },
    fullscreen = true,
    opacity = "1.0",
})

hl.layer_rule({
    name = "wallpaper",
    match = { namespace = "wallpaper" },
    blur = true,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("gslapper -f -I /tmp/sysc-greet-wallpaper.sock '*' /usr/share/sysc-greet/wallpapers/sysc-greet-default.png")
    hl.exec_cmd("/etc/greetd/select-greeter-monitor; XDG_CACHE_HOME=/tmp/greeter-cache HOME=/var/lib/greeter kitty --start-as=fullscreen --config=/etc/greetd/kitty.conf /usr/local/bin/sysc-greet && hyprctl dispatch exit")
end)
