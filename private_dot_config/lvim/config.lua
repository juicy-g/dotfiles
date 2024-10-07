-- general options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.cmd('let g:tmuxline_separators = { "left": "", "left_alt": "", "right": "", "right_alt": "", "space": " "}')
vim.o.termguicolors = true
vim.opt.wrap = true
vim.opt.cursorline = false
lvim.colorscheme = "onedark"
lvim.log.level = "warn"
lvim.format_on_save = true

-- custom keymappings
lvim.keys.normal_mode["<C-s>"] = ":w<Cr>"
lvim.keys.insert_mode["<C-s>"] = "<Cmd>:w<Cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<Cr>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<Cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<Cr>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<Cr>"
lvim.keys.insert_mode["<C-c>"] = "<Esc>"

-- jump to buffers
lvim.keys.normal_mode["<leader>1"] = "<Cmd>lua require('bufferline').go_to(1, true)<Cr>"
lvim.keys.normal_mode["<leader>2"] = "<Cmd>lua require('bufferline').go_to(2, true)<Cr>"
lvim.keys.normal_mode["<leader>3"] = "<Cmd>lua require('bufferline').go_to(3, true)<Cr>"
lvim.keys.normal_mode["<leader>4"] = "<Cmd>lua require('bufferline').go_to(4, true)<Cr>"
lvim.keys.normal_mode["<leader>5"] = "<Cmd>lua require('bufferline').go_to(5, true)<Cr>"
lvim.keys.normal_mode["<leader>6"] = "<Cmd>lua require('bufferline').go_to(6, true)<Cr>"
lvim.keys.normal_mode["<leader>7"] = "<Cmd>lua require('bufferline').go_to(7, true)<Cr>"
lvim.keys.normal_mode["<leader>8"] = "<Cmd>lua require('bufferline').go_to(8, true)<Cr>"
lvim.keys.normal_mode["<leader>9"] = "<Cmd>lua require('bufferline').go_to(9, true)<Cr>"

-- keep searched word in the middle of the screen
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"

-- add empty lines before and after cursor line
lvim.keys.normal_mode["gO"] = "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>"
lvim.keys.normal_mode["go"] = "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>"

-- return cursor to previous location when cancelling from visual mode
-- doesn't work with wildfire.nvim so commented out for now
-- vim.keymap.set({ 'n' }, 'v', 'mav', { noremap = true })
-- vim.keymap.set({ 'n' }, 'V', 'maV', { noremap = true })
-- vim.keymap.set('v', '<Esc>', '<Esc>`a', { noremap = true, silent = true })

-- keymaps to jump between buffers
lvim.keys.normal_mode["]b"] = "<Cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = "<Cmd>BufferLineCyclePrev<CR>"

-- shows registers on " in NORMAL or <C-r> in INSERT mode
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.which_key.setup.plugins.presets = {
	operators = false, -- adds help for operators like d, y, ...
	motions = false, -- adds help for motions
	text_objects = true, -- help for text objects triggered after entering an operator
	windows = false, -- default bindings on <C-w>
	nav = false, -- misc bindings to work with windows
	z = true, -- bindings for folds, spelling and others prefixed with z
	g = true, -- bindings for prefixed with g
}

-- which_key remappings
lvim.builtin.which_key.mappings["e"] = { ":NvimTreeFocus<CR>", "Explorer" }
lvim.builtin.which_key.mappings["<Space>"] = {
	"<cmd>Telescope buffers<cr>",
	"Buffers list",
}
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	D = { "<cmd>Trouble diagnostics toggle<cr>", "Workspace Diagnostics" },
	d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics" },
	s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols" },
	c = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP" },
	l = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
	q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
	t = { "<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>", "Todo" },
}
lvim.builtin.which_key.mappings["bs"] = { "<cmd>BufferLinePick<cr>", "Pick a buffer" }
lvim.builtin.which_key.mappings["f"] = {
	"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<cr>",
	"Find File",
}

-- git-worktree mappings
lvim.builtin.which_key.mappings["gw"] =
	{ "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", "Git Worktrees" }
lvim.builtin.which_key.mappings["gW"] =
	{ "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", "Create Git Worktree" }
lvim.builtin.which_key.mappings["H"] = { "<cmd>nohlsearch<CR>", "No Highlight" }

-- add a sessions menu
lvim.builtin.which_key.mappings["P"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- additional pickers for search menu
lvim.builtin.which_key.mappings["se"] = { "<cmd>Telescope emoji<cr>", "Find emoji" }
lvim.builtin.which_key.mappings["s/"] = {
	function()
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown())
	end,
	"Fuzzily search in current buffer",
}
lvim.builtin.which_key.mappings["sl"] = {
	"<cmd>Telescope resume<cr>",
	"Last search",
}
lvim.builtin.which_key.mappings["ss"] = {
	"<cmd>Telescope grep_string<cr>",
	"Find current word",
}
lvim.builtin.which_key.mappings["sT"] = {
	"<cmd>TodoTelescope<cr>",
	"Find todos",
}
lvim.builtin.which_key.mappings["su"] = {
	"<cmd>Telescope undo<cr>",
	"Current buffer undo tree",
}
lvim.builtin.which_key.mappings["sy"] = {
	"<cmd>Telescope yank_history<cr>",
	"Yank history",
}

-- additional picker for treesitter menu
lvim.builtin.which_key.mappings["Ts"] = {
	function()
		require("telescope.builtin").treesitter()
	end,
	"Search Treesitter",
}

-- keymap to jump between illuminated words
lvim.builtin.illuminate.on_config_done = function()
	local function map(key, dir, buffer)
		vim.keymap.set("n", key, function()
			require("illuminate")["goto_" .. dir .. "_reference"](false)
		end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
	end

	map("]]", "next")
	map("[[", "prev")

	-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			local buffer = vim.api.nvim_get_current_buf()
			map("]]", "next", buffer)
			map("[[", "prev", buffer)
		end,
	})
end

-- show hidden files when opening a project
lvim.builtin.project.show_hidden = true
lvim.builtin.project.scope_chdir = "win"
lvim.builtin.lir.show_hidden_files = true

-- status line customization
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.options = { section_separators = "", component_separators = "" }
lvim.builtin.lualine.options.disabled_filetypes = { "alpha", "dashboard", "Outline" }

-- bufferline customization
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.indicator.style = "none"
lvim.builtin.bufferline.options.offsets = {
	{
		filetype = "NvimTree",
		text = "Explorer",
		separator = true,
	},
}

-- i don't like indentlines
lvim.builtin.indentlines.active = false

-- change the cmp menu order from the default
lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
lvim.builtin.cmp.completion = {
	scrollbar = false,
	completeopt = "menu,menuone,select,preview",
}

-- remove duplicates between lsp and buffer words
lvim.builtin.cmp.formatting.duplicates = {
	buffer = 0,
	path = 1,
	nvim_lsp = 0,
	luasnip = 1,
}

-- setup cmp for cmdline completion
lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.cmp.cmdline.options = {
	{
		type = { "/", "?" },
		sources = {},
	},
}
lvim.builtin.cmp.on_config_done = function(cmp)
	cmp.setup.cmdline(":", {
		completion = { completeopt = "menu,menuone,noselect" },
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "path" },
			{ name = "cmdline" },
		},
	})
end

-- complete entry selected in cmdline menu on <CR>
local _, cmp_types = pcall(require, "cmp.types.cmp")
local ConfirmBehavior = cmp_types.ConfirmBehavior
local cmp = require("lvim.utils.modules").require_on_index("cmp")
local cmp_mapping = require("cmp.config.mapping")

lvim.builtin.cmp.mapping["<CR>"] = cmp_mapping({
	-- this function is copied from Lunarvim's source code but changed to use Codeium
	i = function(fallback)
		if cmp.visible() then
			local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts)
			local is_insert_mode = function()
				return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
			end
			if is_insert_mode() then
				confirm_opts.behavior = ConfirmBehavior.Insert
			end
			-- local entry = cmp.get_selected_entry()
			-- local is_codeium = entry and entry.source.name == "codeium"
			-- if is_codeium then
			-- 	confirm_opts.behavior = ConfirmBehavior.Replace
			-- 	confirm_opts.select = true
			-- end
			if cmp.confirm(confirm_opts) then
				return
			end
		end
		fallback()
	end,
	-- this line adds the desired behavior for <CR>
	c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
})

-- add codeium as a completion source
table.insert(lvim.builtin.cmp.sources, { name = "codeium", max_item_count = 4 })
lvim.icons.kind["Codeium"] = ""
lvim.builtin.cmp.formatting.source_names["codeium"] = "(Codeium)"

-- add cmp-dotenv as a completion source
table.insert(lvim.builtin.cmp.sources, { name = "dotenv" })
lvim.builtin.cmp.formatting.source_names["dotenv"] = "(Dotenv)"

-- completion source for require statements and module annotations
table.insert(lvim.builtin.cmp.sources, { name = "lazydev", group_index = 0 })

-- TODO: fix <M-2> terminal size when nvim-tree open
lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.size = function(term)
	if term.direction == "horizontal" then
		return 15
	elseif term.direction == "vertical" then
		return vim.o.columns * 0.3
	end
end

-- add additional telescope mappings
local _, actions = pcall(require, "telescope.actions")
local _, trouble = pcall(require, "trouble.sources.telescope")
lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
		["<C-t>"] = trouble.open,
	},
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-t>"] = trouble.open,
	},
}
-- customize the telescope buffers picker
lvim.builtin.telescope.pickers.buffers = {
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
}

-- load telescope extensions
lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "undo")
	pcall(telescope.load_extension, "yank_history")
	pcall(telescope.load_extension, "emoji")
	pcall(telescope.load_extension, "git_worktree")
end

-- ignore these folders when searching
lvim.builtin.telescope.defaults.file_ignore_patterns = {
	".git/",
	"node_modules/",
	".next/",
}

-- add restore session button to dashboard
lvim.builtin.alpha.dashboard.section.buttons = {
	opts = {
		spacing = 1,
	},
	entries = {
		{ "f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>" },
		{ "n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>" },
		{ "p", lvim.icons.ui.Project .. "  Projects", "<CMD>Telescope projects<CR>" },
		{ "r", lvim.icons.ui.History .. "  Recent files", "<CMD>Telescope oldfiles<CR>" },
		{
			"s",
			lvim.icons.ui.BookMark .. "  Last session",
			"<CMD>lua require('persistence').load({ last = true })<CR>",
		},
		{
			"S",
			lvim.icons.ui.BookMark .. "  Last session for current directory",
			"<CMD>lua require('persistence').load()<CR>",
		},
		{ "t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>" },
		{
			"c",
			lvim.icons.ui.Gear .. "  Configuration",
			"<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
		},
		{ "q", lvim.icons.ui.Close .. "  Quit", "<CMD>quit<CR>" },
	},
}

lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"javascript",
	"json",
	"lua",
	"html",
	"ruby",
	"typescript",
	"tsx",
	"css",
	"yaml",
}

-- setup additional LSP servers
require("lvim.lsp.manager").setup("marksman")

-- skip automatic configuration for lua_ls to enable autoformatting
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "lua_ls" })
-- skip server configuration for typescript
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
-- skip server to use schemastore
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jsonls" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- extra plugins
lvim.plugins = {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {},
		},
	},
	{ "folke/neodev.nvim", enabled = false },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{
		"navarasu/onedark.nvim",
		config = function()
			local onedark = require("onedark")
			-- fix some border issues with telescope and LSP float windows
			onedark.setup({
				style = "darker",
				highlights = {
					TelescopePromptBorder = { fg = "#848b98" },
					TelescopeResultsBorder = { fg = "#848b98" },
					TelescopePreviewBorder = { fg = "#848b98" },
					FloatBorder = { bg = "#1f2329" },
					NormalFloat = { bg = "#1f2329" },
				},
			})
			onedark.load()
		end,
	},
	{ "SergioRibera/cmp-dotenv" },
	{ "edkolev/tmuxline.vim", lazy = true, cmd = "Tmuxline" },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
	{
		"roobert/surround-ui.nvim",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		-- temporary pin before which-key v3
		commit = "49a1f62",
		config = function()
			require("surround-ui").setup({
				root_key = "S",
			})
		end,
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		event = "InsertCharPre",
		priority = 1000,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function()
			local leap = require("leap")
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			require("persistence").setup({
				dir = require("lvim.utils").join_paths(get_config_dir(), "/sessions/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = true,
	},
	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		commit = "55e13ca",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["ak"] = "@block.outer",
							["ik"] = "@block.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["a?"] = "@conditional.outer",
							["i?"] = "@conditional.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
						goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
						goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
						goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = { query = "@parameter.inner", desc = "which_key_ignore" },
						},
						swap_previous = {
							["<leader>A"] = { query = "@parameter.outer", desc = "which_key_ignore" },
						},
					},
				},
			})
		end,
	},
	{ "debugloop/telescope-undo.nvim" },
	{
		"rmagatti/goto-preview",
		lazy = true,
		config = function()
			require("goto-preview").setup({
				width = 120,
				height = 25,
				border = "rounded",
				default_mappings = true,
				debug = false,
				opacity = nil,
				post_open_hook = function()
					vim.keymap.set(
						"n",
						"<Esc>",
						":lua require('goto-preview').close_all_win()<CR>",
						{ noremap = true, silent = true }
					)
					vim.keymap.set(
						"n",
						"<C-c>",
						":lua require('goto-preview').close_all_win()<CR>",
						{ noremap = true, silent = true }
					)
				end,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = false,
				stop_eof = true,
				use_local_scrolloff = false,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
			})
		end,
	},
	{
		"asiryk/auto-hlsearch.nvim",
		config = true,
	},
	{ "sitiom/nvim-numbertoggle" },
	{
		"max397574/better-escape.nvim",
		config = true,
	},
	{
		"Exafunction/codeium.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = true,
	},
	{ "kana/vim-textobj-user" },
	{
		"Julian/vim-textobj-variable-segment",
		dependencies = { "kana/vim-textobj-user" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup({
				highlight = {
					multiline = true,
					multiline_pattern = "^.",
					multiline_context = 10,
					before = "",
					keyword = "bg",
					after = "",
					pattern = [[.*<(KEYWORDS)\s*:]],
					comments_only = true,
					max_line_len = 400,
					exclude = {},
				},
			})
			vim.keymap.set("n", "]t", function()
				todo.jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				todo.jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},
	{ "xiyaowong/telescope-emoji.nvim" },
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			-- automatic setup of sources
			require("mason").setup()
			require("mason-null-ls").setup({
				handlers = {},
				ensure_installed = {},
				automatic_installation = false,
			})
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		config = true,
	},
	{
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				cut_key = "x",
				exclude = { "ns", "nS" },
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = true,
		keys = {
			{ "<LEADER>o", "<CMD>AerialToggle<CR>", desc = "Code Outline" },
		},
	},
	{
		"lmburns/lf.nvim",
		cmd = "Lf",
		dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
		opts = {
			winblend = 0,
			highlights = { NormalFloat = { guibg = "NONE" } },
			border = "single",
			escape_quit = true,
		},
		keys = {
			{ "<leader>F", "<cmd>Lf<cr>", desc = "File Manager" },
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"microsoft/vscode-js-debug",
		version = "1.x",
		build = "npm ci && npx gulp dapDebugServer",
	},
	{
		"firefox-devtools/vscode-firefox-debug",
		version = "2.x",
		build = "npm ci && npm run build",
	},
	{
		"chrisgrieser/nvim-spider",
		config = true,
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
		},
	},
	{ "ThePrimeagen/git-worktree.nvim" },
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = require("lvim.lsp").common_on_attach,
				},
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
			}
		end,
	},
	{
		dir = "~/projects/devdocs.nvim",
		opts = {
			url = "http://localhost:9292",
		},
	},
}

-- setup debugging
lvim.builtin.dap.on_config_done = function(dap)
	for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge" }) do
		dap.adapters[adapter] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					get_runtime_dir() .. "/site/pack/lazy/opt/vscode-js-debug/dist/src/dapDebugServer.js",
					"${port}",
				},
			},
		}
	end

	dap.adapters["firefox"] = {
		type = "executable",
		command = "node",
		args = { get_runtime_dir() .. "/site/pack/lazy/opt/vscode-firefox-debug/dist/adapter.bundle.js" },
	}

	for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "(Launch) Next.js: Debug Server Code",
				program = "${workspaceFolder}/node_modules/.bin/next",
				args = { "dev" },
				sourceMaps = true,
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				cwd = "${workspaceFolder}",
				outputCapture = "std",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
			},
			-- {
			--   type = 'pwa-node',
			--   request = 'attach',
			--   name = '(Attach) Auto-Attach to Node Process with --inspect Flag',
			--   protocol = 'inspector',
			--   -- processId = require 'dap.utils'.pick_process,
			--   sourceMaps = true,
			--   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
			--   cwd = '${workspaceFolder}',
			--   skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
			-- },
			-- {
			--   type = 'pwa-chrome',
			--   request = 'launch',
			--   name = '(Launch) Chrome to Debug Client Code on localhost:3000',
			--   runtimeExecutable = '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe',
			--   port = 9222,
			--   sourceMaps = true,
			--   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
			--   url = 'http://localhost:3000',
			--   webRoot = '${workspaceFolder}',
			--   skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
			--   outputCapture = 'std',
			-- },
			-- {
			--   type = 'pwa-msedge',
			--   request = 'launch',
			--   name = '(Launch) Edge to Debug Client Code on localhost:3000',
			--   runtimeExecutable = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe',
			--   port = 9222,
			--   sourceMaps = true,
			--   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
			--   url = 'http://localhost:3000',
			--   webRoot = '${workspaceFolder}',
			--   skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
			--   outputCapture = 'std',
			-- },
			-- {
			--   type = 'firefox',
			--   request = 'launch',
			--   name = 'Launch Firefox to debug client side code',
			--   url = 'http://localhost:3000',
			--   firefoxExecutable = '/mnt/c/Program Files/Mozilla Firefox/firefox.exe',
			--   -- firefoxArgs = { '--start-debugger-server' },
			--   -- firefoxArgs = { '-P', '%APPDATA%/profiles/default' },
			--   profileDir = '/mnt/c/Users/joce_/AppData/Roaming/Mozilla/Firefox/Profiles/qj1xsd22.default-release',
			--   -- profile = 'default-release',
			--   tmpDir = os.getenv 'HOME' .. '/tmp/firefox-debug',
			--   sourceMaps = true,
			--   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
			--   webRoot = '${workspaceFolder}',
			--   port = 9222,
			--   skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
			--   -- log = {
			--   --   file = '/home/juicy/.cache/lvim/vscode-firefox-debug.log',
			--   --   fileLevel = {
			--   --     default = 'Debug'
			--   --   }
			--   -- }
			-- }
		}
	end
end

lvim.autocommands = {
	{
		"ColorScheme",
		{
			pattern = "*",
			callback = function()
				-- fix lspinfo float window border
				vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#848b98", bg = "#1f2329" })
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#30363f" })
				vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#30363f" })
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#30363f" })
				vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { underline = false })
				-- fix vert split color in bufferline
				vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { bg = "#1f2329", fg = "#323641" })
				-- fix winbar when not in window
				vim.api.nvim_set_hl(0, "WinbarNC", { bg = "#1f2329" })
			end,
		},
	},
	-- set line numbers in telescope preview window
	{ "User", { pattern = { "TelescopePreviewerLoaded" }, command = "setlocal number" } },
	-- autosave when leaving the buffer
	{
		{ "BufLeave", "FocusLost" },
		{
			pattern = "*",
			callback = function()
				if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
					vim.cmd("silent! w")
				end
			end,
		},
	},
	-- quit lvim when nvimtree is only left open
	{
		"QuitPre",
		{
			pattern = "*",
			callback = function()
				local invalid_win = {}
				local wins = vim.api.nvim_list_wins()
				for _, w in ipairs(wins) do
					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
					if bufname:match("NvimTree_") ~= nil then
						table.insert(invalid_win, w)
					end
				end
				if #invalid_win == #wins - 1 then
					-- Should quit, so we close all invalid windows.
					for _, w in ipairs(invalid_win) do
						vim.api.nvim_win_close(w, true)
					end
				end
			end,
		},
	},
	{
		"VimLeave",
		{
			pattern = "*",
			callback = function()
				local utils = require("lvim.utils")
				local path = utils.join_paths(vim.fn.getcwd(), "Session.vim")
				if not utils.is_file(path) then
					utils.write_file(path, "lua require('persistence').load()", "w")
				end
			end,
		},
	},
}
