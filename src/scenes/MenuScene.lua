-- src/scenes/MenuScene.lua
local Scene = require("src.core.Scene")
local Menu = require("src.ui.Menu")

local MenuScene = setmetatable({}, Scene)
MenuScene.__index = MenuScene

function MenuScene.new()
	local self = Scene.new()
	setmetatable(self, MenuScene)

	self.name = "menu"
	self.menu = Menu.new()
	self.buttons = {}

	return self
end

function MenuScene:enter(transitionData)
	local width, height = love.graphics.getDimensions()

	self.menu:setBackgroundColor(0.15, 0.15, 0.6)
	-- Game.audioManager:playMusic("menu_theme")

	local buttonWidth = 200
	local buttonHeight = 60

	self.buttons.start = self.menu:createButton(
		width / 2 - buttonWidth / 2,
		height / 2 - buttonHeight / 2 - 60,
		buttonWidth,
		buttonHeight,
		"Start Game"
	)

	self.buttons.start.onClick = function()
		Game.sceneManager:switchTo("game", { level = 1 })
	end

	self.buttons.settings = self.menu:createButton(
		width / 2 - buttonWidth / 2,
		height / 2 - buttonHeight / 2 + 10,
		buttonWidth,
		buttonHeight,
		"Settings"
	)

	self.buttons.settings.onClick = function()
		Game.sceneManager:push("settings")
	end

	self.buttons.quit = self.menu:createButton(
		width / 2 - buttonWidth / 2,
		height / 2 - buttonHeight / 2 + 80,
		buttonWidth,
		buttonHeight,
		"Quit"
	)

	self.buttons.quit.onClick = function()
		love.event.quit()
	end
end

function MenuScene:exit()
	self.menu:clear()
	Game.audioManager:stopMusic()
end

function MenuScene:update(dt)
	if self.isActive then
		self.menu:update(dt)
	end
end

function MenuScene:draw()
	self.menu:draw()
end

function MenuScene:mousemoved(x, y, dx, dy, istouch)
	if self.isActive then
		self.menu:mousemoved(x, y)
	end
end

function MenuScene:mousepressed(x, y, button, istouch, presses)
	if self.isActive then
		self.menu:mousepressed(x, y, button)
	end
end

function MenuScene:mousereleased(x, y, button, istouch, presses)
	if self.isActive then
		self.menu:mousereleased(x, y, button)
	end
end

return MenuScene
