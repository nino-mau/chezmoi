-- Window rules
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Legacy $games was a single match expression, so keep it as one regex in Lua.
local games = "^(Steam|Lutris|Heroic|HeroicGamesLauncher|Proton|shadps4)$"

local game_workspace_classes = {
	"^(steam)$",
	"^(Steam)$",
	"^(steam_app_.*)$",
	"^(net.lutris.Lutris)$",
	"^(BB_Launcher)$",
}

local blurred_namespaces = {
	"notifications",
	"vicinae",
	"swayosd",
	"swaync",
	"swaync-control-center",
	"swaync-notification-window",
	"^quickshell-bar-.*$",
}

-- Send browser to workspace 2
hl.window_rule({
	workspace = "2",
	match = {
		class = "zen",
	},
})

-- Send t3code to workspace 4
hl.window_rule({
	workspace = "4",
	match = {
		class = "t3code",
	},
})

-- Send Steam/lutris games to special workspace "game"
for _, class in ipairs(game_workspace_classes) do
	hl.window_rule({
		workspace = "special:game",
		match = {
			class = class,
		},
	})
end

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

-- apply rules to those classes
hl.window_rule({
	match = {
		class = games,
	},
	no_anim = true,
	no_blur = true,
	no_shadow = true,
	border_size = 0,
	rounding = 0,
	fullscreen = true,
	immediate = true,
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

-- Add blur to selected layer namespaces
for _, namespace in ipairs(blurred_namespaces) do
	hl.layer_rule({
		blur = true,
		ignore_alpha = 0.5,
		match = {
			namespace = namespace,
		},
	})
end
