local M = {}

M.base_30 = {
	white = "{{ colors.on_surface.default.hex }}",
	darker_black = "{{ colors.surface_dim.default.hex }}",
	black = "{{ colors.terminal_background.default.hex }}", --  nvim bg
	black2 = "{{ colors.surface_container_lowest.default.hex }}",
	one_bg = "{{ colors.surface_container.default.hex }}", -- real bg of onedark
	one_bg2 = "{{ colors.surface_variant.default.hex }}",
	one_bg3 = "{{ colors.surface_container_high.default.hex }}",
	grey = "{{ colors.terminal_normal_black.default.hex }}",
	grey_fg = "{{ colors.outline_variant.default.hex }}",
	grey_fg2 = "{{ colors.terminal_selection_bg.default.hex }}",
	light_grey = "{{ colors.terminal_selection_bg.default.hex | lighten 8 }}",
	red = "{{ colors.terminal_normal_red.default.hex }}",
	baby_pink = "{{ colors.terminal_normal_red.default.hex | lighten 7 }}",
	pink = "{{ colors.terminal_normal_magenta.default.hex }}",
	line = "{{ colors.surface_container_high.default.hex }}", -- for lines like vertsplit
	green = "{{ colors.terminal_normal_green.default.hex | lighten 7 }}",
	vibrant_green = "{{ colors.terminal_normal_green.default.hex | lighten 7 }}",
	nord_blue = "{{ colors.terminal_normal_blue.default.hex }}",
	blue = "{{ colors.terminal_normal_blue.default.hex }}",
	yellow = "{{ colors.terminal_normal_yellow.default.hex }}",
	sun = "{{ colors.terminal_normal_yellow.default.hex | lighten 8 }}",
	purple = "{{ colors.tertiary.default.hex }}",
	dark_purple = "{{ colors.tertiary.default.hex | darken 8 }}",
	teal = "{{ colors.terminal_normal_cyan.default.hex }}",
	orange = "{{ colors.terminal_normal_yellow.default.hex | set_hue 10 }}",
	cyan = "{{ colors.terminal_normal_cyan.default.hex }}",
	statusline_bg = "{{ colors.surface_container_lowest.default.hex }}",
	lightbg = "{{ colors.on_secondary_fixed_variant.default.hex }}",
	pmenu_bg = "{{ colors.terminal_normal_green.default.hex | lighten 7 }}",
	folder_bg = "{{ colors.primary.default.hex }}",
	lavender = "{{ colors.secondary.default.hex }}",
}

M.base_16 = {
	base00 = "{{ colors.background.default.hex }}",
	base01 = "{{ colors.surface_container_lowest.default.hex }}",
	base02 = "{{ colors.surface_container.default.hex }}",
	base03 = "{{ colors.surface_container_high.default.hex }}",
	base04 = "{{ colors.surface_container_highest.default.hex }}",
	base05 = "{{ colors.on_surface.default.hex }}",
	base06 = "{{ colors.on_surface.default.hex | lighten 7 }}",
	base07 = "{{ colors.on_surface.default.hex }}",
	base08 = "{{ colors.terminal_normal_red.default.hex }}",
	base09 = "{{ colors.terminal_normal_yellow.default.hex | set_hue 10 }}",
	base0A = "{{ colors.terminal_normal_yellow.default.hex }}",
	base0B = "{{ colors.terminal_normal_green.default.hex | lighten 3  }}",
	base0C = "{{ colors.terminal_normal_cyan.default.hex }}",
	base0D = "{{ colors.terminal_normal_blue.default.hex }}",
	base0E = "{{ colors.tertiary.default.hex }}",
	base0F = "{{ colors.error.default.hex }}",
}

M.polish_hl = {
	treesitter = {
		["@variable"] = { fg = M.base_30.lavender },
		["@property"] = { fg = M.base_30.teal },
		["@variable.builtin"] = { fg = M.base_30.red },
	},
}

M.type = "dark"

M = require("base46").override_theme(M, "noctalia")

return M
