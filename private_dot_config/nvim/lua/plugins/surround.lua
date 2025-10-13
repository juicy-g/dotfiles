return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			move_cursor = "sticky",
			indent_lines = function(start, stop)
				local b = vim.bo
				-- Only re-indent the selection if a formatter is set up already
				if start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp) then
					vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
					require("nvim-surround.cache").set_callback("")
				end

				if start < stop then
					local function clear_line(line) -- strip trailing whitespaces and delete line if empty
						local l, c = string.gsub(vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1], "%s+$", "")
						if l == "" then
							vim.api.nvim_buf_set_lines(0, line - 1, line, false, {})
						elseif c ~= 0 then
							vim.api.nvim_buf_set_lines(0, line - 1, line, false, { l })
						end
					end
					clear_line(stop)
					clear_line(start)
				end
			end,
		},
	},
	{
		dir = "~/repos/surround-ui.nvim",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		event = "VeryLazy",
		opts = {},
	},
}
