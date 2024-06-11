local opts = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			runtime = {
				version = "LuaJIT",
				special = {
					reload = "require",
				},
			},
			diagnostics = {
				disable = { "undefined-global", "missing-fields" },
			},
			completion = {
				callSnippet = "Replace",
			},
			format = {
				enable = false,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					quote_style = "double",
				},
			},
			-- workspace = {
			-- 	library = {
			-- 		vim.fn.expand("$VIMRUNTIME"),
			-- 		get_lvim_base_dir(),
			-- 		require("neodev.config").types(),
			-- 		"${3rd}/busted/library",
			-- 		"${3rd}/luassert/library",
			-- 		"${3rd}/luv/library",
			-- 	},
			-- 	-- checkThirdParty = false,
			-- 	maxPreload = 5000,
			-- 	preloadFileSize = 10000,
			-- },
		},
	},
}

-- -- setup neodev single file mode for config.lua
-- local filename = vim.fn.expand("%:t")
-- if filename == "config.lua" then
-- 	local plugins_dir = get_runtime_dir() .. "/site/pack/lazy/opt"
-- 	opts.settings.Lua.workspace.library = {
-- 		plugins_dir .. "/neodev.nvim/types/stable",
-- 		vim.fn.expand("$VIMRUNTIME"),
-- 	}
-- end

require("lvim.lsp.manager").setup("lua_ls", opts)
