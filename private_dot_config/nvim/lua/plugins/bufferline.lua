return {
  {
    "ojroques/nvim-bufdel",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      next = "alternate",
      quit = true,
    }
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      options = {
        numbers = "ordinal",
        themable = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        indicator = {
          icon = "▎ ",
          style = "icon",
        },
        diagnostics = "nvim_lsp",
      }
    }
  } }
