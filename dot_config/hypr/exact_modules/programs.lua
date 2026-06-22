return {
	terminal = "ghostty",
	browser = "zen-browser",
	fileManager = "yazi",
	hypremoji = "hypremoji",
	lockscreen = "qs -c bar ipc call lock lock",
	session_menu = "qs -c bar ipc call session toggle",

	-- Vicinae menus
	vicinae = "vicinae toggle",
	clipboard_menu = "vicinae 'vicinae://launch/clipboard/history'",
	emoji_menu = "vicinae 'vicinae://launch/core/search-emojis'",
	commit_menu = "vicinae 'vicinae://launch/@nino-mau/commit-message/commit-message'",
	wallpapers_menu = "vicinae 'vicinae://launch/@nino-mau/wallpaper-switcher/wallpapers'",

	-- Walker menus
	menu = "nc -U /run/user/1000/walker/walker.sock",
}
