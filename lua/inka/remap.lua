vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>nr", vim.cmd.NvimTreeRefresh)
vim.keymap.set("n", "<leader>n", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>nn", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selected text, but keep the paste in the clipboard.
vim.keymap.set("x", "<leader>p", [["_dP]])
-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>t", ":lua PineToggle()<CR>")
