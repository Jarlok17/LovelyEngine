-- src/utils/Debug.lua
local Debug = {}

local function getLogPath()
	return love.filesystem.getSaveDirectory() .. "/log.txt"
end

function Debug.print(type, ...)
	if not Debug.enabled then
		return
	end

	local messages = { ... }
	local message = ""
	for i, v in ipairs(messages) do
		if i > 1 then
			message = message .. " "
		end
		message = message .. tostring(v)
	end

	local formatted_message = "[" .. os.date("%Y-%m-%d %H:%M:%S") .. "] [" .. type .. "] " .. message

	print(formatted_message)

	local success, error_msg = love.filesystem.append("log.txt", formatted_message .. "\n")
	if not success then
		print("[DEBUG ERROR] Failed to write to log file: " .. tostring(error_msg))
	end
end

function Debug.info(...)
	Debug.print("INFO", ...)
end

function Debug.warn(...)
	Debug.print("WARN", ...)
end

function Debug.error(...)
	Debug.print("ERROR", ...)
end

Debug.enabled = true

function Debug.setEnabled(value)
	Debug.enabled = value
end

function Debug.log(type, ...)
	if not Debug.enabled then
		return
	end
	Debug.print(type, ...)
end

function Debug.table(tbl, indent)
	if not Debug.enabled then
		return
	end

	if not indent then
		indent = 0
	end
	if type(tbl) ~= "table" then
		Debug.print("INFO", tostring(tbl))
		return
	end

	for k, v in pairs(tbl) do
		local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
		if type(v) == "table" then
			Debug.print("INFO", formatting)
			Debug.table(v, indent + 1)
		else
			Debug.print("INFO", formatting .. tostring(v))
		end
	end
end

function Debug.assert(condition, message)
	if not condition then
		Debug.error("ASSERTION FAILED: " .. message)
		error(message, 2)
	end
end

function Debug.initialize()
	love.filesystem.write("log.txt", "=== LOG STARTED " .. os.date("%Y-%m-%d %H:%M:%S") .. " ===\n\n")
	Debug.info("Debug system initialized")
end

return Debug
