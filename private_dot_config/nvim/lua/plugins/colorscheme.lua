return {
	"navarasu/onedark.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local onedark = require("onedark")
		onedark.setup({
			style = "darker",
			-- highlights = {
			-- 	TelescopePromptBorder = { fg = "#848b98" },
			-- 	TelescopeResultsBorder = { fg = "#848b98" },
			-- 	TelescopePreviewBorder = { fg = "#848b98" },
			-- 	FloatBorder = { bg = "#1f2329" },
			-- 	NormalFloat = { bg = "#1f2329" },
			-- },
		})
		onedark.load()
	end,
}
