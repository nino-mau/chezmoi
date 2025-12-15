local wez = require("wezterm")

local config = {}

-- === GENERAL ===

config.window_close_confirmation = "NeverPrompt"

-- === FONT ===

config.font = wez.font("SpaceMono Nerd Font")
-- config.font = wez.font("IosevkaNerdFont")
-- config.font = wez.font("JetBrainsMonoNerdFont")
-- config.font = wez.font("HackNerdFont")
-- config.font = wez.font("FiraCodeNerdFont")

config.font_size = 15

config.line_height = 1

-- === THEME ===

config.color_scheme = "Catppuccin Macchiato (Gogh)"

-- === WINDOW ===

-- Window size
config.initial_cols = 220
config.initial_rows = 129

-- Remove title bar
config.window_decorations = "RESIZE"
-- Remove title bar but keep control buttons
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Add border to window frame
config.window_frame = {
	border_left_width = "1px",
	border_right_width = "1px",
	border_bottom_height = "1px",
	border_top_height = "1px",
	border_left_color = "494c56",
	border_right_color = "494c56",
	border_bottom_color = "494c56",
	border_top_color = "494c56",
}

-- Window padding
config.window_padding = {
	left = 15,
	right = 15,
	top = 20,
	bottom = 12,
}

-- Background
config.window_background_opacity = 0.5
config.macos_window_background_blur = 50

-- === INPUTS ===

-- On macos make it so the left opt act as altgr
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

-- === KEYBINDINGS ===
config.keys = {
	{
		key = "C",
		mods = "CTRL|SHIFT",
		action = wez.action.CopyTo("Clipboard"),
	},
}

-- === PLUGINS ===

local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 2,
		right = 3,
		tabs = {
			left = 0,
			right = 5,
		},
	},
	separator = {
		space = 1,
		left_icon = wez.nerdfonts.fa_long_arrow_right,
		right_icon = wez.nerdfonts.fa_long_arrow_left,
		field_icon = wez.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
			new_tab_fg = 2,
		},
		workspace = {
			enabled = true,
			icon = wez.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wez.nerdfonts.oct_rocket,
			color = 2,
		},
		zoom = {
			enabled = false,
			icon = wez.nerdfonts.md_fullscreen,
			color = 4,
		},
		pane = {
			enabled = true,
			icon = wez.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = true,
			icon = wez.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = true,
			icon = wez.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = true,
			icon = wez.nerdfonts.md_calendar_clock,
			format = "%H:%M",
			color = 5,
		},
		cwd = {
			enabled = true,
			icon = wez.nerdfonts.oct_file_directory,
			color = 7,
		},
		spotify = {
			enabled = false,
			icon = wez.nerdfonts.fa_spotify,
			color = 3,
			max_width = 64,
			throttle = 15,
		},
	},
})

return config
