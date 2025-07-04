return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
		"SergioRibera/cmp-dotenv",
		"onsails/lspkind.nvim",
		"xzbdmw/colorful-menu.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")
		require("luasnip/loaders/from_vscode").lazy_load()

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		cmp.setup({
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,select,preview",
			},
			sources = {
				{
					name = "lazydev",
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "codeium" },
				{ name = "dotenv" },
			},
			formatting = {
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
						mode = "symbol_text",
						symbol_map = { Codeium = "" },
					})(entry, vim.deepcopy(vim_item))
					local highlights_info = require("colorful-menu").cmp_highlights(entry)

					if highlights_info ~= nil then
						vim_item.abbr_hl_group = highlights_info.highlights
						vim_item.abbr = highlights_info.text
					end
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					vim_item.kind = " " .. (strings[1] or "") .. " "
					vim_item.menu = ""

					return vim_item
				end,
				duplicates = {
					buffer = 1,
					path = 1,
					nvim_lsp = 0,
					luasnip = 1,
				},
				duplicates_default = 0,
				fields = { "abbr", "kind", "menu" },
			},
			window = {
				completion = {
					border = "rounded",
					scrollbar = false,
					winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
				},
				documentation = {
					border = "rounded",
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand({})
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand({})
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline({
				["<CR>"] = {
					c = function()
						if cmp.visible() then
							cmp.confirm({ select = false })
						end

						local cr = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
						vim.api.nvim_feedkeys(cr, "n", true)
					end,
				},
			}),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			completion = {
				completeopt = "menu,menuone,noselect"
			},
			mapping = cmp.mapping.preset.cmdline({
				["<CR>"] = {
					c = function()
						if cmp.visible() then
							cmp.confirm({ select = false })
						end

						local cr = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
						vim.api.nvim_feedkeys(cr, "n", true)
					end,
				},
			}),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
