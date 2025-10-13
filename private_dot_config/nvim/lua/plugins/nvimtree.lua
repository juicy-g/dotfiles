return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"b0o/nvim-tree-preview.lua",
				dependencies = {
					"nvim-lua/plenary.nvim"
				}
			}
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					cursorline = false,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					api.config.mappings.default_on_attach(bufnr)

					local function opts(desc)
						return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
					end

					local preview = require("nvim-tree-preview")

					vim.keymap.set("n", "P", preview.watch, opts "Preview (Watch)")
					vim.keymap.set("n", "<Esc>", preview.unwatch, opts "Close Preview/Unwatch")
					vim.keymap.set("n", "<C-f>", function() return preview.scroll(4) end, opts "Scroll Down")
					vim.keymap.set("n", "<C-b>", function() return preview.scroll(-4) end, opts "Scroll Up")

					vim.keymap.set("n", "<Tab>", function()
						local ok, node = pcall(api.tree.get_node_under_cursor)
						if ok and node then
							if node.type == "directory" then
								api.node.open.edit()
							else
								preview.node(node, { toggle_focus = true })
							end
						end
					end, opts "Preview")
				end,
			})

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
