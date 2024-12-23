return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt" },
    }
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  }
}
