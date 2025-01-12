-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<cr>", { desc = "Prev buffer", noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose<cr>", { desc = "Close buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bf", "<cmd>BufferFirst<cr>", { desc = "First buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLast<cr>", { desc = "Last buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferPin<cr>", { desc = "Pin/Unpin buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>br", "<cmd>BufferRestore<cr>", { desc = "Restore buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bs", "<cmd>BufferPick<cr>", { desc = "Select buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader><space>", "<cmd>e #<cr>", { desc = "Other buffer", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<A-<>",
	"<cmd>BufferMovePrevious<cr>",
	{ desc = "Move buffer left", noremap = true, silent = true }
)
vim.keymap.set("n", "<A->>", "<cmd>BufferMoveNext<cr>", { desc = "Move buffer right", noremap = true, silent = true })
vim.keymap.set("n", "<leader>1", "<cmd>BufferGoto 1<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", "<cmd>BufferGoto 2<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", "<cmd>BufferGoto 3<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>4", "<cmd>BufferGoto 4<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>5", "<cmd>BufferGoto 5<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>6", "<cmd>BufferGoto 6<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>7", "<cmd>BufferGoto 7<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>8", "<cmd>BufferGoto 8<cr>", { desc = "which_key_ignore", noremap = true, silent = true })
vim.keymap.set("n", "<leader>9", "<cmd>BufferGoto 9<cr>", { desc = "which_key_ignore", noremap = true, silent = true })

-- Clear search and stop snippet on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	if vim.snippet then
		vim.snippet.stop()
	end
	return "<esc>"
end, { expr = true, desc = "Escape and clear hlsearch" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG<cr>", { desc = "Select all" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Better move
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Add undo break-points
-- vim.keymap.set("i", ",", ",<c-g>u")
-- vim.keymap.set("i", ".", ".<c-g>u")
-- vim.keymap.set("i", ";", ";<c-g>u")

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit
vim.keymap.set({ "i", "x", "n", "s" }, "<C-q>", "<cmd>q<cr>", { desc = "Quit" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Quickfix
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Diagnostics navigation
-- local diagnostic_goto = function(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
-- vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
-- vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
-- vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
-- vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
-- vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
-- vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev warning" })

-- Tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Paste without replace clipboard
vim.keymap.set("x", "p", [["_dP]])
