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
		vim.keymap.set("n", "<leader>sc", "<cmd>Telescope chezmoi find_files<cr>", { desc = "Search dotfiles" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "Search telescope builtins" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Search text" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
		vim.keymap.set("n", "<leader>r", builtin.resume, { desc = "Resume search" })
		vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "Search registers" })
		vim.keymap.set("n", "<leader>sy", "<cmd>Telescope neoclip<cr>", { desc = "Search last yanks" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>?", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				previewer = true,
			}))
		end, { desc = "Find in buffer" })
	end,
}
