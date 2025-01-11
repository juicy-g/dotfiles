return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
			local nvimTreeFocusOrToggle = function()
				local nvimTree = require("nvim-tree.api")
				local currentBuf = vim.api.nvim_get_current_buf()
				local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
				if currentBufFt == "NvimTree" then
					nvimTree.tree.toggle()
				else
					nvimTree.tree.focus()
				end
			end
			local wk = require("which-key")
			wk.add({
				{ "<leader>e", nvimTreeFocusOrToggle, desc = "Explorer", icon = "" },
			})
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
			local api = require("nvim-tree.api")
			api.events.subscribe(api.events.Event.FileCreated, function(file)
				vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
			end)
		end,
	},
}
