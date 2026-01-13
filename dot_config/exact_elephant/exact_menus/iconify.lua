Name = "iconify"
NamePretty = "Iconify"
Icon = "preferences-desktop-wallpaper"
Cache = false
Action = "wl-copy %VALUE%"
HideFromProviderlist = false
Description = "Search iconify icon and copy name to clipboard"
SearchName = true
MinScore = 0

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

function tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	for k, v in pairs(tbl) do
		local formatting = string.rep("  ", indent) .. k .. ": "
		if type(v) == "table" then
			print(formatting)
			tprint(v, indent + 1)
		elseif type(v) == "boolean" then
			print(formatting .. tostring(v))
		else
			print(formatting .. v)
		end
	end
end

local function fetchJson(url)
	local handle = io.popen('curl -sL "' .. url .. '"')
	if handle then
		local body = handle:read("*a")
		handle:close()
		return jsonDecode(body)
	end
end

function GetEntries(query)
	local entries = {}
	local icon_data = {}

	print(query)
	if query:find("/") then
		local query_collection, query_icon_name = query:match("([^/]+)/%s*(.*)")
		print(query_collection, query_icon_name)
		if query_icon_name and query_icon_name ~= "" then
			icon_data = fetchJson(
				"https://api.iconify.design/search?query=" .. query_icon_name .. "&prefix=" .. query_collection
			)
		else
			return entries
		end
	else
		icon_data = fetchJson("https://api.iconify.design/search?query=" .. query)
	end

	if icon_data == nil then
		print("Request to iconify API failed")
		return entries
	end
	if icon_data.total == 0 then
		print("No icons found")
		return entries
	end

	tprint(icon_data)

	for icon_key, icon in pairs(icon_data["icons"]) do
		local icon_collection, icon_name = icon:match("([^:]+):%s*(.*)")

		-- Fetch SVG from API and cache it
		local cache_path = CACHE_DIR .. "/" .. icon_collection .. "_" .. icon_name .. ".svg"

		-- Check if already cached, otherwise fetch from API and scale
		local svg_exists = io.open(cache_path, "r")
		if svg_exists then
			svg_exists:close()
		else
			local icon_svg_url = "https://api.iconify.design/" .. icon_collection .. "/" .. icon_name .. ".svg"
			local handle = io.popen('curl -sL "' .. icon_svg_url .. '"')
			if handle then
				local svg_content = handle:read("*a")
				handle:close()
				if svg_content and svg_content ~= "" then
					-- Scale SVG from 1em to 256px for proper preview display
					local scaled_svg = svg_content:gsub('width="[^"]*em"', 'width="256"')
					scaled_svg = scaled_svg:gsub('height="[^"]*em"', 'height="256"')
					local file = io.open(cache_path, "w")
					if file then
						file:write(scaled_svg)
						file:close()
					end
				end
			end
		end

		print(cache_path)

		-- Use / instead of : for Text to match query pattern for fuzzy filtering
		local display_icon = icon_collection .. "/" .. icon_name

		table.insert(entries, {
			Text = display_icon,
			Subtext = icon,
			Value = icon,
			Icon = cache_path,
		})
	end

	print("Returning " .. #entries .. " entries")
	return entries
end
