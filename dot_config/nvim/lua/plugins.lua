return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use 'overcache/NeoSolarized'
  use 'svrana/neosolarized.nvim'

  use 'svermeulen/vimpeccable'

  use 'github/copilot.vim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use 'christoomey/vim-tmux-navigator'

  use 'glepnir/dashboard-nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  use 'onsails/lspkind-nvim'
  use "neovim/nvim-lspconfig"

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use "jose-elias-alvarez/null-ls.nvim"
  use "Le-Bit/nvim-lsp-ts-utils"

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use 'tjdevries/colorbuddy.nvim'
  use { 
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' }
  }

  use 'towolf/vim-helm'

  use 'easymotion/vim-easymotion'


  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function () require"octo".setup() end
  }

  use 'RishabhRD/popfix'
  use 'RishabhRD/nvim-lsputils'

  use 'luisiacc/gruvbox-baby'
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ' 
  --
  -- use 'softchris/ts-snippets' 
  -- use 'stevearc/vim-vsnip-snippets'
  -- use 'xabikos/vscode-javascript'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }
  use {
  "rcarriga/vim-ultest",
  requires = { "vim-test/vim-test" },
  opt = true,
  keys = { "<leader>t" },
  cmd = {
    "TestNearest",
    "TestFile",
    "TestSuite",
    "TestLast",
    "TestVisit",
    "Ultest",
    "UltestNearest",
    "UltestDebug",
    "UltestLast",
    "UltestSummary",
  },
  module = "ultest",
  run = ":UpdateRemotePlugins",
  config = function()
    require("config.test").setup()
  end,
}

use { 'puremourning/vimspector' }

end)
