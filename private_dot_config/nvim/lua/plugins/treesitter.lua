return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
		version = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "javascript", "typescript", "markdown", "markdown_inline", "bash", "python" },
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "tmux" }
			},
			indent = { enable = true },
			folds = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					vim.treesitter.start()
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
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
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		opts = {
			keymaps = {
				useDefaults = true
			}
		},
	},
}
