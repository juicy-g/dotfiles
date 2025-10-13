return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufReadPre",
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    auto_hide = vim.env.KITTY_SCROLLBACK_NVIM == "true" and 1 or -1,
    exclude_ft = { "alpha" },
    sidebar_filetypes = {
      NvimTree = {
        text = "File Tree",
        align = "center"
      },
      trouble = {
        text = "Trouble",
        align = "center"
      }
    },
    icons = {
      buffer_index = true,
      buffer_number = false,
      filetype = { enabled = false },
      inactive = { button = "", separator = { left = "", right = "" } },
    },
  },
  version = "^1.0.0",
}
