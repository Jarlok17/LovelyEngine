local Config = require("src.core.Config")
local SceneManager = require("src.core.managers.SceneManager")
local Debug = require("src.utils.Debug")

Game = {
	config = Config,
	sceneManager = SceneManager.new(),
	audioManager = require("src.core.managers.AudioManager").new(),
	fontManager = require("src.core.managers.FontManager").new(),
	debug = Debug,
	-- textureManager = require("src.core.TextureManager").new(),
	-- inputManager = require("src.core.InputManager").new(),
}

function love.load()
	Game.debug.info("Loading game...")
	love.window.setTitle(Game.config.game.title)
	love.window.setMode(Game.config.window.width, Game.config.window.height, {
		fullscreen = Game.config.window.fullscreen,
		resizable = Game.config.window.resizable,
		vsync = Game.config.window.vsync,
	})

	Game.debug.info("Loading fonts...")
	Game.fontManager:load("shojumaru", "assets/fonts/Shojumaru/Shojumaru-Regular.ttf", 18)
	Game.fontManager:set("shojumaru")

	Game.debug.info("Loading audio...")
	Game.audioManager:addMusic("menu_theme", "assets/musics/nice people.mp3")
	-- Game.audioManager:addMusic("game_theme", "assets/musics/game.mp3")
	Game.audioManager:setMusicVolume(Game.config.audio.musicVolume)
	Game.audioManager:playMusic("menu_theme")

	Game.debug.info("Registration scene 'menu'...")
	Game.sceneManager:register("menu", require("src.scenes.MenuScene"))
	Game.sceneManager:register("settings", require("src.scenes.SettingsScene"))
	-- Game.sceneManager:register("game", require("src.scenes.GameScene"))
	-- Game.sceneManager:register("pause", require("src.scenes.PauseScene"))

	Game.sceneManager:switchTo("menu")
	Game.debug.info("The game successfully downloaded.")
end

function love.update(dt)
	Game.sceneManager:update(dt)
end

function love.draw()
	Game.sceneManager:draw()
end

local loveEvents = {
	"keypressed",
	"keyreleased",
	"textinput",
	"mousemoved",
	"mousepressed",
	"mousereleased",
	"wheelmoved",
	"touchpressed",
	"touchmoved",
	"touchreleased",
	"focus",
	"quit",
	"resize",
}

for _, event in ipairs(loveEvents) do
	love[event] = function(...)
		Game.sceneManager[event](Game.sceneManager, ...)
	end
end
