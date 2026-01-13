Name = "iconify"
NamePretty = "Iconify"
Icon = "preferences-desktop-wallpaper"
Cache = false
Action = "wl-copy %VALUE%"
HideFromProviderlist = false
Description = "Search iconify icon and copy name to clipboard"
SearchName = true

local ICON_LIBRARY = "hugeicons"
local CACHE_DIR = os.getenv("HOME") .. "/.cache/elephant/iconify"

-- Ensure cache directory exists
os.execute("mkdir -p '" .. CACHE_DIR .. "'")

-- Save SVG to cache with proper scaling and return file path
function CacheSvg(icon_name, svg_content)
	if not svg_content or svg_content == "" then
		return nil
	end

	-- Scale SVG to higher resolution by replacing width/height
	-- Replace width="1em" height="1em" with actual pixel values
	local scaled_svg = svg_content:gsub('width="1em"', 'width="256"')
	scaled_svg = scaled_svg:gsub('height="1em"', 'height="256"')

	-- Alternative: ensure minimum size if no em units
	if not scaled_svg:find("width=") then
		scaled_svg = scaled_svg:gsub("<svg ", '<svg width="256" height="256" ')
	end

	local cache_path = CACHE_DIR .. "/" .. ICON_LIBRARY .. "_" .. icon_name .. ".svg"
	local file = io.open(cache_path, "w")

	if file then
		file:write(scaled_svg)
		file:close()
		return cache_path
	end

	return nil
end

function GetEntries()
	local entries = {}

	local file = "cat ~/.local/share/iconify/" .. ICON_LIBRARY .. ".json"
	local handle = io.popen("cat " .. file .. "")

	if handle then
		local json_string = handle:read("*a")
		handle:close()
		local data = jsonDecode(json_string)

		for k, v in pairs(data.icons) do
			-- Cache SVG to file for preview
			local svg_path = CacheSvg(v.name, v.svg)

			table.insert(entries, {
				Text = v.name,
				Subtext = "Copy icon name",
				Value = v.name,
				Icon = svg_path,
			})
		end
	end

	return entries
end
