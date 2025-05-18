return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "pnx/lualine-lsp-status" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "tokyonight",
        component_separators = "",
        section_separators = { left = "", right = "" },
        ignore_focus = { "NvimTree" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha" },
          winbar = { "alpha" },
        },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
        lualine_b = {
          {
            function()
              return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
            end,
            padding = { right = 1, left = 1 },
            separator = { left = "", right = "" },
          },
          "branch"
        },
        lualine_c = { "filename", "lsp-status", "diagnostics" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "nvim-tree", "aerial", "trouble" },
    }
  end
}
