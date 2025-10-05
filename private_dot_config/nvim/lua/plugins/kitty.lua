return {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
    event = { "User KittyScrollbackLaunch" },
    version = "^6.0.0",
    opts = {}
  },
  {
    "fladson/vim-kitty",
    ft = "kitty",
  }
}
