Name = "translate"
NamePretty = "Translate (FR/EN)"
Icon = "/home/nino/.local/share/icons/material/google_translate.svg"
Cache = false
Action = "wl-copy %VALUE%"
HideFromProviderlist = false
Description = "Translate text to French and English using Google Translate API"
SearchName = false
KeepOpen = false

local function getApiKey()
	local env_file = os.getenv("HOME") .. "/.config/elephant/menus/.env"
	local f = io.open(env_file, "r")
	if not f then
		return nil
	end

	for line in f:lines() do
		local key, value = line:match("^%s*([%w_]+)%s*=%s*(.*)%s*$")
		if key == "GOOGLE_TRANSLATE_API_KEY" then
			-- strip quotes if present
			value = value:gsub("^['\"](.-)['\"]$", "%1")
			f:close()
			return value
		end
	end
	f:close()
	return nil
end

local API_KEY = getApiKey()

local function shellEscape(value)
	if value == nil then
		return "''"
	end
	return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function fetchTranslation(text, target_lang)
	local cmd = "curl -s -G 'https://translation.googleapis.com/language/translate/v2' -d target="
		.. target_lang
		.. " -d key="
		.. API_KEY
		.. " --data-urlencode q="
		.. shellEscape(text)
	local handle = io.popen(cmd)
	if not handle then
		return nil, "Failed to execute curl"
	end

	local json_string = handle:read("*a")
	handle:close()

	if not json_string or json_string == "" then
		return nil, "Empty response from API"
	end

	local data = jsonDecode(json_string)

	if data and data.data and data.data.translations and data.data.translations[1] then
		return data.data.translations[1].translatedText, nil
	elseif data and data.error then
		return nil, "API Error: " .. tostring(data.error.code) .. " - " .. tostring(data.error.message)
	end

	return nil, "Failed to parse API response"
end

function GetEntries(query)
	local entries = {}

	if not query or query == "" then
		table.insert(entries, {
			Text = "Type text to translate...",
			Subtext = "Translates to French and English",
			Icon = "/home/nino/.local/share/icons/material/google_translate.svg",
			Value = "",
		})
		return entries
	end

	if not API_KEY or API_KEY == "" then
		table.insert(entries, {
			Text = "Missing API Key",
			Subtext = "Please set GOOGLE_TRANSLATE_API_KEY in ~/.config/elephant/menus/.env",
			Icon = "/home/nino/.local/share/icons/material/error.svg",
			Value = "",
		})
		return entries
	end

	-- Fetch French translation
	local fr_text, fr_err = fetchTranslation(query, "fr")
	if fr_text then
		table.insert(entries, {
			Text = fr_text,
			Subtext = "FR: " .. query,
			Icon = "/home/nino/.local/share/icons/material/language_french.svg",
			Value = fr_text,
		})
	else
		table.insert(entries, {
			Text = "French Translation Error",
			Subtext = fr_err,
			Icon = "/home/nino/.local/share/icons/material/error.svg",
			Value = "",
		})
	end

	-- Fetch English translation
	local en_text, en_err = fetchTranslation(query, "en")
	if en_text then
		table.insert(entries, {
			Text = en_text,
			Subtext = "EN: " .. query,
			Icon = "/home/nino/.local/share/icons/material/language_english.svg",
			Value = en_text,
		})
	else
		table.insert(entries, {
			Text = "English Translation Error",
			Subtext = en_err,
			Icon = "/home/nino/.local/share/icons/material/error.svg",
			Value = "",
		})
	end

	return entries
end
