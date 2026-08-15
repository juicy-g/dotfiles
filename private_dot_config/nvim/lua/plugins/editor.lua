return {
  {
    "chrisgrieser/nvim-spider",
    config = true,
    keys = {
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({
        cut_key = "x",
        override_del = true,
        exclude = { "ns", "nS" },
      })
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {}
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = false,
        stop_eof = true,
        use_local_scrolloff = false,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      })
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  -- {
  --   "ethanholz/nvim-lastplace",
  --   config = function()
  --     require("nvim-lastplace").setup({
  --       lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
  --       lastplace_ignore_filetype = {
  --         "gitcommit",
  --         "gitrebase",
  --         "svn",
  --         "hgcommit",
  --       },
  --       lastplace_open_folds = true,
  --     })
  --   end,
  -- },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      -- bi-directional leap
      vim.keymap.set({ "n", "x", "o" }, "s", "<plug>(leap)", { desc = "Leap" })
      vim.keymap.set("n", "S", "<plug>(leap-from-window)", { desc = "Leap from window" })

      -- incremental treesitter node selection
      vim.keymap.set({ "n", "x", "o" }, "ga", function()
        require("leap.treesitter").select()
      end, { desc = "Incremental node selection" })

      -- linewise
      vim.keymap.set(
        { "n", "x", "o" },
        "gA",
        'V<cmd>lua require("leap.treesitter").select()<cr>',
        { desc = "Incremental linewise node selection" }
      )

      -- remap gs for remote operation
      vim.keymap.set({ "n", "o" }, "gs", function()
        require("leap.remote").action()
      end, { desc = "Leap remote operation" })

      -- remote operations with search commands
      vim.keymap.set({ "n", "o" }, "g/", function()
        require("leap.remote").action { jumper = "/" }
      end)
      vim.keymap.set({ "n", "o" }, "g?", function()
        require("leap.remote").action { jumper = "?" }
      end)

      -- preview filter to reduce visual noise and the blinking effect after the first keypress
      require("leap").opts.preview_filter =
          function(ch0, ch1, ch2)
            return not (
              ch1:match("%s") or
              ch0:match("%a") and ch1:match("%a") and ch2:match("%a")
            )
          end

      -- equivalence classes for brackets and quotes
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", '\'"`' }
    end,
  },
  {
    "asiryk/auto-hlsearch.nvim",
    config = true,
    event = { "BufReadPost", "BufNewFile" },
  },
  { "sitiom/nvim-numbertoggle", event = "InsertEnter" },
  {
    "nmac427/guess-indent.nvim",
    config = true,
    event = "BufReadPre",
  },
  {
    "mawkler/refjump.nvim",
    event = "LspAttach",
    opts = {}
  },
  {
    "monaqa/dial.nvim",
    opts = function()
      local augend = require("dial.augend")

      local logical_alias = augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      })

      local ordinal_numbers = augend.constant.new({
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      })

      return {
        dials_by_ft = {
          css = "css",
          vue = "vue",
          javascript = "typescript",
          typescript = "typescript",
          typescriptreact = "typescript",
          javascriptreact = "typescript",
          json = "json",
          lua = "lua",
          markdown = "markdown",
          sass = "css",
          scss = "css",
          python = "python",
        },
        groups = {
          default = {
            augend.integer.alias.decimal,          -- nonnegative decimal number (0, 1, 2, 3, ...)
            augend.integer.alias.decimal_int,      -- nonnegative and negative decimal number
            augend.integer.alias.hex,              -- nonnegative hex number  (0x01, 0x1a1f, etc.)
            augend.date.alias["%Y/%m/%d"],         -- date (2022/02/19, etc.)
            augend.constant.alias.en_weekday,      -- Mon, Tue, ..., Sat, Sun
            augend.constant.alias.en_weekday_full, -- Monday, Tuesday, ..., Saturday, Sunday
            ordinal_numbers,
            months,
            augend.constant.alias.bool, -- boolean value (true <-> false)
            augend.constant.alias.Bool, -- boolean value (True <-> False)
            logical_alias,
          },
          vue = {
            augend.constant.new({ elements = { "let", "const" } }),
            augend.hexcolor.new({ case = "lower" }),
            augend.hexcolor.new({ case = "upper" }),
          },
          typescript = {
            augend.constant.new({ elements = { "let", "const" } }),
          },
          css = {
            augend.hexcolor.new({
              case = "lower",
            }),
            augend.hexcolor.new({
              case = "upper",
            }),
          },
          markdown = {
            augend.constant.new({
              elements = { "[ ]", "[x]" },
              word = false,
              cyclic = true,
            }),
            augend.misc.alias.markdown_header,
          },
          json = {
            augend.semver.alias.semver, -- versioning (v1.1.2)
          },
          lua = {
            augend.constant.new({
              elements = { "and", "or" },
              word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
              cyclic = true, -- "or" is incremented into "and".
            }),
          },
          python = {
            augend.constant.new({
              elements = { "and", "or" },
            }),
          },
        },
      }
    end,
    config = function(_, opts)
      -- copy defaults to each group
      for name, group in pairs(opts.groups) do
        if name ~= "default" then
          vim.list_extend(group, opts.groups.default)
        end
      end
      require("dial.config").augends:register_group(opts.groups)
      vim.g.dials_by_ft = opts.dials_by_ft

      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("x", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("x", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("x", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("x", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  }
}
