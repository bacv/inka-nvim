-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use({ 'rose-pine/neovim', as = 'rose-pine' })
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-tree/nvim-tree.lua')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/vim-vsnip' },
			{ 'hrsh7th/cmp-vsnip',    branch = 'main' },
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}
	use('f-person/git-blame.nvim')
end)
