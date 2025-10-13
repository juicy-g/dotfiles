return {
	"amitds1997/remote-nvim.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local utils = require("remote-nvim.utils")
		local constants = require("remote-nvim.constants")

		require("remote-nvim").setup({
			devpod = {
				binary = "devpod",                                                                                            -- Binary to use for devpod
				docker_binary = "podman",                                                                                     -- Binary to use for docker-related commands
				---@diagnostic disable-next-line:param-type-mismatch
				ssh_config_path = utils.path_join(utils.is_windows, vim.fn.stdpath("data"), constants.PLUGIN_NAME, "ssh_config"), -- Path where devpod SSH configurations should be stored
				search_style = "current_dir_only",                                                                            -- How should devcontainers be searched
				-- For dotfiles, see https://devpod.sh/docs/developing-in-workspaces/dotfiles-in-a-workspace for more information
				dotfiles = {
					path = nil,                -- Path to your dotfiles which should be copied into devcontainers
					install_script = nil       -- Install script that should be called to install your dotfiles
				},
				gpg_agent_forwarding = false, -- Should GPG agent be forwarded over the network
				container_list = "running_only", -- How should docker list containers ("running_only" or "all")
			},
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
		})
	end,
}
