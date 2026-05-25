-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("modules.programs")

-- ===============
-- Actions
-- ===============

hl.bind("SUPER + X", hl.dsp.window.close())

-- Launch apps
hl.bind("SUPER + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(programs.browser))

-- Vicinae menu bindings
hl.bind("SUPER + 0", hl.dsp.exec_cmd(programs.menu))
hl.bind("SUPER + equal", hl.dsp.exec_cmd(programs.clipboard_menu))
hl.bind("SUPER + apostrophe", hl.dsp.exec_cmd(programs.commit_menu))
hl.bind("SUPER + E", hl.dsp.exec_cmd(programs.emoji_menu))
hl.bind("SUPER + slash", hl.dsp.exec_cmd(programs.wallpapers_menu))

-- Vicinae bindings
hl.bind("SUPER + space", hl.dsp.exec_cmd(programs.vicinae))

-- Take screenshot
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/screenshot-focused.sh"))

-- Lockscreen binding
hl.bind("SUPER + M", hl.dsp.exec_cmd(programs.lockscreen))

-- Toggle ie-r color picker
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("pkill -SIGUSR1 ie-r"))

-- Toggle ie-r color history
-- hl.bind("ALT + SHIFT + H", hl.dsp.exec_cmd("pkill -SIGUSR2 ie-r"))

-- ===============
-- Windows
-- ===============

hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo()) -- dwindle
-- hl.bind("SUPER + colon", hl.dsp.layout("togglesplit")) -- dwindle
-- hl.bind("SUPER + ugrave", hl.dsp.layout("togglesplit 1")) -- dwindle

-- Move focus with SUPER + arrow keys
-- hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
-- hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Expand a window
hl.bind("SUPER + f", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Make a window full screen
hl.bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen())

-- ===============
-- Workspaces
-- ===============

-- Switch workspaces with SUPER + [0-9]
for i = 1, 9 do
	hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move active window to a workspace with SUPER + SHIFT + [0-9]
for i = 1, 9 do
	hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspaces
hl.bind("SUPER + G", hl.dsp.workspace.toggle_special("game"))
hl.bind("SUPER + d", hl.dsp.workspace.toggle_special("note"))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("term"))
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("btop"))
hl.bind("SUPER + O", hl.dsp.workspace.toggle_special("discord"))

-- Scroll through existing workspaces with SUPER + ALT + H/L
hl.bind("SUPER + ALT + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + ALT + H", hl.dsp.focus({ workspace = "e-1" }))

-- ===============
-- Scrolling
-- ===============

-- Move view by column
hl.bind("SUPER + l", hl.dsp.layout("focus right"))
hl.bind("SUPER + h", hl.dsp.layout("focus left"))

hl.bind("SUPER + mouse_down", hl.dsp.layout("move +col"))
hl.bind("SUPER + mouse_up", hl.dsp.layout("move -col"))

-- Move window between column/directions
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Swap columns
hl.bind("SUPER + CTRL + l", hl.dsp.layout("swapcol r"))
hl.bind("SUPER + CTRL + h", hl.dsp.layout("swapcol l"))

-- Move window between column/directions
hl.bind("SUPER + SHIFT + right", hl.dsp.layout("colresize +0.1"))
hl.bind("SUPER + SHIFT + left", hl.dsp.layout("colresize -0.1"))

-- Toggle center vs fit
hl.bind("SUPER + CTRL + y", hl.dsp.layout("fit tobeg"))

-- Put window in its own column
hl.bind("SUPER + SHIFT + p", hl.dsp.layout("promote"))

-- ===============
-- Misc
-- ===============

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Rebind pipe character to rightalt + l
-- hl.bind("Mod5 + L", hl.dsp.exec_cmd("wtype '|'"))

-- Rebind tidle wave character to rightalt + n
-- hl.bind("Mod5 + at", hl.dsp.exec_cmd("wtype '~'"))

-- Rebind tidle wave character to rightalt + n
-- hl.bind("dead_grave", hl.dsp.exec_cmd("wtype '`'"))
