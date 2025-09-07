vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    vim.keymap.set(
      "n",
      "grd",
      function() vim.lsp.buf.declaration() end,
      { desc = "Go to declaration", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "grD",
      function() vim.lsp.buf.definition() end,
      { desc = "Go to definition", buffer = event.buf }
    )
    -- vim.keymap.set(
    --   "n",
    --   "gri",
    --   function() vim.lsp.buf.implementation() end,
    --   { desc = "Go to implementation", buffer = event.buf }
    -- )
    -- vim.keymap.set(
    --   "n",
    --   "grt",
    --   "<cmd>lua vim.lsp.buf.type_definition()<cr>",
    --   { desc = "Go to type definition", buffer = event.buf }
    -- )
    vim.keymap.set("n", "gO", require("telescope.builtin").lsp_document_symbols, { desc = "Open Document Symbols" })
    vim.keymap.set(
      "n",
      "grr",
      require("telescope.builtin").lsp_references,
      { desc = "Find references", buffer = event.buf }
    )
    vim.keymap.set("n", "gW", require("telescope.builtin").lsp_dynamic_workspace_symbols,
      { desc = "Open Workspace Symbols" })
    vim.keymap.set(
      "n",
      "<leader>ls",
      function() vim.lsp.buf.signature_help() end,
      { desc = "Signature help" }
    )
    vim.keymap.set(
      "n",
      "gl",
      function() vim.diagnostic.open_float() end,
      { desc = "Diagnostics open float", buffer = event.buf }
    )
    vim.keymap.set("n", "<leader>tl", "<cmd>LspLensToggle<cr>", { desc = "Toggle LSP lens" })
    vim.keymap.set(
      "n",
      "<leader>lr",
      function() vim.lsp.buf.rename() end,
      { desc = "Rename", buffer = event.buf }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>la",
      function() vim.lsp.buf.code_action() end,
      { desc = "Code Action" }
    )

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Highlight word under cursor
    if client and client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- Setup inlay hints if supported
    if client ~= nil and client:supports_method("textDocument/inlayHint", event.buf) then
      vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { desc = "Toggle inlay hints", buffer = event.buf })
    end
  end
})

-- Diagnostics config
local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
local diagnostic_signs = {}
for type, icon in pairs(signs) do
  diagnostic_signs[vim.diagnostic.severity[type]] = icon
end
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  signs = { text = diagnostic_signs },
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
})

-- Add borders around all popups and windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--- @diagnostic disable-next-line: duplicate-set-field, redefined-local
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
vim.lsp.config("*", {
  capabilities = capabilities,
})
