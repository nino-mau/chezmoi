-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({
	animations = {
		enabled = true,
	},
})

local function default_animations()
	-- Bezier curves
	hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
	hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
	hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
	hl.curve("softSnap", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
	hl.curve("fluent", { type = "bezier", points = { { 0.0, 0.0 }, { 0.2, 1.0 } } })

	-- Windows
	hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot", style = "popin 80%" })
	hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "overshot", style = "popin 80%" })
	hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "smoothOut", style = "popin 95%" })
	hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "softSnap" })

	-- Layers
	hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "smoothIn", style = "slide right" })
	hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "softSnap", style = "slide right" })

	-- Fade
	hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smoothIn" })
	hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "smoothIn" })
	hl.animation({ leaf = "fadeOut", enabled = true, speed = 4, bezier = "smoothOut" })
	hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "smoothIn" })
	hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "smoothIn" })
	hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "smoothIn" })
	hl.animation({ leaf = "fadeDpms", enabled = true, speed = 4, bezier = "smoothIn" })

	-- Workspaces
	hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slidefade 25%" })
	hl.animation({
		leaf = "specialWorkspace",
		enabled = true,
		speed = 5,
		bezier = "overshot",
		style = "slidefadevert 25%",
	})
end

local function spring_animations()
	-- Bezier curves
	hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
	hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
	hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
	hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })

	-- Spring Curves
	hl.curve("spring_menu", { type = "spring", mass = 1, stiffness = 240, dampening = 14 })
	hl.curve("spring_window", { type = "spring", mass = 1, stiffness = 90, dampening = 8 })
	hl.curve("spring_open", { type = "spring", mass = 1, stiffness = 90, dampening = 8 })
	hl.curve("spring_workspace", { type = "spring", mass = 1.2, stiffness = 90, dampening = 10 })
	hl.curve("spring_special", { type = "spring", mass = 1, stiffness = 90, dampening = 8 })

	-- Window animations
	hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "spring_window" })
	hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, spring = "spring_open", style = "popin 40%" })
	hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })

	-- Border animations (disabled)
	hl.animation({ leaf = "border", enabled = false })
	hl.animation({ leaf = "borderangle", enabled = false })

	-- Fade
	hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })

	-- Zoom cursor
	hl.animation({ leaf = "zoomFactor", enabled = true, speed = 6, bezier = "md3_decel" })

	-- Layer animations
	hl.animation({ leaf = "layersIn", enabled = true, speed = 3, spring = "spring_menu", style = "slide" })
	hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel", style = "slide" })
	hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
	hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })

	-- Workspace animations
	hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "spring_workspace", style = "slide" })
	hl.animation({
		leaf = "specialWorkspace",
		enabled = true,
		speed = 1,
		spring = "spring_special",
		style = "slidefadevert 40%",
	})
end

local function gnomed_animations()
	-- Bezier curves
	hl.curve("ease", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })
	hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.05 } } })

	-- Spring Curves
	hl.curve("spring_menu", { type = "spring", mass = 1, stiffness = 240, dampening = 14 })
	hl.curve("spring_window", { type = "spring", mass = 1, stiffness = 90, dampening = 8 })
	hl.curve("spring_open", { type = "spring", mass = 1, stiffness = 90, dampening = 8 })
	hl.curve("spring_workspace", { type = "spring", mass = 1.2, stiffness = 360, dampening = 32 })
	hl.curve("spring_special", { type = "spring", mass = 1, stiffness = 360, dampening = 28 })

	-- Windows
	hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot", style = "gnomed" })
	hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "ease", style = "slide bottom" })
	hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot", style = "slide" })

	-- Layers
	hl.animation({ leaf = "layers", enabled = true, speed = 2, spring = "spring_special", style = "slide" })

	-- Fade and border
	hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "ease" })
	hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "ease" })

	-- Workspaces
	-- hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "overshot", style = "slidefade 25%" })

	-- Workspace animations
	hl.animation({
		leaf = "workspaces",
		enabled = true,
		speed = 1,
		spring = "spring_workspace",
		style = "slidefade 25%",
	})
	hl.animation({
		leaf = "specialWorkspace",
		enabled = true,
		speed = 1,
		spring = "spring_special",
		style = "slidefadevert 40%",
	})
end

gnomed_animations()
