-- src/engine/FontManager.lua
local FontManager = {}
FontManager.__index = FontManager

function FontManager.new()
	local self = setmetatable({}, FontManager)
	self.fonts = {}
	self.currentFont = nil
	return self
end

function FontManager:load(fontName, path, size)
	if not self.fonts[fontName] then
		local success, font = pcall(love.graphics.newFont, path, size)
		if success then
			font:setFilter("nearest", "nearest")
			self.fonts[fontName] = font
		else
			print("Помилка завантаження шрифту: " .. path)
			return nil
		end
	end
	return self.fonts[fontName]
end

function FontManager:getCurrentFont()
	return self.currentFont
end

function FontManager:get(fontName)
	return self.fonts[fontName]
end

function FontManager:set(fontName)
	local font = self:get(fontName)
	if font then
		love.graphics.setFont(font)
		self.currentFont = font
		return true
	end
	return false
end

return FontManager
