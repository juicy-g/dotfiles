return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "Davidyz/VectorCode",
      version = "*",
      build = "uv tool upgrade vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  init = function()
    vim.cmd([[cab cc CodeCompanion]])
  end,
  config = function()
    local spinner = require("config.spinner")
    spinner:init()

    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:submit()
                chat:add_buf_message({ role = "llm", content = "" })
              end,
              index = 1,
              description = "Send",
            },
            close = {
              modes = {
                n = "q",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "<C-c>",
              },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
          },
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
      extensions = {
        vectorcode = {
          opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
        },
      },
      opts = {
        log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
      },
    })
  end
}
