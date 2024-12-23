return {
  {
    "xvzc/chezmoi.nvim",
    cmd = "ChezmoiList",
    -- event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = true
      vim.g["chezmoi#source_dir_path"] = os.getenv "HOME" .. "/.local/share/chezmoi"
    end,
  }
}
