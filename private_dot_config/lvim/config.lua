-- general vim options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.opt.wrap = true
vim.opt.cursorline = false
vim.opt.hlsearch = false

-- general lvim options
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedark"
lvim.reload_config_on_save = true

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
lvim.builtin.indentlines.active = false

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
-- change to use the find_files picker rather than git_files
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
  { "navarasu/onedark.nvim",
    config = function()
      -- fix some border issues with telescope and LSP float windows
      require('onedark').setup {
        highlights = {
          TelescopePromptBorder = { fg = '#848b98' },
          TelescopeResultsBorder = { fg = '#848b98' },
          TelescopePreviewBorder = { fg = '#848b98' },
          FloatBorder = { bg = '#282c34' },
          NormalFloat = { bg = '#282c34' }
        }
      }
      require('onedark').load()
    end
  },
  { "edkolev/tmuxline.vim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "ggandor/leap.nvim",
    config = function()
      -- use default leap.nvim keybindings
      require('leap').add_default_mappings()
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup({
        bind = true,
        hint_enable = false,
        hi_parameter = "NONE"
      })
    end,
  },
}

-- customization for vim-illuminate
lvim.autocommands = {
  {
    "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordText gui=NONE guibg=#31353f",
    }
  },
  {
    "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordRead gui=NONE guibg=#31353f",
    }
  },
  {
    "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordWrite gui=NONE guibg=#31353f",
    }
  }
}
