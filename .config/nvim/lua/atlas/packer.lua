local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- COLOR SCHEMES
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  require("rose-pine").setup()
		  vim.cmd('colorscheme rose-pine')
	  end
  })
  use({
    'rebelot/kanagawa.nvim',
    as = 'kanagawa',
    config = function()
        require('kanagawa').setup()
        vim.cmd("colorscheme kanagawa")
    end
  })
  use({
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
        require('tokyonight').setup()
        vim.cmd("colorscheme tokyonight")
        vim.cmd("colorscheme tokyonight-night")
        vim.cmd("colorscheme tokyonight-moon")
        vim.cmd("colorscheme tokyonight-storm")
    end
  })
  use({
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
        require('catppuccin').setup()
        vim.cmd("colorscheme catppuccin")
        vim.cmd("colorscheme catppuccin-frappe")
        vim.cmd("colorscheme catppuccin-mocha")
        vim.cmd("colorscheme catppuccin-macchiato")
    end
  })
--  use({
--    'tiagovla/tokyodark.nvim',
--    as = 'tokyodark',
--    config = function()
--        require('tokyodark').setup()
--        vim.cmd("colorscheme tokyodark")
--    end
--  })

  use( 'nvim-treesitter/nvim-treesitter', {
      run = ':TSUpdate'
  })
  use( 'nvim-treesitter/playground' )
  use( 'theprimeagen/harpoon' )
  use( 'mbbill/undotree' )
  use( 'tpope/vim-fugitive' )

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }

  use { "alexghergh/nvim-tmux-navigation" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
