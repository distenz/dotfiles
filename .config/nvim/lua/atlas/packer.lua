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
      'catppuccin/nvim',
      as = 'catppuccin',
      config = function()
          require("catppuccin").setup({
              flavour = "mocha", -- latte, frappe, macchiato, mocha
              background = { -- :h background
              light = "latte",
              dark = "mocha",
          },
          transparent_background = false, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
              enabled = true, -- dims the background color of inactive window
              shade = "light",
              percentage = 0.15, -- percentage of the shade to apply to the inactive window
          },
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = {}, -- Change the style of comments
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
      },
      color_overrides = {
          mocha = {
              base = "#121212",
              mantle = "#121212",
              crust = "#121212",
          }
      },
      custom_highlights = {},
      integrations = {
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
  })

  -- setup must be called before loading
  vim.cmd.colorscheme "catppuccin"
    end
})

  use( 'nvim-treesitter/nvim-treesitter', {
      run = ':TSUpdate'
  })
  use( 'nvim-treesitter/playground' )

  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
