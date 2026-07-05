return {
  -- {
  --   "BlinkResearchLabs/blink-edit.nvim",
  --   config = function()
  --     require("blink-edit").setup({
  --       llm = {
  --         provider = "sweep",
  --         backend = "ollama",
  --         url = "http://localhost:11434",
  --         model = "sweepai/sweep-next-edit",
  --       },
  --     })
  --   end,
  -- },
  {
    "cursortab/cursortab.nvim",
    lazy = false,
    build = "cd server && go build",
    config = function()
      require("cursortab").setup({
        provider = {
          -- type = "zeta-2",
          type = "sweep",
          url = "http://localhost:8888",
        },
      })
    end,
  },
  {
    "Exafunction/windsurf.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = false
        }
      })
    end
  }
}
