return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "folds", "globals", "options", "resize", "terminal", "winpos", "winsize" },
      pre_save = function() vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" }) end,
    }
  },
}
