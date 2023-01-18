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
  	requires = {'nvim-tree/nvim-web-devicons'}
  }

  use 'nvim-tree/nvim-web-devicons'
  use 'chaoren/vim-wordmotion'

	use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use 'christoomey/vim-tmux-navigator'

	use 'glepnir/dashboard-nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
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
	use "jose-elias-alvarez/nvim-lsp-ts-utils"

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
			'nvim-tree/nvim-web-devicons',
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


	use {
		"mfussenegger/nvim-dap",
		opt = true,
		-- event = "BufReadPre",
		keys = { [[<leader>d]] },
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require('dapui').setup()
			require("config.dbg").setup()
		end,
	}

	use 'David-Kunz/jester'

	use { 'williamboman/nvim-lsp-installer'}
	use { "stevearc/dressing.nvim" }
	use {'jose-elias-alvarez/typescript.nvim'}

	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {} end
	}
	use 'ggandor/lightspeed.nvim'

	use { "ellisonleao/gruvbox.nvim" }

	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua", "nvim-cmp" },
	}

	use {
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-treesitter/nvim-treesitter"}
		}
	}
	use {
		"b0o/incline.nvim",
		event = "BufReadPre",
		config = function()
			require("incline").setup()
		end,

	}
use {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function ()
    vim.schedule(function() require("copilot").setup() end)
  end,
}

end)
