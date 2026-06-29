-- Window rules
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Window classes of games and game launchers
local game_launcher_classes = {
	"^(steam)$",
	"^(Steam)$",
	"^(steam_app_.*)$",
	"^(net.lutris.Lutris)$",
	"^(BB_Launcher)$",
}

-- Namespaces to blur
local blurred_namespaces = {
	"notifications",
	"vicinae",
	"swayosd",
	"swaync",
	"swaync-control-center",
	"swaync-notification-window",
	"^quickshell-bar-.*$",
	"^quickshell-notifications-.*$",
	"^quickshell-osd-.*$",
	"^quickshell-session-.*$",
	"^noctalia-.*$",
	"^sshell:.*",
}

-- Add blur to selected layer namespaces
for _, namespace in ipairs(blurred_namespaces) do
	hl.layer_rule({
		blur = true,
		ignore_alpha = 0.5,
		match = {
			namespace = namespace,
		},
		blur_popups = true,
	})
end

-- Send games/game launchers to special workspace "game"
for _, class in ipairs(game_launcher_classes) do
	hl.window_rule({
		workspace = "special:game",
		match = {
			class = class,
		},
	})
end

-- Let Hyprland keybinds work while the Quickemu Windows VM is focused
hl.window_rule({
	no_shortcuts_inhibit = true,
	match = {
		class = "qemu",
	},
})

-- Send zen-browser to workspace 2
hl.window_rule({
	workspace = "2",
	match = {
		class = "zen",
	},
})

-- Send WXT development firefox browser to workspace 3 (second monitor)
hl.window_rule({
	workspace = "3 silent",
	focus_on_activate = false,
	match = {
		class = "wxt-firefox",
	},
})

-- Send t3code to workspace 4
hl.window_rule({
	workspace = "4",
	match = {
		class = "t3code",
	},
})

-- Send vesktop/discord to special workspace "discord"
hl.window_rule({
	workspace = "special:discord",
	match = {
		class = "vesktop",
	},
})

-- Send obsidian to special workspace "note"
hl.window_rule({
	workspace = "special:note",
	match = {
		class = "obsidian",
	},
})

-- Make app transparents

hl.window_rule({
	match = {
		class = "Codex",
	},
	opacity = "0.99",
})

hl.window_rule({
	match = {
		class = "org.gnome.Nautilus",
	},
	opacity = "0.90",
})

hl.window_rule({
	match = {
		class = "nwg-look",
	},
	opacity = "0.90",
})

hl.window_rule({
	match = {
		class = "io.github.kaii_lb.Overskride",
	},
	opacity = "0.90",
})

hl.window_rule({
	match = {
		class = "^(org.gnome.*)$",
	},
	opacity = "0.9",
})

-- Make browsers not become transparent when inactive
hl.window_rule({
	match = {
		class = "microsoft-edge",
	},
	opacity = "1.0 override",
})

hl.window_rule({
	match = {
		class = "helium",
	},
	opacity = "1.0 override",
})

hl.window_rule({
	match = {
		class = "vivaldi-stable",
	},
	opacity = "1.0 override",
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	suppress_event = "maximize",
	match = {
		class = ".*",
	},
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	no_focus = true,
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
})
