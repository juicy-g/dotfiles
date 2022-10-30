-- general vim options
vim.cmd("let g:tmuxline_powerline_separators = 0")
vim.opt.wrap = true

-- general lvim options
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedark"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- core plugins configs
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

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
  {"navarasu/onedark.nvim"},
  {"edkolev/tmuxline.vim"},
  {
    "gelguy/wilder.nvim",
    config = function()
    require("wilder").setup({modes = {':', '/', '?'}})
    end,
  },
}

