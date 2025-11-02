return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "curdir", "tabpages", "folds", "globals", "options", "resize", "winpos", "winsize" },
    pre_save = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
  },
  init = function()
    vim.schedule(function()
      if vim.bo.ft == "lazy" then
        vim.cmd.quit()
      end
      require("persistence").load()
    end)
  end
}
