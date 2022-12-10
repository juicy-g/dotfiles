-- general vim options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.opt.wrap = true

-- general lvim options
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedark"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- trouble keymappings
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- core plugins configs
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- enable telescope file preview in horizontal layout
lvim.builtin.telescope.pickers = nil
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
}
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.which_key.mappings["f"] = {
  "<cmd>Telescope find_files<cr>", "Find File"
}

-- use eslint for formatting and linting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "eslint", filetypes = { "javascript", "javascriptreact" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "javascript", "javascriptreact" } },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { command = "eslint", filetypes = { "javascript", "javascriptreact" } },
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- extra plugins
lvim.plugins = {
  { "navarasu/onedark.nvim" },
  { "edkolev/tmuxline.vim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "ggandor/leap.nvim" }
}

-- use default leap.nvim keybindings
require('leap').add_default_mappings()
