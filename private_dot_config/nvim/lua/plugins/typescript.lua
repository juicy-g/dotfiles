return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    require("typescript-tools").setup({
      on_attach = function()
        vim.keymap.set("n", "<leader>lR", "<cmd>TSToolsRenameFile<cr>", { desc = "Rename file" })
      end,
      settings = {
        expose_as_code_action = "all",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "single",
        },
        tsserver_format_options = {
          semicolons = "remove"
        }
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
          { 80001 }
        ),
      },
    })
  end
}
