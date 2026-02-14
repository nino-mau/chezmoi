Name = "theme-wallpapers"
NamePretty = "Wallpapers"
Layout = "wallpapers"
Icon = "preferences-desktop-wallpaper"
Cache = false
Action = "swww img --transition-type wipe --transition-angle 30 --transition-fps 60 --transition-step 255 '%VALUE%'"
HideFromProviderlist = false
Description = "Set wallpaper"
SearchName = true

function GetEntries()
	local entries = {}

	-- Get the current theme from config file
	local current_theme
	local theme_file = os.getenv("HOME") .. "/.config/current_theme"
	local file = io.open(theme_file, "r")
	if file then
		current_theme = file:read("*l")
		file:close()
	end

	-- Build wallpaper directory
	local wallpaper_dir
	if current_theme and current_theme ~= "" then
		wallpaper_dir = os.getenv("HOME") .. "/.local/share/wallpapers/" .. current_theme
	else
		wallpaper_dir = os.getenv("HOME") .. "/.local/share/wallpapers"
	end

	local handle = io.popen(
		"find '"
			.. wallpaper_dir
			.. "' -maxdepth 1 -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \\) 2>/dev/null"
	)

	if handle then
		for line in handle:lines() do
			local filename = line:match("([^/]+)$")
			if filename then
				table.insert(entries, {
					Text = filename,
					Subtext = "Set as wallpaper",
					Value = line,
					Icon = line,
					Preview = line,
					PreviewType = "file",
				})
			end
		end
		handle:close()
	end

	if #entries == 0 then
		table.insert(entries, {
			Text = "No wallpapers found",
			Subtext = "Check directory: " .. wallpaper_dir,
			Value = "",
		})
	end

	return entries
end
