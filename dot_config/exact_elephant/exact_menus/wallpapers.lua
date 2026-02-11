Name = "wallpapers"
NamePretty = "Wallpapers"
Layout = "wallpapers"
Icon = "preferences-desktop-wallpaper"
Cache = false
Action = os.getenv("HOME") .. "/.local/bin/set_wallpaper '%VALUE%'"
HideFromProviderlist = false
Description = "Set wallpaper"
SearchName = true

function GetEntries()
	local entries = {}
	local wallpaper_dir = os.getenv("HOME") .. "/.local/share/wallpapers"

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
