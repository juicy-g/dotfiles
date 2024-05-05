vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"floaterm",
		"lspinfo",
		"lir",
		"lsp-installer",
		"null-ls-info",
		"tsplayground",
		"DressingSelect",
		"Jaq",
	},
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
		vim.opt_local.buflisted = false
	end,
})
