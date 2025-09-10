return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local _, actions = pcall(require, "telescope.actions")

		require("telescope").setup({
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				buffers = {
					initial_mode = "insert",
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
							["<Tab>"] = actions.move_selection_next,
							["<S-Tab>"] = actions.move_selection_previous,
							["<Esc>"] = actions.close,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "chezmoi")

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local wk = require("which-key")
		wk.add({
			{ "<leader>sc", "<cmd>Telescope chezmoi find_files<cr>", desc = "Search dotfiles" },
			{ "<leader>sh", builtin.help_tags, desc = "Search help" },
			{ "<leader>sk", builtin.keymaps, desc = "Search keymaps" },
			{ "<leader>f", builtin.find_files, desc = "Find files", icon = "󰱽" },
			{ "<leader>sb", builtin.builtin, desc = "Search telescope builtins" },
			{ "<leader>sw", builtin.grep_string, desc = "Search current word" },
			{ "<leader>st", builtin.live_grep, desc = "Search text" },
			{ "<leader>sd", builtin.diagnostics, desc = "Search diagnostics" },
			{ "<leader>r", builtin.resume, desc = "Resume search", icon = "" },
			{ "<leader>sr", builtin.registers, desc = "Search registers" },
			{ "<leader>sy", "<cmd>Telescope neoclip<cr>", desc = "Search last yanks" },
			{ "<leader>s.", builtin.oldfiles, desc = "Search recent files" },
			{ "<leader>bb", builtin.buffers, desc = "Buffers" },
			{
				"<leader>?",
				function()
					builtin.current_buffer_fuzzy_find(themes.get_dropdown({ previewer = true }))
				end,
				desc = "Find in buffer",
				icon = "",
			},
		})
	end,
}
