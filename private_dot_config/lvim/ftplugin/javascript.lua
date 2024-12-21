require("lvim.lsp.manager").setup("tsserver", {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      quotePreference = "single",
    },
  },
  settings = {
    documentFormatting = true,
    diagnostics = { ignoredCodes = { 80001 } },
  },
})
