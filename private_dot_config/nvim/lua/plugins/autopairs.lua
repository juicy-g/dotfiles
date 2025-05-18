return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')

			cmp.event:on('confirm_done', function(args)
				local line = vim.api.nvim_get_current_line()

				-- prevent adding parentheses when importing functional components (eg. <Foo)
				local is_component_import = line:match('</?%s*[%w_]+.-/?>?')

				if is_component_import then
					return false
				end

				cmp_autopairs.on_confirm_done()(args)
			end)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
	},
}
