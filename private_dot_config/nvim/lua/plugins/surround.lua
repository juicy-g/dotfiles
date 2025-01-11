return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		dir = "~/repos/surround-ui.nvim",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		event = "VeryLazy",
		opts = {},
	},
}
