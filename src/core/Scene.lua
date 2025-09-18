-- src/core/Scene.lua
local Scene = {}
Scene.__index = Scene

function Scene.new()
	local self = setmetatable({}, Scene)
	self.name = "base_scene"
	self.isActive = true
	self.isTransparent = false
	return self
end

function Scene:enter(transitionData)
	-- Virtual method override in other classes
end

function Scene:exit()
	-- Virtual method override in other classes
end

function Scene:pause()
	self.isActive = false
end

function Scene:resume(transitionData)
	self.isActive = true
end

function Scene:update(dt)
	-- Virtual method override in other classes
end

function Scene:draw()
	-- Virtual method override in other classes
end

-- Basic event handlers Love2D
function Scene:keypressed(key, scancode, isrepeat) end
function Scene:keyreleased(key, scancode) end
function Scene:textinput(text) end
function Scene:mousemoved(x, y, dx, dy, istouch) end
function Scene:mousepressed(x, y, button, istouch, presses) end
function Scene:mousereleased(x, y, button, istouch, presses) end
function Scene:wheelmoved(x, y) end
function Scene:focus(focused) end
function Scene:quit() end
function Scene:resize(w, h) end

return Scene
