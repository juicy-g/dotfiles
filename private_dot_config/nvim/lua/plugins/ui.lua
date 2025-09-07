return {
  {
    "VidocqH/lsp-lens.nvim",
    opts = {
      enable = false,
      sections = {
        definition = false,
        references = true,
        implements = true,
        git_authors = false,
      },
    },
  },
  {
    "Sebastian-Nielsen/better-type-hover",
    ft = { "typescript", "typescriptreact" },
    opts = {}
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
          border = "rounded"
        }
      }
    }
  },
}
