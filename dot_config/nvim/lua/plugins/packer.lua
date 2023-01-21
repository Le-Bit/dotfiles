-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- theme
	use("luisiacc/gruvbox-baby")
use 'folke/tokyonight.nvim'
	use("ellisonleao/gruvbox.nvim")

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- test
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"haydenmeade/neotest-jest",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	})

	use({ -- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
	})

	use({ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	use({ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	})
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	})

	use("navarasu/onedark.nvim") -- Theme inspired by Atom
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use("nvim-telescope/telescope-file-browser.nvim")

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	--refactoring plugin
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Github Copilot
	--use 'github/copilot.vim'
	use({
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end)
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	--plugin for easy mouvements
	use("ggandor/lightspeed.nvim")

	use({ "romgrk/barbar.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
	--tmux <3
	use("christoomey/vim-tmux-navigator")
	-- to remove
	use("svermeulen/vimpeccable")

	-- which-key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	--typescript related plugins
	use("jose-elias-alvarez/typescript.nvim")

	-- file management
	use("stevearc/oil.nvim")

	use("jose-elias-alvarez/null-ls.nvim")

	--debugging
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		keys = { [[<leader>d]] },
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("debug-ap").setup()
		end,
	})
use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use("stevearc/dressing.nvim")

	use("takac/vim-hardtime")
use {
  "microsoft/vscode-js-debug",
  opt = true,
  run = "npm install --legacy-peer-deps && npm run compile",
  tag = 'v1.74.1'
}

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)
