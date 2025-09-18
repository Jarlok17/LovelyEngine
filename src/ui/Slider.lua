-- src/ui/Slider.lua
local Slider = {}
Slider.__index = Slider

function Slider.new(x, y, width, height, min, max, initialValue, onChangeCallback)
	local self = setmetatable({}, Slider)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.min = min or 0
	self.max = max or 100
	self.value = initialValue or self.min
	self.onChangeCallback = onChangeCallback

	self.isDragging = false

	self.trackColor = { 0.5, 0.5, 0.5, 1 }
	self.fillColor = { 0.2, 0.6, 1, 1 }
	self.handleColor = { 1, 1, 1, 1 }
	self.handleSize = 20
	self.trackHeight = 4

	return self
end

function Slider:setValue(newValue)
	self.value = math.max(self.min, math.min(self.max, newValue))
	if self.onChangeCallback then
		self.onChangeCallback(self.value)
	end
end

function Slider:getValue()
	return self.value
end

function Slider:draw()
	-- Draw track (base of the slider)
	love.graphics.setColor(self.trackColor)
	love.graphics.rectangle(
		"fill",
		self.x,
		self.y + self.height / 2 - self.trackHeight / 2,
		self.width,
		self.trackHeight
	)

	-- Draw filled part of the slider
	local fillWidth = (self.value - self.min) / (self.max - self.min) * self.width
	love.graphics.setColor(self.fillColor)
	love.graphics.rectangle(
		"fill",
		self.x,
		self.y + self.height / 2 - self.trackHeight / 2,
		fillWidth,
		self.trackHeight
	)

	-- Draw a slider handler
	local handleX = self.x + fillWidth - self.handleSize / 2
	local handleY = self.y + self.height / 2 - self.handleSize / 2
	love.graphics.setColor(self.handleColor)
	love.graphics.rectangle("fill", handleX, handleY, self.handleSize, self.handleSize, 3)
end

function Slider:update(dt)
	if self.isDragging then
		local x, y = love.mouse.getPosition()
		self:mousemoved(x, y)
	end
end

function Slider:mousepressed(x, y, button)
	if button == 1 then
		-- Check whether the click was on the pen or trackpad.
		local handlePos = self.x + ((self.value - self.min) / (self.max - self.min)) * self.width
		local handleRect = {
			x = handlePos - self.handleSize / 2,
			y = self.y + self.height / 2 - self.handleSize / 2,
			width = self.handleSize,
			height = self.handleSize,
		}

		if
			x >= handleRect.x
			and x <= handleRect.x + handleRect.width
			and y >= handleRect.y
			and y <= handleRect.y + handleRect.height
		then
			self.isDragging = true
		elseif x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
			-- Click on the track - mode the handler to this position
			local relativeX = x - self.x
			local newValue = self.min + (relativeX / self.width) * (self.max - self.min)
			self:setValue(newValue)
			self.isDragging = true
		end
	end
end

function Slider:mousemoved(x, y)
	if self.isDragging then
		local relativeX = math.max(0, math.min(self.width, x - self.x))
		local newValue = self.min + (relativeX / self.width) * (self.max - self.min)
		self:setValue(newValue)
	end
end

function Slider:mousereleased(x, y, button)
	if button == 1 then
		self.isDragging = false
	end
end

function Slider:setTrackColor(color)
	self.trackColor = color
end

function Slider:setFillColor(color)
	self.fillColor = color
end

function Slider:setHandleColor(color)
	self.handleColor = color
end

function Slider:setHandleSize(size)
	self.handleSize = size
end

function Slider:setTrackHeight(height)
	self.trackHeight = height
end

return Slider
