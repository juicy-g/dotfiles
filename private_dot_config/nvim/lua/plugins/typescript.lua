return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
	config = function()
		local api = require("typescript-tools.api")
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "Format on save",
			group = Format,
			pattern = { "*.ts", "*.tsx", "*.jsx", "*.js" },
			callback = function(args)
				if not vim.g.autoformat then
					return
				end
				api.organize_imports(true)
				require("conform").format({ bufnr = args.buf })
			end,
		})
		require("typescript-tools").setup({
			on_attach = function()
				vim.keymap.set(
					"n",
					"<leader>Tr",
					"<cmd>TSToolsRenameFile<cr>",
					{ desc = "Rename file", group = "Typescript" }
				)
			end,
			settings = {
				expose_as_code_action = "all",
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayVariableTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					includeCompletionsForModuleExports = true,
					quotePreference = "single",
				},
				tsserver_format_options = {
					semicolons = "remove",
				},
			},
			handlers = {
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80001 }),
			},
		})
	end,
}
