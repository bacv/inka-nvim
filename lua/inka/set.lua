vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 50

vim.g.gitblame_enabled = 0
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
