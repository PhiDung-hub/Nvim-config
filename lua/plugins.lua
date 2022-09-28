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

  -- hopping around
  use 'phaazon/hop.nvim' -- vim move on stereoid (add more custom mapping).
  use "folke/which-key.nvim" -- manage your hotkey on steroid.

  -- LSP and ít utilities
  use 'neovim/nvim-lspconfig' -- official LSP.
  use 'onsails/lspkind-nvim' -- vscode-like pictograms.
  use 'hrsh7th/nvim-cmp' -- Code Completion.
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffers (tab)
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP.
  use 'ray-x/lsp_signature.nvim' -- signature suggestion for lsp.
  use 'L3MON4D3/LuaSnip'
  use({
    'glepnir/lspsaga.nvim', -- LSP UIs
    branch = "main",
  })
  use 'williamboman/mason.nvim' -- LSP manager.
  use 'williamboman/mason-lspconfig.nvim' -- mason config helpers.
  use {
    'jose-elias-alvarez/null-ls.nvim', -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    requires = { 'nvim-lua/plenary.nvim', }
  }
  use "b0o/schemastore.nvim"

  -- Comment and uncomment
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'

  -- Syntax highlighting and code formatting.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'kyazdani42/nvim-web-devicons' -- File icons.
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client.
  use 'norcalli/nvim-colorizer.lua' -- color hinting.
  use 'mhartington/formatter.nvim' -- code formatter.

  -- Terminal and dir browser
  use 'nvim-telescope/telescope.nvim' -- telescope
  use 'nvim-telescope/telescope-file-browser.nvim' -- telescope helpers
  use 'nvim-telescope/telescope-media-files.nvim' -- preview image
  -- use 'kyazdani42/nvim-tree.lua' -- tree browser, switched to neo-tree
  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
  }
  use 'akinsho/toggleterm.nvim' -- terminal toggler
  use 'akinsho/nvim-bufferline.lua' -- buffer navigation on top
  use 'famiu/bufdelete.nvim' -- buffer deletetion (default is annoying)

  -- Session manager
  use 'rmagatti/auto-session'

  -- HTML and JSX tag auto complete
  use 'windwp/nvim-autopairs' -- auto pairs
  use 'windwp/nvim-ts-autotag' -- auto tag
end)
