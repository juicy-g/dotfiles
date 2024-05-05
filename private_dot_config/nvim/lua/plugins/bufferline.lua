return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({ ---@diagnostic disable-line: redundant-parameter
			options = {
				numbers = "ordinal",
				indicator = {
					style = "none",
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "Explorer",
						highlight = "BufferLineFill",
					},
				},
			},
		})
	end,
}
