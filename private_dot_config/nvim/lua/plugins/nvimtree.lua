return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})
    local wk = require("which-key")
    wk.add({
      { "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Explorer" },
    })
  end,
}
