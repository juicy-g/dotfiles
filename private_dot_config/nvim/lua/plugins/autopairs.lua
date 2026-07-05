return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			cmp.event:on("confirm_done", function(args)
				local line = vim.api.nvim_get_current_line()

				-- Prevent adding parentheses when importing functional components (eg. <Foo)
				local is_component_import = line:match("</?%s*[%w_]+.-/?>?")

				if is_component_import then
					return false
				end

				cmp_autopairs.on_confirm_done()(args)
			end)

			local npairs = require "nvim-autopairs"
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			local ts_conds = require("nvim-autopairs.ts-conds")

			-- Add trailing commas to "'} inside Lua tables
			npairs.add_rules({
				Rule("{", "},", "lua")
						:with_pair(cond.not_after_regex(","))
						:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
				Rule("'", "',", "lua")
						:with_pair(cond.not_after_regex(","))
						:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
				Rule('"', '",', "lua")
						:with_pair(cond.not_after_regex(","))
						:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
	},
}
