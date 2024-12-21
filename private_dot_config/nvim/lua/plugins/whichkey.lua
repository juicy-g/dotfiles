return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    win = {
      border = "rounded"
    }
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.add({
      { "<leader>g",     group = "Git" },
      { "<leader>f",     group = "Find" },
      { "<leader>l",     group = "LSP" },
      { "<leader>ld",    vim.diagnostic.open_float, desc = "Open Diagnostics" },
      { "<leader><tab>", group = "Tabs" },
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps"
      },
    })
    wk.setup(opts)
  end,
}
