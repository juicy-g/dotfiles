return {
	{
		"chrisgrieser/nvim-spider",
		config = true,
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
		},
	},
	{
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				cut_key = "x",
				exclude = { "ns", "nS" },
			})
		end,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = true,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = false,
				stop_eof = true,
				use_local_scrolloff = false,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
			})
		end,
	},
	{
		"sustech-data/wildfire.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			-- bi-directional leap
			vim.keymap.set({ "n", "x", "o" }, "s", "<plug>(leap)", { desc = "Leap" })
			vim.keymap.set("n", "S", "<plug>(leap-from-window)", { desc = "Leap from window" })

			-- incremental treesitter node selection
			vim.keymap.set({ "n", "x", "o" }, "ga", function()
				require("leap.treesitter").select()
			end, { desc = "Incremental node selection" })

			-- linewise
			vim.keymap.set(
				{ "n", "x", "o" },
				"gA",
				'V<cmd>lua require("leap.treesitter").select()<cr>',
				{ desc = "Incremental linewise node selection" }
			)

			-- remap gs for remote operation
			vim.keymap.set({ "n", "o" }, "gs", function()
				require("leap.remote").action()
			end, { desc = "Leap remote operation" })

			-- remote operations with search commands
			vim.keymap.set({ "n", "o" }, "g/", function()
				require("leap.remote").action { jumper = "/" }
			end)
			vim.keymap.set({ "n", "o" }, "g?", function()
				require("leap.remote").action { jumper = "?" }
			end)

			-- preview filter to reduce visual noise and the blinking effect after the first keypress
			require("leap").opts.preview_filter =
					function(ch0, ch1, ch2)
						return not (
							ch1:match("%s") or
							ch0:match("%a") and ch1:match("%a") and ch2:match("%a")
						)
					end

			-- equivalence classes for brackets and quotes
			require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", '\'"`' }
		end,
	},
	{
		"asiryk/auto-hlsearch.nvim",
		config = true,
		event = { "BufReadPost", "BufNewFile" },
	},
	{ "sitiom/nvim-numbertoggle", event = "InsertEnter" },
	{
		"abecodes/tabout.nvim",
		opts = {},
		event = "InsertEnter",
	},
	{
		"nmac427/guess-indent.nvim",
		config = true,
		event = "BufRead",
	},
	{
		"mawkler/refjump.nvim",
		event = "LspAttach",
		opts = {}
	}
}
