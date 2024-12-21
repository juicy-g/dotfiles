return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "folds", "globals", "options", "resize", "winpos", "winsize" },
    },
  },
}
