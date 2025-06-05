return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "javascript", "typescript", "markdown", "markdown_inline", "bash", "python" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"yorickpeterse/nvim-tree-pairs",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},
	{
		"mawkler/jsx-element.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		ft = { "typescriptreact", "javascriptreact", "javascript" },
		opts = {},
	}
}
