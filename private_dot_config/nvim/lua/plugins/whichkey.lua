return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		win = {
			border = "rounded",
		},
		sort = { "alphanum", "local", "order", "mod" },
		expand = 1,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.add({
			{ "<leader>b", group = "Buffers" },
			{ "<leader>g", group = "Git" },
			{ "<leader>s", group = "Search" },
			{ "<leader>l", group = "LSP", icon = "" },
			{
				"<leader>ld",
				vim.diagnostic.open_float,
				desc = "Open diagnostics",
			},
			{ "<leader>qa", "<cmd>qa<cr>",   desc = "Quit all" },
			{ "<leader>qq", "<cmd>q<cr>",    desc = "Quit" },
			{ "<leader>t",  group = "Toggle" },
			-- {
			-- 	"<leader>tD",
			-- 	"<cmd>Trouble diagnostics toggle<cr>",
			-- 	desc = "Workspace diagnostics",
			-- },
			{
				"<leader>td",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Toggle buffer diagnostics",
			},
			{ "<leader>ts",    "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>", desc = "Toggle symbols" },
			-- { "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
			{ "<leader>tq",    "<cmd>Trouble qflist toggle<cr>",                                                  desc = "Toggle quickfix" },
			-- { "<leader>tt", "<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo" },
			{ "<leader><tab>", group = "Tabs" },
			{
				"<leader>b?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer local keymaps",
			},
		})
		wk.setup(opts)
	end,
}
