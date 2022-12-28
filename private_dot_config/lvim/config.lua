-- general options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = true
vim.opt.cursorline = false
vim.opt.hlsearch = false
lvim.format_on_save = true
lvim.colorscheme = "onedark"

-- custom keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.insert_mode["<C-c>"] = "<Esc>"

-- centers cursor when moving 1/2 page down/up
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- keep searched word in the middle of the screen
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"

-- keep yanked word in the last register when pasting
vim.keymap.set("x", "pk", [["_dP]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "dv", [["_d]])

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
lvim.builtin.cmp.cmdline.enable = true
-- fix issue cmdline completion not showing
lvim.builtin.cmp.cmdline.options = {
  { type = { ":" },
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  },
  { type = { "/", "?" },
    sources = {
      { name = "buffer" },
    },
  },
}
lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
lvim.builtin.cmp.confirm_opts.select = true

-- enable telescope file preview in horizontal layout
lvim.builtin.telescope.pickers = nil
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
}

local _, actions = pcall(require, "telescope.actions")
local _, trouble = pcall(require, "trouble.providers.telescope")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-t>"] = trouble.open_with_trouble,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-t>"] = trouble.open_with_trouble,
  },
}
-- change to use the find_files picker rather than git_files
lvim.builtin.which_key.mappings["f"] = {
  "<cmd>Telescope find_files<cr>", "Find File"
}

-- add sessions keymaps to which_key window
lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- add restore session button to dashboard
lvim.builtin.alpha.dashboard.section.buttons = {
  opts = {
    hl_shortcut = "Include",
    spacing = 1,
  },
  entries = {
    { "f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>" },
    { "n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>" },
    { "p", lvim.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>" },
    { "r", lvim.icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>" },
    { "s", lvim.icons.ui.BookMark .. "  Restore session",
      "<cmd>lua require('persistence').load({ last = true })<cr>" },
    { "t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>" },
    { "c",
      lvim.icons.ui.Gear .. "  Configuration",
      "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>", },
  },
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "ruby",
  "typescript",
  "tsx",
  "css",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- extra plugins
lvim.plugins = {
  { "navarasu/onedark.nvim",
    config = function()
      -- fix some border issues with telescope and LSP float windows
      require('onedark').setup({
        highlights = {
          TelescopePromptBorder = { fg = '#848b98' },
          TelescopeResultsBorder = { fg = '#848b98' },
          TelescopePreviewBorder = { fg = '#848b98' },
          FloatBorder = { bg = '#282c34' },
          NormalFloat = { bg = '#282c34' }
        }
      })
      require('onedark').load()
    end,
  },
  { "edkolev/tmuxline.vim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  { "ethanholz/nvim-lastplace",
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
  { "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup({
        bind = true,
        hint_enable = false,
        hi_parameter = "NONE"
      })
    end,
  },
  { "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  { "hrsh7th/cmp-cmdline" },
  { "jayp0521/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
      require("mason-null-ls").setup_handlers()
    end,
  },
  { "tversteeg/registers.nvim",
    config = function()
      require("registers").setup({
        window = {
          border = "rounded",
          transparency = 0
        }
      })
    end,
  },
  { "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

-- customization for vim-illuminate
lvim.autocommands = {
  { "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordText gui=NONE guibg=#31353f",
    }
  },
  { "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordRead gui=NONE guibg=#31353f",
    }
  },
  { "BufEnter",
    {
      pattern = { "*" },
      command = "hi IlluminatedWordWrite gui=NONE guibg=#31353f",
    }
  }
}
