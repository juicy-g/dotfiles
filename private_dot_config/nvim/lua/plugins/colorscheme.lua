return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    styles = {
      floats = "normal",
      sidebars = "normal",
    },
    lualine_bold = true,
    on_colors = function(colors)
      colors.bg_statusline = colors.bg
    end,
    on_highlights = function(hl, colors)
      hl.CmpDocumentation = { fg = colors.fg, bg = colors.bg }
      hl.CmpDocumentationBorder = { fg = colors.fg, bg = colors.bg }
      hl.TelescopePromptBorder = hl.FloatBorder
      hl.NvimTreeWinSeparator = hl.WinSeparator
      hl.BufferTabpageFill = { bg = colors.bg_statusline }
      hl.BufferTabpagesSep = { bg = colors.bg }
      hl.BufferCurrentIndex = { fg = colors.fg, bg = colors.bg }
    end,
  },
  init = function()
    vim.cmd.colorscheme("tokyonight-storm")
  end
}
