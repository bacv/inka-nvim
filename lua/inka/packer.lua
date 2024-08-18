-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use({ 'nyoom-engineering/oxocarbon.nvim', as = 'oxocarbon' })
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-tree/nvim-tree.lua')
    use('junegunn/fzf', { run = ':fzf#install()' })
    use('junegunn/fzf.vim')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-vsnip',    branch = 'main' },
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }
    use('f-person/git-blame.nvim')
end)
