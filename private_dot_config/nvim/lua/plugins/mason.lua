return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pylsp", "rust_analyzer", "ts_ls", "tombi" },
		automatic_enable = {
			exclude = {
				"rust_analyzer",
			}
		}
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					border = "rounded",
					backdrop = 100
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
}
