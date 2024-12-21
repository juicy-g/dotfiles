return {
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim",                opts = {} },
    },
    init = function()
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
                vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { desc = "Toggle Inlay Hints", buffer = event.buf })
          end
        end,
      })

      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = "rounded" })
      require("lspconfig.ui.windows").default_options.border = "rounded"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,

          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  telemetry = {
                    enable = false,
                  },
                  runtime = {
                    version = "LuaJIT",
                    special = {
                      reload = "require",
                    },
                  },
                  diagnostics = {
                    disable = { "undefined-global", "missing-fields" },
                  },
                  completion = {
                    callSnippet = "Replace",
                  },
                  format = {
                    enable = true,
                    defaultConfig = {
                      indent_style = "space",
                      indent_size = "2",
                      quote_style = "double",
                    },
                  },
                }
              }
            })
          end
        }
      })
    end
  }
}
