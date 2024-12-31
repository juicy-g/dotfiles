return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = "User FileOpened",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "ruff", "stylua" },
				methods = {
					diagnostics = true,
					formatting = true,
					code_actions = true,
					completion = true,
					hover = true,
				},
				handlers = {},
			})
		end,
	},
}
