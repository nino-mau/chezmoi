-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("modules.programs")

local function bind(keys, action, description, opts)
	local merged = {}

	if opts then
		for key, value in pairs(opts) do
			merged[key] = value
		end
	end

	merged.description = description

	hl.bind(keys, action, merged)
end

local function focus_horizontal(direction)
	return function()
		local workspace = hl.get_active_workspace()

		if workspace and workspace.tiled_layout == "scrolling" then
			hl.dispatch(hl.dsp.layout("focus " .. direction))
			return
		end

		hl.dispatch(hl.dsp.focus({ direction = direction }))
	end
end

-- ===============
-- Actions
-- ===============

bind("SUPER + X", hl.dsp.window.close(), "Close the active window")

-- Launch apps
bind("SUPER + Q", hl.dsp.exec_cmd(programs.terminal), "Open terminal")
bind("SUPER + B", hl.dsp.exec_cmd(programs.browser), "Open browser")

-- Vicinae menu bindings
bind("SUPER + 0", hl.dsp.exec_cmd(programs.menu), "Open launcher menu")
bind("SUPER + equal", hl.dsp.exec_cmd(programs.clipboard_menu), "Open clipboard history")
bind("SUPER + apostrophe", hl.dsp.exec_cmd(programs.commit_menu), "Open commit message menu")
bind("SUPER + E", hl.dsp.exec_cmd(programs.emoji_menu), "Open emoji menu")
bind("SUPER + slash", hl.dsp.exec_cmd(programs.wallpapers_menu), "Open wallpapers menu")

-- Vicinae bindings
bind("SUPER + space", hl.dsp.exec_cmd(programs.vicinae), "Toggle Vicinae")

-- Take screenshot
bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/screenshot-focused.sh"), "Take focused window screenshot")

bind("SUPER + M", hl.dsp.exec_cmd(programs.session_menu), "Open session menu")

-- Toggle ie-r color picker
bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("pkill -SIGUSR1 ie-r"), "Toggle color picker")

-- Toggle ie-r color history
-- hl.bind("ALT + SHIFT + H", hl.dsp.exec_cmd("pkill -SIGUSR2 ie-r"))

-- ===============
-- Windows
-- ===============

bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }), "Toggle floating for active window")
bind("SUPER + P", hl.dsp.window.pseudo(), "Toggle pseudotile for active window") -- dwindle
-- hl.bind("SUPER + colon", hl.dsp.layout("togglesplit")) -- dwindle
-- hl.bind("SUPER + ugrave", hl.dsp.layout("togglesplit 1")) -- dwindle

-- Move focus with SUPER + hjkl
bind("SUPER + l", focus_horizontal("right"), "Focus right")
bind("SUPER + h", focus_horizontal("left"), "Focus left")
bind("SUPER + k", hl.dsp.focus({ direction = "up" }), "Focus window above")
bind("SUPER + j", hl.dsp.focus({ direction = "down" }), "Focus window below")

-- Move/resize windows with SUPER + LMB/RMB and dragging
bind("SUPER + mouse:272", hl.dsp.window.drag(), "Drag active window", { mouse = true })
bind("SUPER + mouse:273", hl.dsp.window.resize(), "Resize active window", { mouse = true })

-- Expand a window
bind("SUPER + f", hl.dsp.window.fullscreen({ mode = "maximized" }), "Maximize active window")

-- Make a window full screen
bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen(), "Toggle fullscreen for active window")

-- ===============
-- Workspaces
-- ===============

-- Switch workspaces with SUPER + [0-9]
for i = 1, 9 do
	bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }), "Switch to workspace " .. i)
end

-- Move active window to a workspace with SUPER + SHIFT + [0-9]
for i = 1, 9 do
	bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }), "Move active window to workspace " .. i)
end

-- Special Workspaces
bind("SUPER + G", hl.dsp.workspace.toggle_special("game"), "Toggle game special workspace")
bind("SUPER + SHIFT + G", hl.dsp.window.move({ workspace = "special:game" }), "Toggle game special workspace")
bind("SUPER + d", hl.dsp.workspace.toggle_special("note"), "Toggle notes special workspace")
bind("SUPER + S", hl.dsp.workspace.toggle_special("term"), "Toggle terminal special workspace")
bind("SUPER + grave", hl.dsp.workspace.toggle_special("btop"), "Toggle btop special workspace")
bind("SUPER + O", hl.dsp.workspace.toggle_special("discord"), "Toggle Discord special workspace")

-- Scroll through existing workspaces with SUPER + ALT + H/L
bind("SUPER + ALT + L", hl.dsp.focus({ workspace = "e+1" }), "Focus next workspace")
bind("SUPER + ALT + H", hl.dsp.focus({ workspace = "e-1" }), "Focus previous workspace")

-- ===============
-- Scrolling
-- ===============

-- Move view by column
bind("SUPER + mouse_down", hl.dsp.layout("move +col"), "Focus next column")
bind("SUPER + mouse_up", hl.dsp.layout("move -col"), "Focus previous column")

-- Move window between column/directions
bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }), "Move active window right")
bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }), "Move active window left")
bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }), "Move active window up")
bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }), "Move active window down")

-- Swap columns
bind("SUPER + CTRL + l", hl.dsp.layout("swapcol r"), "Swap with column to the right")
bind("SUPER + CTRL + h", hl.dsp.layout("swapcol l"), "Swap with column to the left")

-- Move window between column/directions
bind("SUPER + SHIFT + right", hl.dsp.layout("colresize +0.1"), "Increase column width")
bind("SUPER + SHIFT + left", hl.dsp.layout("colresize -0.1"), "Decrease column width")

-- Toggle center vs fit
bind("SUPER + SHIFT + E", hl.dsp.layout("fit expand"), "Expand current window to remaining free space on monitor")

-- Put window in its own column
bind("SUPER + SHIFT + p", hl.dsp.layout("promote"), "Promote window into its own column")

-- ===============
-- Misc
-- ===============

-- Laptop multimedia keys for volume and LCD brightness
-- Quickshell's OSD listens to PipeWire changes, so volume keys only need to
-- update the default sink directly.
bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	"Raise output volume",
	{ locked = true, repeating = true }
)
bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	"Lower output volume",
	{ locked = true, repeating = true }
)
bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	"Toggle output mute",
	{ locked = true }
)

bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	"Raise brightness",
	{ locked = true, repeating = true }
)
bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	"Lower brightness",
	{ locked = true, repeating = true }
)

-- Requires playerctl
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), "Play next track", { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), "Toggle playback", { locked = true })
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), "Toggle playback", { locked = true })
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), "Play previous track", { locked = true })

-- Rebind pipe character to rightalt + l
-- hl.bind("Mod5 + L", hl.dsp.exec_cmd("wtype '|'"))

-- Rebind tidle wave character to rightalt + n
-- hl.bind("Mod5 + at", hl.dsp.exec_cmd("wtype '~'"))

-- Rebind tidle wave character to rightalt + n
-- hl.bind("dead_grave", hl.dsp.exec_cmd("wtype '`'"))
