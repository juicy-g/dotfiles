return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
						border = "rounded"
					}
				}
			}
		},
		{
			"mawkler/refjump.nvim",
			keys = { "]r", "[r" },
			opts = {},
		},
		{
			"VidocqH/lsp-lens.nvim",
			opts = {
				enable = false,
				sections = {
					definition = false,
					references = true,
					implements = true,
					git_authors = false,
				},
			},
		},
		{
			"Sebastian-Nielsen/better-type-hover",
			ft = { "typescript", "typescriptreact" },
			opts = {}
		}
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover", buffer = event.buf })
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>lua vim.lsp.buf.definition()<cr>",
					{ desc = "Go to definition", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"gD",
					"<cmd>lua vim.lsp.buf.declaration()<cr>",
					{ desc = "Go to declaration", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>lua vim.lsp.buf.implementation()<cr>",
					{ desc = "Go to implementation", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"<leader>gy",
					"<cmd>lua vim.lsp.buf.type_definition()<cr>",
					{ desc = "Go to type definition", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"gr",
					require("telescope.builtin").lsp_references,
					{ desc = "Find references", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"<leader>ls",
					"<cmd>lua vim.lsp.buf.signature_help()<cr>",
					{ desc = "Signature help", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"gl",
					"<cmd>lua vim.diagnostic.open_float()<cr>",
					{ desc = "Diagnostics open float", buffer = event.buf }
				)
				vim.keymap.set("n", "<leader>tl", "<cmd>LspLensToggle<cr>", { desc = "Toggle LSP lens" })
				vim.keymap.set(
					"n",
					"<leader>lr",
					"<cmd>lua vim.lsp.buf.rename()<cr>",
					{ desc = "Rename", buffer = event.buf }
				)
				vim.keymap.set(
					{ "n", "v" },
					"<leader>la",
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					{ desc = "Code Action" }
				)

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Highlight word under cursor
				if client and client:supports_method("textDocument/documentHighlight") then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Setup inlay hints if supported
				if client ~= nil and client:supports_method("textDocument/inlayHint", event.buf) then
					vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, { desc = "Toggle inlay hints", buffer = event.buf })
				end
			end,
		})

		-- Diagnostics config
		local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
		local diagnostic_signs = {}
		for type, icon in pairs(signs) do
			diagnostic_signs[vim.diagnostic.severity[type]] = icon
		end
		vim.diagnostic.config({
			severity_sort = true,
			virtual_text = true,
			signs = { text = diagnostic_signs },
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		-- Add borders around all popups and windows
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		--- @diagnostic disable-next-line: duplicate-set-field, redefined-local
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = "rounded"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
					runtime = {
						version = "LuaJIT",
						special = {
							reload = "require",
						},
					},
					diagnostics = {
						disable = { "undefined-global", "missing-fields" },
					},
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
							quote_style = "double",
						},
					},
				},
			}
		})

		vim.lsp.config("pylsp", {
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						autopep8 = {
							enabled = false,
						},
						pycodestyle = {
							enabled = false,
						},
						mccabe = {
							enabled = false,
						},
						pyflakes = {
							enabled = false,
						},
						yapf = {
							enabled = false,
						},
						flake8 = {
							enabled = false,
						},
					},
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "pylsp", "rust_analyzer" },
			automatic_enable = { "lua_ls", "pylsp" },
		})
	end,
}
