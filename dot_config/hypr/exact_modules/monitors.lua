-- Monitors configurations
-- See https://wiki.hypr.land/Configuring/Monitors/

-- Configure laptop monitors

hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@60",
	position = "0x1920",
	scale = "1",
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

-- Assign workspaces to main monitors
hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
