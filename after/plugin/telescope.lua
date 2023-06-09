local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>jj', builtin.find_files, {})
vim.keymap.set('n', '<leader>jk', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ll', builtin.buffers, {})
vim.keymap.set('n', '<leader>jh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
