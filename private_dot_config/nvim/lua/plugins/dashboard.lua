return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", "<cmd>ene <BAR> startinsert <cr>"),
      dashboard.button("d", "  > Dotfiles", "<cmd>Telescope chezmoi find_files<cr>"),
      dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "󱥬  > Session", "<cmd>lua require('persistence').load()<cr>"),
      dashboard.button("t", "  > Text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("q", "󰈆  > Quit", "<cmd>qa<cr>"),
    }

    dashboard.opts = {
      layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      },
      opts = {
        margin = 5,
      }
    }
    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Disable folding on alpha buffer
    vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
  end
}
