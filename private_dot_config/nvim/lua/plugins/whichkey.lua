return {
	"folke/which-key.nvim",
	event = "VeryLazy",
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
			{ "<leader>o", group = "Opencode", icon = "󰚩" },
			{ "<leader>qa", "<cmd>qa<cr>", desc = "Quit all" },
			{ "<leader>qq", "<cmd>q<cr>", desc = "Quit" },
			{ "<leader>t", group = "Toggle" },
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
			{
				"<leader>/",
				function()
					return require("vim._comment").operator() .. "_"
				end,
				desc = "Comment Line",
				icon = "󰊀",
				expr = true
			},
			{ "<leader>/", function() return require("vim._comment").operator() end, desc = "Comment Line", mode = "v", icon = "󰊀", expr = true },
		})
		wk.setup(opts)
	end,
}
