-- general options
vim.cmd('let g:tmuxline_powerline_separators = 0')
vim.cmd('let g:tmuxline_separators = { "left": "", "left_alt": "", "right": "", "right_alt": "", "space": " "}')
vim.opt.wrap = true
vim.opt.cursorline = false
lvim.colorscheme = 'onedark'
lvim.log.level = 'warn'
lvim.format_on_save = true
lvim.builtin.illuminate.active = false

-- status line customization
lvim.builtin.lualine.style = 'lvim'
lvim.builtin.lualine.options = { section_separators = '', component_separators = '' }
lvim.builtin.lualine.options.disabled_filetypes = { 'alpha', 'dashboard', 'Outline' }

-- custom keymappings
lvim.keys.normal_mode['<C-s>'] = ':w<Cr>'
lvim.keys.insert_mode['<C-s>'] = '<Cmd>:w<Cr>'
lvim.keys.normal_mode['<C-q>'] = ':q<Cr>'
lvim.keys.normal_mode['<S-x>'] = ':BufferKill<Cr>'
lvim.keys.normal_mode['<S-l>'] = ':BufferLineCycleNext<Cr>'
lvim.keys.normal_mode['<S-h>'] = ':BufferLineCyclePrev<Cr>'
lvim.keys.insert_mode['<C-c>'] = '<Esc>'

-- keep searched word in the middle of the screen
lvim.keys.normal_mode['n'] = 'nzzzv'
lvim.keys.normal_mode['N'] = 'Nzzzv'

-- return cursor to previous location when cancelling from visual mode
vim.keymap.set({ 'n' }, 'v', 'mav', { noremap = true })
vim.keymap.set({ 'n' }, 'V', 'maV', { noremap = true })
vim.keymap.set('v', '<Esc>', '<Esc>`a', { noremap = true, silent = true })

-- keymaps for yanky.nvim
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')

-- shows registers on " in NORMAL or <C-r> in INSERT mode
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.which_key.setup.plugins.presets = {
  operators = false,   -- adds help for operators like d, y, ...
  motions = false,     -- adds help for motions
  text_objects = true, -- help for text objects triggered after entering an operator
  windows = false,     -- default bindings on <c-w>
  nav = false,         -- misc bindings to work with windows
  z = false,           -- bindings for folds, spelling and others prefixed with z
  g = true,            -- bindings for prefixed with g
}

-- delete to void register
lvim.builtin.which_key.mappings['d'] = {}
lvim.keys.visual_block_mode['<leader>d'] = '"_d'
-- keep yanked word in the last register when pasting
lvim.builtin.which_key.mappings['p'] = {}
lvim.keys.visual_block_mode['<leader>p'] = '"_dP'

-- which_key remappings
lvim.builtin.which_key.mappings['e'] = { ':NvimTreeFocus<CR>', 'Explorer' }
lvim.builtin.which_key.mappings['<Space>'] = {
  '<cmd>Telescope buffers<cr>', 'Buffers List'
}
lvim.builtin.which_key.mappings['D'] = {
  name = 'Debug',
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
  b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
  c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor' },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
  g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
  i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
  o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
  u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
  p = { "<cmd>lua require'dap'.pause()<cr>", 'Pause' },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
  s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
  q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
  U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", 'Toggle UI' },
}
lvim.builtin.which_key.mappings['t'] = {
  name = 'Trouble',
  t = { '<cmd>TroubleToggle<cr>', 'trouble' },
  w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace' },
  d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'document' },
  q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
  l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
  r = { '<cmd>TroubleToggle lsp_references<cr>', 'references' },
}
lvim.builtin.which_key.mappings['bs'] = { '<cmd>BufferLinePick<cr>', 'Pick a buffer' }
lvim.builtin.which_key.mappings['f'] = {
  '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>',
  'Find File',
}
lvim.builtin.which_key.mappings['F'] = {
  '<cmd>Telescope file_browser<cr>', 'File Browser'
}
-- additional pickers for search menu
lvim.builtin.which_key.mappings['se'] = { '<cmd>Telescope emoji<cr>', 'Find emoji' }
lvim.builtin.which_key.mappings['s/'] = {
  function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
  end,
  'Fuzzily search in current buffer'
}
lvim.builtin.which_key.mappings['sl'] = {
  '<cmd>Telescope resume<cr>', 'Last search'
}
lvim.builtin.which_key.mappings['ss'] = {
  '<cmd>Telescope grep_string<cr>', 'Find current word'
}
lvim.builtin.which_key.mappings['su'] = {
  '<cmd>Telescope undo<cr>', 'Current buffer undo tree'
}
lvim.builtin.which_key.mappings['sy'] = {
  '<cmd>Telescope yank_history<cr>', 'Yank history'
}
-- additional picker for treesitter menu
lvim.builtin.which_key.mappings['Ts'] = {
  function()
    require('telescope.builtin').treesitter()
  end,
  'Search Treesitter'
}
-- add a sessions menu
lvim.builtin.which_key.mappings['S'] = {
  name = 'Session',
  c = { "<cmd>lua require('persistence').load()<cr>", 'Restore last session for current dir' },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", 'Restore last session' },
  q = { "<cmd>lua require('persistence').stop()<cr>", 'Quit without saving session' },
}


-- core plugins configs
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.numbers = 'ordinal'
-- i don't like indentlines
lvim.builtin.indentlines.active = false
-- change the order from the default
lvim.builtin.cmp.formatting.fields = { 'abbr', 'kind', 'menu' }
-- select the first option
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.completion = {
  completeopt = 'menu,menuone,select'
}
-- remove duplicates between lsp and buffer words
lvim.builtin.cmp.formatting.duplicates = {
  buffer = 0,
  path = 1,
  nvim_lsp = 0,
  luasnip = 1,
}
lvim.builtin.cmp.cmdline.enable = true
lvim.icons.kind['Codeium'] = ''
table.insert(lvim.builtin.cmp.sources, { name = 'codeium', max_item_count = 3 })
lvim.builtin.cmp.formatting.source_names['codeium'] = '(Codeium)'
lvim.builtin.cmp.experimental = {
  ghost_text = true,
  native_menu = false,
}

-- TODO: fix <M-2> terminal size when nvim-tree open
lvim.builtin.terminal.direction = 'vertical'
lvim.builtin.terminal.size = function(term)
  if term.direction == 'horizontal' then
    return 15
  elseif term.direction == 'vertical' then
    return vim.o.columns * 0.3
  end
end

-- add additional telescope mappings
local _, actions = pcall(require, 'telescope.actions')
local _, trouble = pcall(require, 'trouble.providers.telescope')
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
    ['<C-n>'] = actions.cycle_history_next,
    ['<C-p>'] = actions.cycle_history_prev,
    ['<C-t>'] = trouble.open_with_trouble,
  },
  n = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
    ['<C-t>'] = trouble.open_with_trouble,
  }
}

-- load telescope extensions
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, 'undo')
  pcall(telescope.load_extension, 'file_browser')
  pcall(telescope.load_extension, 'yank_history')
  pcall(telescope.load_extension, 'emoji')
end

-- ignore these folders when searching
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  '.git/',
  'node_modules/',
}

-- add restore session button to dashboard
lvim.builtin.alpha.dashboard.section.buttons = {
  opts = {
    spacing = 1,
  },
  entries = {
    { 'f', lvim.icons.ui.FindFile .. '  Find File',   '<CMD>Telescope find_files<CR>' },
    { 'n', lvim.icons.ui.NewFile .. '  New File',     '<CMD>ene!<CR>' },
    { 'p', lvim.icons.ui.Project .. '  Projects',     '<CMD>Telescope projects<CR>' },
    { 'r', lvim.icons.ui.History .. '  Recent files', '<CMD>Telescope oldfiles<CR>' },
    { 's', lvim.icons.ui.BookMark .. '  Restore session',
      "<CMD>lua require('persistence').load({ last = true })<CR>" },
    { 't', lvim.icons.ui.FindText .. '  Find Text', '<CMD>Telescope live_grep<CR>' },
    { 'c',
      lvim.icons.ui.Gear .. '  Configuration',
      '<CMD>edit ' .. require('lvim.config'):get_user_config_path() .. ' <CR>' },
    { 'q', lvim.icons.ui.Close .. '  Quit',         '<CMD>quit<CR>' },
  }
}

lvim.builtin.treesitter.ensure_installed = {
  'bash',
  'c',
  'javascript',
  'json',
  'lua',
  'python',
  'ruby',
  'typescript',
  'tsx',
  'css',
  'yaml'
}

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
lvim.builtin.treesitter.additional_vim_regex_highlighting = true

-- fix lspinfo popup border
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- setup additional LSP servers
require('lvim.lsp.manager').setup('marksman')

-- skip automatic configuration for lua_ls to enable autoformatting
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'lua_ls' })
-- skip server configuration for typescript
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'tsserver' })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'tailwindcss' })
-- skip server to use schemastore
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { 'jsonls' })

-- extra plugins
lvim.plugins = {
  {
    'navarasu/onedark.nvim',
    config = function()
      local onedark = require('onedark')
      -- fix some border issues with telescope and LSP float windows
      onedark.setup({
        style = 'darker',
        highlights = {
          TelescopePromptBorder = { fg = '#848b98' },
          TelescopeResultsBorder = { fg = '#848b98' },
          TelescopePreviewBorder = { fg = '#848b98' },
          FloatBorder = { bg = '#1f2329' },
          NormalFloat = { bg = '#1f2329' }
        }
      })
      onedark.load()
    end
  },
  { 'edkolev/tmuxline.vim' },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end
  },
  { 'folke/trouble.nvim',  cmd = 'TroubleToggle' },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    'ethanholz/nvim-lastplace',
    event = 'BufRead',
    config = function()
      require('nvim-lastplace').setup({
        lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
        lastplace_ignore_filetype = {
          'gitcommit', 'gitrebase', 'svn', 'hgcommit',
        },
        lastplace_open_folds = true,
      })
    end
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    config = function()
      require('persistence').setup({
        dir = vim.fn.expand(vim.fn.stdpath 'config' .. '/session/'),
        options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
      })
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
      require('nvim-treesitter.configs').setup({
        textsubjects = {
          enable = true,
          keymaps = { ['.'] = 'textsubjects-smart', [';'] = 'textsubjects-big' },
        },
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['as'] = '@scope'
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>a'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = { query = '@class.outer', desc = 'next class start' },
              [']o'] = '@loop.*',
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              [']s'] = { query = '@scope', query_group = 'locals', desc = 'next scope' },
              [']z'] = { query = '@fold', query_group = 'folds', desc = 'next fold' },
            },
            goto_next_end = {
              [']m'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[m'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
            goto_next = {
              [']d'] = '@conditional.outer',
            },
            goto_previous = {
              ['[d'] = '@conditional.outer',
            }
          },
        }
      })
    end
  },
  { 'debugloop/telescope-undo.nvim' },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup({
        width = 120,
        height = 25,
        border = 'rounded',
        default_mappings = true,
        debug = false,
        opacity = nil,
        post_open_hook = function()
          vim.keymap.set('n', '<ESC>', ":lua require('goto-preview').close_all_win()<CR>",
            { noremap = true, silent = true })
          vim.keymap.set('n', '<C-c>', ":lua require('goto-preview').close_all_win()<CR>",
            { noremap = true, silent = true })
        end
      })
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = 'markdown',
    config = function()
      vim.g.mkdp_auto_start = 1
    end
  },
  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = false,
        stop_eof = true,
        use_local_scrolloff = false,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      })
    end
  },
  {
    'asiryk/auto-hlsearch.nvim',
    config = function()
      require('auto-hlsearch').setup()
    end
  },
  { 'sitiom/nvim-numbertoggle' },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  {
    'gbprod/yanky.nvim',
    config = function()
      require('yanky').setup()
    end
  },
  {
    'jcdickinson/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('codeium').setup({})
    end
  },
  { 'kana/vim-textobj-user' },
  {
    'Julian/vim-textobj-variable-segment',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup()
    end
  },
  { 'xiyaowong/telescope-emoji.nvim' },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      -- automatic setup of sources
      require('mason').setup()
      require('mason-null-ls').setup({
        handlers = {},
      })
    end
  },
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup({}) end
  },
}

-- function to split a string with line endings into a table
local function lines(str)
  local t = {}
  local function helper(line)
    -- trim leading whitespace
    line = line:gsub('^[ \t]+', '')
    table.insert(t, line)
    return ''
  end
  helper((str:gsub('(.-)\r?\n', helper)))
  return t
end

vim.diagnostic.config({
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
    format = function(diagnostic)
      if diagnostic.source == 'typescript' then
        -- these errors messages are too long so only show the first line
        if diagnostic.code == 2322 then
          local content = lines(diagnostic.message)
          return content[1]
        end
      end
      return diagnostic.message
    end
  }
})

lvim.autocommands = {
  { 'ColorScheme',
    {
      pattern = '*',
      callback = function()
        -- fix lspinfo float window border
        vim.api.nvim_set_hl(0, 'LspInfoBorder', { fg = '#848b98', bg = '#1f2329' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { underline = false })
      end,
    }
  },
  -- set line numbers in telescope preview window
  { 'User', { pattern = { 'TelescopePreviewerLoaded' }, command = 'setlocal number' } },
  -- autosave when leaving the buffer
  {
    { 'BufLeave', 'FocusLost' },
    {
      pattern = '*',
      callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand('%') ~= '' and vim.bo.buftype == '' then
          vim.cmd 'silent! w'
        end
      end
    }
  }
}

-- quit lvim when nvimtree is only left open
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match('NvimTree_') ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})
