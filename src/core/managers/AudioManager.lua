local AudioManager = {}
AudioManager.__index = AudioManager

function AudioManager.new()
	local self = setmetatable({}, AudioManager)
	self.musics = {}
	self.sounds = {}
	self.currentMusic = nil
	self.musicVolume = 1.0
	self.soundVolume = 1.0
	return self
end

function AudioManager:addSound(soundName, path)
	if not self.sounds[soundName] then
		local success, sound = pcall(love.audio.newSource, path, "static")
		if success then
			self.sounds[soundName] = sound
		else
			Game.debug:error("Error load sound: " .. path)
			Game.debug:info(sound)
			return nil
		end
	end
	return self.sounds[soundName]
end

function AudioManager:addMusic(musicName, path)
	if not self.musics[musicName] then
		local success, music = pcall(love.audio.newSource, path, "stream")
		if success then
			self.musics[musicName] = music
			self.musics[musicName]:setLooping(true)
		else
			Game.debug:error("Error load music: " .. path)
			Game.debug:info(music)
			return nil
		end
	end
	return self.musics[musicName]
end

function AudioManager:playSound(soundName)
	if self.sounds[soundName] then
		local sound = self.sounds[soundName]:clone()
		sound:setVolume(self.soundVolume)
		sound:play()
		return sound
	else
		Game.debug:error("There is no such sound: " .. tostring(soundName))
		return nil
	end
end

function AudioManager:playMusic(musicName)
	if self.currentMusic then
		self.currentMusic:stop()
	end

	if self.musics[musicName] then
		self.currentMusic = self.musics[musicName]
		self.currentMusic:setVolume(self.musicVolume)
		self.currentMusic:play()
		return self.currentMusic
	else
		Game.debug:error("There is no such music: " .. tostring(musicName))
		return nil
	end
end

function AudioManager:stopMusic()
	if self.currentMusic then
		self.currentMusic:stop()
		self.currentMusic = nil
	end
end

function AudioManager:pauseMusic()
	if self.currentMusic then
		self.currentMusic:pause()
	end
end

function AudioManager:resumeMusic()
	if self.currentMusic then
		self.currentMusic:play()
	end
end

function AudioManager:setMusicVolume(volume)
	self.musicVolume = math.max(0, math.min(1, volume))
	if self.currentMusic then
		self.currentMusic:setVolume(self.musicVolume)
	end
end

function AudioManager:setSoundVolume(volume)
	self.soundVolume = math.max(0, math.min(1, volume))
end

function AudioManager:getMusicVolume()
	return self.musicVolume
end

function AudioManager:getSoundVolume()
	return self.soundVolume
end

return AudioManager
