return {
  "numToStr/Comment.nvim",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
  config = function()
    local wk = require "which-key"
    wk.add {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment Line" },
    }

    wk.add {
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment Line", mode = "v" },
    }

    vim.g.skip_ts_context_commentstring_module = true
    require("ts_context_commentstring").setup {
      enable_autocmd = false,
    }

    require("Comment").setup {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end
}
