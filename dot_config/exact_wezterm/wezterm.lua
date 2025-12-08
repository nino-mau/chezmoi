local wez = require("wezterm")

local config = {}

-- === FONT ===

config.font = wez.font("SpaceMono Nerd Font")
-- config.font = wez.font("IosevkaNerdFont")
-- config.font = wez.font("JetBrainsMonoNerdFont")
-- config.font = wez.font("HackNerdFont")
-- config.font = wez.font("FiraCodeNerdFont")

config.font_size = 15

config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

-- config.line_height = 1.09

-- === WINDOW ===

-- Window size
config.initial_cols = 120
config.initial_rows = 29

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

-- === COLOR SHCEME ===

config.color_scheme = "catppuccin-mocha"

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
