-- src/ui/Menu
local Button = require("src.ui.Button")

local Menu = {}
Menu.__index = Menu

function Menu.new()
	local self = setmetatable({}, Menu)
	self.buttons = {}
	self.isVisible = true
	self.background_color = { 0.1, 0.1, 0.1, 1.0 }
	self.background_image = nil
	return self
end

function Menu:addButton(button)
	table.insert(self.buttons, button)
	return button
end

function Menu:createButton(x, y, width, height, text)
	local button = Button.new(x, y, width, height, text)
	table.insert(self.buttons, button)
	return button
end

function Menu:setBackgroundColor(r, g, b, a)
	self.background_color = { r, g, b, a or 1.0 }
end

function Menu:setBackgroundImage(image_path)
	self.background_image = love.graphics.newImage(image_path)
end

function Menu:show()
	self.isVisible = true
end

function Menu:hide()
	self.isVisible = false
end

function Menu:update(dt)
	if not self.isVisible then
		return
	end

	for _, button in ipairs(self.buttons) do
		button:update(dt)
	end
end

function Menu:draw()
	if not self.isVisible then
		return
	end

	if self.background_image then
		love.graphics.draw(
			self.background_image,
			0,
			0,
			0,
			love.graphics.getWidth() / self.background_image:getWidth(),
			love.graphics.getHeight() / self.background_image:getHeight()
		)
	else
		love.graphics.setColor(self.background_color)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setColor(1, 1, 1, 1)
	end

	for _, button in ipairs(self.buttons) do
		button:draw()
	end
end

function Menu:mousemoved(x, y)
	if not self.isVisible then
		return
	end

	for _, button in ipairs(self.buttons) do
		button:mousemoved(x, y)
	end
end

function Menu:mousepressed(x, y, button)
	if not self.isVisible then
		return false
	end

	for _, b in ipairs(self.buttons) do
		if b:mousepressed(x, y, button) then
			return true
		end
	end
	return false
end

function Menu:mousereleased(x, y, button)
	if not self.isVisible then
		return false
	end

	for _, b in ipairs(self.buttons) do
		if b:mousereleased(x, y, button) then
			return true
		end
	end
	return false
end

function Menu:clear()
	self.buttons = {}
end

return Menu
