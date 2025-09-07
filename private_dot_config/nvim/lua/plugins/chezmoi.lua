return {
	{
		"xvzc/chezmoi.nvim",
		cmd = { "ChezmoiList", "ChezmoiEdit" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			edit = {
				watch = false,
				force = false,
			},
			events = {
				on_open = {
					notification = {
						enable = true,
						msg = "Opened a chezmoi-managed file",
						opts = {},
					},
				},
				on_watch = {
					notification = {
						enable = false,
						msg = "This file will be automatically applied",
						opts = {},
					},
				},
				on_apply = {
					notification = {
						enable = true,
						msg = "Successfully applied",
						opts = {},
					},
				},
			},
			telescope = {
				select = { "<CR>" },
			},
		},
	},
	{
		"alker0/chezmoi.vim",
		init = function()
			vim.g["chezmoi#use_tmp_buffer"] = true
			vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"
		end,
	},
}
