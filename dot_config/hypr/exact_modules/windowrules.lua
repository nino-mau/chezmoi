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
	"^quickshell-notifications-.*$",
	"^quickshell-osd-.*$",
	"^quickshell-session-.*$",
	"^noctalia-.*$",
	"^sshell:.*",
}

local bitwarden_popup_tag = "bitwarden-popup"

local function has_tag(window, needle)
	for _, tag in ipairs(window.tags) do
		if tag == needle then
			return true
		end
	end

	return false
end

local function float_bitwarden_popup(window)
	if has_tag(window, bitwarden_popup_tag) then
		return
	end

	hl.dispatch(hl.dsp.window.float({ action = "set", window = window }))
	hl.dispatch(hl.dsp.window.resize({ window = window, x = 420, y = 640 }))
	hl.dispatch(hl.dsp.window.center({ window = window }))
	hl.dispatch(hl.dsp.window.tag({ tag = "+" .. bitwarden_popup_tag, window = window }))
end

-- Let Hyprland keybinds work while the Windows VM is focused
hl.window_rule({
	no_shortcuts_inhibit = true,
	match = {
		class = "qemu",
	},
})

-- Send browser to workspace 2
hl.window_rule({
	workspace = "2",
	match = {
		class = "zen",
	},
})

-- Keep the Bitwarden extension popup compact instead of tiling it like a browser window
hl.window_rule({
	match = {
		initial_title = "^_crx_nngceckbapebfimnlniiiahkandclblb$",
	},
	float = true,
	size = "420 640",
	center = true,
	tag = "+" .. bitwarden_popup_tag,
})

hl.on("window.title", function(window)
	if window.class ~= "zen" then
		return
	end

	if not window.title:find("Bitwarden Password Manager", 1, true) then
		return
	end

	float_bitwarden_popup(window)
end)

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
		blur_popups = true,
	})
end
