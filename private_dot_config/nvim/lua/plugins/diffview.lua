-- only load those plugins if the current buffer is a git repository
local is_inside_git_repo = function()
  local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
  return vim.fn.isdirectory(git_dir) ~= 0
end

return {
  "sindrets/diffview.nvim",
  lazy = true,
  enabled = is_inside_git_repo(),
  cmd = "DiffviewOpen",
  keys = { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git diff" },
}
