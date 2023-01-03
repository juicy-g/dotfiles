-- general options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = true
vim.opt.cursorline = false
lvim.format_on_save = true
lvim.colorscheme = "onedark"
lvim.log.level = "warn"

-- custom keymappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.insert_mode["<C-c>"] = "<Esc>"

-- keep searched word in the middle of the screen
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"

-- keep yanked word in the last register when pasting
lvim.builtin.which_key.mappings["p"] = {}
vim.keymap.set("x", "<leader>p", [["_dP]])
-- remap p to P for the remap above to work
lvim.builtin.which_key.mappings["P"] = {
  name = "Packer",
  c = { "<cmd>PackerCompile<cr>", "Compile" },
  i = { "<cmd>PackerInstall<cr>", "Install" },
  r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
  s = { "<cmd>PackerSync<cr>", "Sync" },
  S = { "<cmd>PackerStatus<cr>", "Status" },
  u = { "<cmd>PackerUpdate<cr>", "Update" },
}

-- delete to void register
lvim.builtin.which_key.mappings["d"] = {}
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- remap d to D for the remap above to work
lvim.builtin.which_key.mappings["D"] = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
}

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
-- i don't like indentlines
lvim.builtin.indentlines.active = false
lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
-- preselect the first suggestion
lvim.builtin.cmp.completion = {
  completeopt = "menu,menuone,preview"
}

-- enable telescope file preview in horizontal layout
lvim.builtin.telescope.pickers.find_files = {
  layout_strategy = "horizontal",
}
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
}

-- add additional mappings
local _, actions = pcall(require, "telescope.actions")
local _, trouble = pcall(require, "trouble.providers.telescope")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-t>"] = trouble.open_with_trouble,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-t>"] = trouble.open_with_trouble,
  },
}

-- load telescope extensions
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "undo")
end

-- change to use the find_files picker rather than git_files
lvim.builtin.which_key.mappings["f"] = {
  "<cmd>Telescope find_files<cr>", "Find File"
}

-- additional pickers for search menu
lvim.builtin.which_key.mappings["s/"] = {
  function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
  end,
  "Fuzzily search in current buffer"
}
lvim.builtin.which_key.mappings["sl"] = {
  "<cmd>Telescope resume<cr>", "Last search"
}
lvim.builtin.which_key.mappings["su"] = {
  "<cmd>Telescope undo<cr>", "Current buffer undo tree"
}

-- additional picker for treesitter menu
lvim.builtin.which_key.mappings["Ts"] = {
  function()
    require('telescope.builtin').treesitter()
  end,
  "Search Treesitter"
}

-- add sessions menu
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

-- enhanced selections
lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
}

-- smart selection in visual mode
lvim.builtin.treesitter.textsubjects.enable = true
lvim.builtin.treesitter.textsubjects.keymaps = {
  ["<CR>"] = "textsubjects-smart"
}

-- fix lspinfo popup border
require("lspconfig.ui.windows").default_options.border = "rounded"

-- setup additional LSP servers
require("lvim.lsp.manager").setup("marksman")

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
      require('leap').add_default_mappings()
    end
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
    end
  },
  { "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup({
        bind = true,
        hint_enable = false,
        hi_parameter = "NONE"
      })
    end
  },
  { "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end
  },
  { "hrsh7th/cmp-cmdline",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'c' }),
          ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
          ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        }),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline',
            option = {
              ignore_cmds = { 'q', 'qall', 'quit', 'quitall', 'Man', '!' }
            }
          }
        })
      })
    end
  },
  { "jayp0521/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
      require("mason-null-ls").setup_handlers()
    end
  },
  { "tversteeg/registers.nvim",
    config = function()
      require("registers").setup({
        window = {
          border = "rounded",
          transparency = 0
        }
      })
    end
  },
  { "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  { "RRethy/nvim-treesitter-textsubjects" },
  { "nvim-treesitter/nvim-treesitter-textobjects",
    -- see pull #346
    commit = "aba3ab3"
  },
  { "debugloop/telescope-undo.nvim" },
  { "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        width = 120,
        height = 25,
        border = "rounded",
        default_mappings = true,
        debug = false,
        opacity = nil,
        post_open_hook = function()
          vim.keymap.set("n", "<ESC>", ":lua require('goto-preview').close_all_win()<CR>",
            { noremap = true, silent = true })
          vim.keymap.set("n", "<C-c>", ":lua require('goto-preview').close_all_win()<CR>",
            { noremap = true, silent = true })
        end
      }
    end
  },
  { "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end
  },
  { "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
}

lvim.autocommands = {
  { "ColorScheme",
    { pattern = "*",
      callback = function()
        -- customization for vim-illuminate
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#31353f", underline = false, bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#31353f", underline = false, bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#31353f", underline = false, bold = true })
        -- fix lspinfo float window border
        vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#848b98", bg = "#282c34" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { underline = false })
      end,
    }
  },
  -- set line numbers in telescope preview window
  { "User",
    { pattern = { "TelescopePreviewerLoaded" }, command = "setlocal number" }
  }
}
