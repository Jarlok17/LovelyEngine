local Button = {}
Button.__index = Button

function Button.new(x, y, width, height, text)
	local self = setmetatable({}, Button)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.text = text or ""
	self.isHovered = false
	self.isPressed = false
	self.normalColor = { 0.4, 0.4, 0.4, 1 }
	self.hoverColor = { 0.6, 0.6, 0.6, 1 }
	self.pressColor = { 0.3, 0.3, 0.3, 1 }
	self.textColor = { 1, 1, 1, 1 }
	self.onClick = nil
	return self
end

function Button:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()
	local wasHovered = self.isHovered

	self.isHovered = mouseX >= self.x
		and mouseX <= self.x + self.width
		and mouseY >= self.y
		and mouseY <= self.y + self.height
end

function Button:draw()
	local color = self.normalColor
	if self.isPressed then
		color = self.pressColor
	elseif self.isHovered then
		color = self.hoverColor
	end

	-- drawing button rectangle
	love.graphics.setColor(color)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	love.graphics.setColor(self.textColor)

	-- drawing text of the button
	local font = love.graphics.getFont()
	local textHeight = font:getHeight()
	love.graphics.printf(self.text, self.x, self.y + (self.height - textHeight) / 2, self.width, "center")
end

function Button:mousemoved(x, y)
	self:update(0)
end

function Button:mousepressed(x, y, button)
	if button == 1 and self.isHovered then
		self.isPressed = true
		return true
	end
	return false
end

function Button:mousereleased(x, y, button)
	if button == 1 and self.isPressed then
		self.isPressed = false
		if self.isHovered and self.onClick then
			self.onClick()
		end
		return true
	end
	return false
end

return Button
