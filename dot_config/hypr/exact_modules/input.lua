-- Input configuration
-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		kb_options = "lv3:ralt_switch",

		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
