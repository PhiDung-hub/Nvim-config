local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim' -- utitlities for vim config
  
  -- Colormode and status line
	use 'folke/tokyonight.nvim' -- color theme
	use 'folke/zen-mode.nvim'
	use 'nvim-lualine/lualine.nvim' -- Statusline

	-- git utils
	use 'lewis6991/gitsigns.nvim' -- viewing git

	-- LSP and ít utilities
	use 'neovim/nvim-lspconfig' -- official LSP
	use 'onsails/lspkind-nvim' -- vscode-like pictograms
	use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
	use 'glepnir/lspsaga.nvim' -- LSP UIs
	use 'williamboman/mason.nvim' -- LSP manager
  use 'williamboman/mason-lspconfig.nvim' -- mason config helpers
	use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'numToStr/Comment.nvim'

	-- terminal and dir browser
  use {
    'nvim-treesitter/nvim-treesitter', -- tree browsing
    run = ':TSUpdate'
  }
	use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
	use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim' -- telescope
  use 'nvim-telescope/telescope-file-browser.nvim' -- telescope helpers
	use 'kyazdani42/nvim-tree.lua'
  use 'akinsho/toggleterm.nvim'

	-- HTML and JSX tag auto complete
	use 'windwp/nvim-autopairs' -- auto pairs
	use 'windwp/nvim-ts-autotag' -- auto tag
end)
