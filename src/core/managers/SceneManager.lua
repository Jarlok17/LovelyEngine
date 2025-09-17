-- src/core/SceneManager.lua
local SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager.new()
	local self = setmetatable({}, SceneManager)
	self.scenes = {}
	self.currentScene = nil
	self.previousScene = nil
	self.sceneStack = {}
	return self
end

function SceneManager:register(name, sceneClass)
	self.scenes[name] = sceneClass
end

function SceneManager:switchTo(name, transitionData)
	if self.scenes[name] then
		if self.currentScene and self.currentScene.exit then
			self.currentScene:exit()
		end

		self.previousScene = self.currentScene

		self.currentScene = self.scenes[name].new()

		if self.currentScene.enter then
			self.currentScene:enter(transitionData)
		end

		self.sceneStack = {}
		table.insert(self.sceneStack, name)

		return true
	end
	return false
end

function SceneManager:push(name, transitionData)
	if self.scenes[name] then
		if self.currentScene and self.currentScene.pause then
			self.currentScene:pause()
		end

		-- Add currentScene into stack
		if self.currentScene then
			table.insert(self.sceneStack, self.currentScene)
		end

		-- Створюємо нову сцену
		self.currentScene = self.scenes[name].new()

		-- Ініціалізуємо нову сцену
		if self.currentScene.enter then
			self.currentScene:enter(transitionData)
		end

		return true
	end
	return false
end

function SceneManager:pop(transitionData)
	if #self.sceneStack > 1 then
		-- Виходимо з поточної сцени
		if self.currentScene and self.currentScene.exit then
			self.currentScene:exit()
		end

		-- Return to previous scene
		local previousSceneName = table.remove(self.sceneStack)
		self.currentScene = self.scenes[previousSceneName].new()

		-- Recover previous scene
		if self.currentScene and self.currentScene.resume then
			self.currentScene:resume(transitionData)
		end

		return true
	end
	return false
end

function SceneManager:update(dt)
	if self.currentScene and self.currentScene.update then
		self.currentScene:update(dt)
	end
end

function SceneManager:draw()
	if self.currentScene and self.currentScene.draw then
		self.currentScene:draw()
	end
end

-- Automaticaly registration of all events in Love2D
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
	"joystickpressed",
	"joystickreleased",
	"joystickaxis",
	"joystickhat",
	"focus",
	"quit",
	"resize",
}

for _, event in ipairs(loveEvents) do
	SceneManager[event] = function(self, ...)
		if self.currentScene and self.currentScene[event] then
			return self.currentScene[event](self.currentScene, ...)
		end
	end
end

return SceneManager
