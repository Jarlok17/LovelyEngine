-- src/scenes/SettingsScene.lua
local Scene = require("src.core.Scene")
local Menu = require("src.ui.Menu")

local SettingsScene = setmetatable({}, Scene)
SettingsScene.__index = SettingsScene

function SettingsScene.new()
	local self = Scene.new()
	setmetatable(self, SettingsScene)

	self.name = "settings"
	self.menu = Menu.new()
	self.buttons = {}
	self.sliders = {}
	self.texts = {}
	return self
end

function SettingsScene:enter(transitionData)
	local width, height = love.graphics.getDimensions()

	local buttonWidth = 200
	local buttonHeight = 60

	local sliderWidth = 400
	local sliderHeight = 60

	self.menu:setBackgroundColor(0.15, 0.15, 0.2)

	-- Add a back button
	self.buttons.backButton =
		self.menu:createButton(width / 2 - buttonWidth / 2, height / 2 + 120, buttonWidth, buttonHeight, "Back")
	self.buttons.backButton.onClick = function()
		Game.sceneManager:switchTo("menu")
	end

	-- Music volume slider
	self.sliders.musicSlider = self.menu:createSlider(
		width / 2 - sliderWidth / 2,
		height / 2 - sliderHeight - 70,
		sliderWidth,
		sliderHeight,
		0,
		1,
		Game.audioManager:getMusicVolume(),
		function(value)
			Game.audioManager:setMusicVolume(value)
			self.texts.music = "Musics: " .. math.floor(value * 100) .. "%"
		end
	)
	self.texts.music = "Musics: " .. math.floor(Game.audioManager:getMusicVolume() * 100) .. "%"

	-- Sound volume slider
	self.sliders.soundSlider = self.menu:createSlider(
		width / 2 - sliderWidth / 2,
		height / 2 - 10,
		sliderWidth,
		sliderHeight,
		0,
		1,
		Game.audioManager:getSoundVolume(),
		function(value)
			Game.audioManager:setSoundVolume(value)
			self.texts.sound = "Sounds: " .. math.floor(value * 100) .. "%"
		end
	)
	self.texts.sound = "Sounds: " .. math.floor(Game.audioManager:getSoundVolume() * 100) .. "%"
end

function SettingsScene:draw()
	self.menu:draw()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(Game.fontManager:getCurrentFont())

	-- Draw music volume text
	if self.sliders.musicSlider and self.texts.music then
		love.graphics.print(self.texts.music, self.sliders.musicSlider.x, self.sliders.musicSlider.y - 25)
	end

	-- Draw sound volume text
	if self.sliders.soundSlider and self.texts.sound then
		love.graphics.print(self.texts.sound, self.sliders.soundSlider.x, self.sliders.soundSlider.y - 25)
	end
end

function SettingsScene:exit()
	self.menu:clear()
end

function SettingsScene:update(dt)
	if self.isActive then
		self.menu:update(dt)
	end
end

function SettingsScene:mousemoved(x, y, dx, dy, istouch)
	if self.isActive then
		self.menu:mousemoved(x, y)
	end
end

function SettingsScene:mousepressed(x, y, button, istouch, presses)
	if self.isActive then
		self.menu:mousepressed(x, y, button)
	end
end

function SettingsScene:mousereleased(x, y, button, istouch, presses)
	if self.isActive then
		self.menu:mousereleased(x, y, button)
	end
end

return SettingsScene
