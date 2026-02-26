Name = "commit-message"
NamePretty = "Commit Messages"
Icon = "vcs-commit"
Cache = false
Action = "wtype -- %VALUE%"
HideFromProviderlist = false
Description = "Insert conventional commit templates"
SearchName = true
KeepOpen = true

local TEMPLATES = {
	{
		label = "Features",
		type = "feat",
		value = "✨ feat: ",
	},
	{
		label = "Bug Fixes",
		type = "fix",
		value = "🐛 fix: ",
	},
	{
		label = "Documentation",
		type = "docs",
		value = "📚 docs: ",
	},
	{
		label = "Styles",
		type = "style",
		value = "🎨 style: ",
	},
	{
		label = "Code Refactoring",
		type = "refactor",
		value = "🛠️ refactor: ",
	},
	{
		label = "Performance Improvements",
		type = "perf",
		value = "🚀 perf: ",
	},
	{
		label = "Tests",
		type = "test",
		value = "🚨 test: ",
	},
	{
		label = "Builds",
		type = "build",
		value = "📦️ build: ",
	},
	{
		label = "Continuous Integrations",
		type = "ci",
		value = "⚙️ ci: ",
	},
	{
		label = "Chores",
		type = "chore",
		value = "🔧 chore: ",
	},
	{
		label = "Reverts",
		type = "revert",
		value = "🗑 revert: ",
	},
	{
		label = "Initial (alias -> feat)",
		type = "initial",
		value = "🎉 Initialization",
	},
}

local function normalizeQuery(query)
	local q = (query or ""):lower()
	q = q:gsub("^%s+", ""):gsub("%s+$", "")
	return q
end

function GetEntries(query)
	local entries = {}
	local q = normalizeQuery(query)

	for _, template in ipairs(TEMPLATES) do
		table.insert(entries, {
			Text = template.value,
			Value = template.value,
		})
	end

	if #entries == 0 then
		table.insert(entries, {
			Text = "No commit template found",
			Subtext = "Try searching by type, alias, or description",
			Value = "",
		})
	end

	return entries
end
