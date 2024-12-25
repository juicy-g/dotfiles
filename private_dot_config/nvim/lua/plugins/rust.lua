return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {},
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    -- lazy = false,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>la", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", silent = true, buffer = bufnr })
          vim.keymap.set(
            "n",
            "K",
            function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end,
            { desc = "Hover", silent = true, buffer = bufnr }
          )
        end,
      }
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  }
}
