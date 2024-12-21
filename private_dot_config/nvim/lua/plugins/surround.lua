return {
 {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "roobert/surround-ui.nvim",
    dependencies = {
      "kylechui/nvim-surround",
      "folke/which-key.nvim",
    },
    event = "VeryLazy",
    opts = {
      root_key = "S",
    },
  },
}
