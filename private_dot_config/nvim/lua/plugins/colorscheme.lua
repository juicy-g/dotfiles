return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			styles = {
				floats = "normal",
				sidebars = "normal",
			},
			on_colors = function(colors)
				colors.bg_statusline = colors.bg
			end,
			on_highlights = function(hl, c)
				hl.CmpDocumentation = { fg = c.fg, bg = "#24283b" }
				hl.CmpDocumentationBorder = { fg = c.fg, bg = "#24283b" }
				hl.TelescopePromptBorder = hl.FloatBorder
			end,
		},
		init = function()
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
}
