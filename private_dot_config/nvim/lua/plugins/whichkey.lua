return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    win = {
      border = "rounded"
    },
 sort = { "alphanum", "local", "order", "mod" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.add({
      { "<leader>b",     group = "Buffers" },
      { "<leader>g",     group = "Git" },
      { "<leader>f",     group = "Find" },
      { "<leader>l",     group = "LSP" },
      { "<leader>ld",    vim.diagnostic.open_float,                                    desc = "Open diagnostics" },
      { "<leader>t",     group = "Trouble" },
      { "<leader>tD",    "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Workspace diagnostics" },
      { "<leader>td",    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer diagnostics" },
      { "<leader>ts",    "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols" },
      { "<leader>tl",    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
      { "<leader>tq",    "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
      { "<leader>tt",    "<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>",    desc = "Todo" },
      { "<leader><tab>", group = "Tabs" },
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer local keymaps"
      },
    })
    wk.setup(opts)
  end,
}
