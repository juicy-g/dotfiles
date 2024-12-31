return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" }
  },
  config = function()
    local _, actions = pcall(require, "telescope.actions")
    require("telescope").setup {
      pickers = {
        buffers = {
          initial_mode = "insert",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        }
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "chezmoi")

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope chezmoi find_files<cr>", { desc = "Find dotfiles" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Find telescope builtins" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find current word" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
    vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Find last" })
    vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
    vim.keymap.set("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", { desc = "Find last yanks" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Find recent files" })
    vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>f/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        previewer = true,
      })
    end, { desc = "Find Fuzzily in Current Buffer" })
  end
}
