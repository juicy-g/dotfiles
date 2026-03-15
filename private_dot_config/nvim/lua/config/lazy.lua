local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	---@diagnostic disable-next-line: assign-type-mismatch
	dev = {
		---@type string | fun(plugin: LazyPlugin): string
		path = "~/repos",
		---@type string[]
		patterns = { "juicy-g" },
		fallback = true,
	},
	install = {
		colorscheme = { "tokyonight-storm" },
	},
	ui = {
		border = "rounded",
		backdrop = 100,
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lsp")
