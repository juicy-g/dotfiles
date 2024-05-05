return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})
		local wk = require("which-key")
		wk.register({
			["<leader>e"] = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
		})
	end,
}
