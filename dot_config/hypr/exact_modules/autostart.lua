-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("modules.programs")

hl.on("hyprland.start", function()
	-- Launch notification daemon
	-- hl.exec_cmd("mako")

	-- Launch hyprpanel
	-- hl.exec_cmd("hyprpanel")

	-- Export the current Wayland session env to systemd and D-Bus activation.
	-- hl.exec_cmd('/usr/lib/ibus/ibus-ui-gtk3 --enable-wayland-im --exec-daemon --daemon-args "--xim --panel disable"')

	-- Launch waybar
	-- hl.exec_cmd("~/.config/waybar/scripts/launch.sh bar")

	-- Launch quickshell bar
	hl.exec_cmd("qs -c bar")

	-- Launch swaync
	-- hl.exec_cmd("swaync")

	-- Launch swayosd
	-- hl.exec_cmd("swayosd-server -s ~/.config/swayosd/style.css")

	-- Launch awww daemon
	hl.exec_cmd("awww-daemon")

	-- Set clipboard manager
	-- hl.exec_cmd("wl-paste --type text --watch cliphist store")

	-- Launch ie-r color picker daemon
	hl.exec_cmd("ie-r")

	-- Launch grammalecte server for vicinae spell checking local extension
	hl.exec_cmd("grammalecte-server")

	hl.exec_cmd(programs.terminal)
	hl.exec_cmd(programs.browser, { workspace = "2" })

	-- Launch btop in special btop workspace
	hl.exec_cmd(programs.terminal .. ' -e "btop"', { workspace = "special:btop silent" })
end)
