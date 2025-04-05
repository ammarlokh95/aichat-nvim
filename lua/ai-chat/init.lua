print("init file loaded")
local M = {}
function M.start_new_chat()
	Filename = tostring(os.time())
	File = io.open(Filename, "w+")
	File:write("How can I help you?\n")
	--File:write("-----------------------------------------------------")
	File:flush()
	Current = File:seek()
	File:close()
	-- while true do
	-- 	local current = File:seek()
	-- 	local size = File:seek("end")
	-- 	File:seek("set", current)
	-- 	if current ~= size then
	-- 		File:write("\nI see you edited this file")
	-- 	end
	-- end
end

function M.prompt()
	File = io.open(Filename, "a+")
	local size = File:seek("end")

	File:seek("set", Current)

	local prompt = File:read("a")
	prompt = prompt:gsub("^%s*(.-)%s*$", "%1")
	print("prompt is " .. prompt)

	if Current ~= size then
		local curl = require("plenary.curl")
		File:write("\n\n-----------------------------------------------------")
		File:write("\nGenerating response\n")
		File:write("-----------------------------------------------------\n")
		File:close()
		local body = string.format('{ "prompt": "%s" }', prompt)
		local res = curl.post("http://localhost:8080/prompt", { body = body, timeout = 100000 })
		File = io.open(Filename, "a+")
		File:write(res.body)
		File:write("\n")
		Current = File:seek()
		File:close()
		vim.api.nvim_command("e")
	end
end
return M
