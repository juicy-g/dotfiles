return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      numbers = "ordinal",
      indicator = {
        style = "none",
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          separator = true,
          highlight = "NvimTreeNormal",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
    vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { bg = "#1f2335", fg = "#1f2335" })
  end,
}
