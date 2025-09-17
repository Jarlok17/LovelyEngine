local TextureManager = {}
TextureManager.textures = {}
TextureManager.imageData = {}

function TextureManager.load(textureName, path)
	if not TextureManager.textures[textureName] then
		local success, image = pcall(love.graphics.newImage, path)
		if success then
			TextureManager.textures[textureName] = image
		else
			print("Помилка завантаження текстури: " .. path)
			print(image)
			return nil
		end
	end
	return TextureManager.textures[textureName]
end

function TextureManager.loadData(dataName, path)
	if not TextureManager.imageData[dataName] then
		local success, data = pcall(love.image.newImageData, path)
		if success then
			TextureManager.imageData[dataName] = data
		else
			print("Помилка завантаження ImageData: " .. path)
			print(data)
			return nil
		end
	end
	return TextureManager.imageData[dataName]
end

function TextureManager.get(textureName)
	return TextureManager.textures[textureName]
end

function TextureManager.getData(dataName)
	return TextureManager.imageData[dataName]
end

function TextureManager.unload(textureName)
	TextureManager.textures[textureName] = nil
end

function TextureManager.unloadData(dataName)
	TextureManager.imageData[dataName] = nil
end

return TextureManager
