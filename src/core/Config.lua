local Config = {
	game = {
		title = "My Lua Game Engine",
		version = "0.1.0",
		author = "Your Name",
	},
	window = {
		width = 800,
		height = 600,
		fullscreen = true,
		resizable = true,
		vsync = true,
	},
	audio = {
		musicVolume = 1.0,
		soundVolume = 1.0,
	},
	graphics = {
		scale = 1,
		filter = "nearest",
	},
	font = {
		menuFontSize = 16,
		gameFontSize = 16,
	},
}

return Config
