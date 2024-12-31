return {
	"amitds1997/remote-nvim.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
	},
	require("remote-nvim").setup({
		client_callback = function(port)
			local cmd = ("tmux new -s remote -d 'nvim --server localhost:%s --remote-ui'"):format(port)
			vim.fn.jobstart(cmd, {
				detach = true,
				on_exit = function(job_id, exit_code, event_type)
					if exit_code == 0 then
						print("Remote neovim session successfully started")
					else
						print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
					end
				end,
			})
		end,
	}),
}
