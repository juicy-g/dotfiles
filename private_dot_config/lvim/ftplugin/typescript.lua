require('lvim.lsp.manager').setup('tailwindcss')
require('lvim.lsp.manager').setup('tsserver', {
  init_options = {
    hostInfo = 'neovim',
    preferences = {
      quotePreference = 'single'
    }
  },
  settings = {
    documentFormatting = false,
  }
})
