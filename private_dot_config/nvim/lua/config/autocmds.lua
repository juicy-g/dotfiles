vim.api.nvim_create_autocmd("FileType", {
  desc="Press q to quit",
  pattern = {
    "qf",
    "help",
    "man",
    "floaterm",
    "lspinfo",
    "lir",
    "lsp-installer",
    "null-ls-info",
    "tsplayground",
    "DressingSelect",
    "Jaq",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Restore NvimTree when restoring a session",
  pattern = "NvimTree*",
  callback = function()
    local api = require("nvim-tree.api")
    local view = require("nvim-tree.view")

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

local Format = vim.api.nvim_create_augroup("Format", { clear = true })
local api = require("typescript-tools.api")
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format on save",
  group = Format,
  pattern = { "*.ts", "*.tsx", "*.jsx", "*.js" },
  callback = function(args)
    api.organize_imports(true)
    require("conform").format ({ bufnr = args.buf })
  end,
})
