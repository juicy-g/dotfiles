return {
  "williamboman/mason.nvim",
  lazy = true,
  event = "User FileOpened",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  opts = {
    ui = {
      border = "rounded",
    },
  }
}
