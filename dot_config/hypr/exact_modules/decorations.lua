-- Config that impact general appearance
-- See https://wiki.hypr.land/Configuring/Variables/#decoration
local colors = require("colors")

hl.config({
	general = {
		gaps_in = 12,
		gaps_out = 16,
		border_size = 1,
		col = {
			active_border = colors.primary,
			inactive_border = colors.border,
		},
		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,
		-- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
		allow_tearing = false,
	},

	decoration = {
		rounding = 15,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.92,

		shadow = {
			enabled = true,
			range = 25,
			render_power = 3,
			color = "rgba(1a1b2699)",
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 3,

			noise = 0.01,
			contrast = 0.8,
			vibrancy = 0.2,
			ignore_opacity = true,
			popups = true,
			popups_ignorealpha = 0.5,
		},
	},
})
