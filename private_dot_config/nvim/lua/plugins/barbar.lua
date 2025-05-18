return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufReadPre",
  opts = {
    auto_hide = 0,
    exclude_ft = { "alpha" },
    sidebar_filetypes = {
      NvimTree = true,
    },
    icons = {
      separator = { left = "", right = "" },
      separator_at_end = false,
    },
  },
  version = "^1.0.0",
}
