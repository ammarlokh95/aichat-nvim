-- ~/Projects/copilot/lua/neovim-copilot/init.lua

local M = {}

-- Default configuration values
local defaults = {
	greeting = "Hello from My Lazy Plugin!",
	enable_extra_feature = false,
}

-- Store the actual configuration merged with defaults
M.config = {}

-- ★ The crucial setup function ★
-- It accepts a table (which lazy.nvim calls 'opts')
function M.setup(user_opts)
	-- Merge user options with defaults. Prioritize user options.
	-- vim.tbl_deep_extend is useful here ('force' overwrites nil/different types)
	M.config = vim.tbl_deep_extend("force", defaults, user_opts or {})

	-- Now use the configuration
	print("MyLazyPlugin setup complete.") -- So you know it ran

	-- Define commands, keymaps, autocmds based on M.config
	vim.api.nvim_create_user_command("LazyGreet", function()
		-- Use the configured greeting
		vim.notify(M.config.greeting, vim.log.levels.INFO)
	end, { desc = "Shows a greeting from My Lazy Plugin" })

	if M.config.enable_extra_feature then
		print("Extra feature enabled!")
		-- Set up extra things here
	end
end

-- Optional: You might expose other functions if needed
function M.do_something_else()
	-- ...
end

return M
