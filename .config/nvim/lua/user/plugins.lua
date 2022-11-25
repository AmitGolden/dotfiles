local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use("rcarriga/nvim-notify")
	use("tpope/vim-repeat")
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "moll/vim-bbye" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })

	use("ThePrimeagen/vim-be-good")

	-- UI
	use({ "goolord/alpha-nvim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "akinsho/bufferline.nvim" })
	use("folke/which-key.nvim")
	-- use({ "stevearc/dressing.nvim" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	use("windwp/nvim-spectre")
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("mrjones2014/smart-splits.nvim")
	use("p00f/nvim-ts-rainbow")

	-- Movement
	-- use("ggandor/leap.nvim")
	use("justinmk/vim-sneak")
	use("bkad/CamelCaseMotion")
	use("andymass/vim-matchup")

	-- Editing
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	})
	use({ "Darazaki/indent-o-matic" })
	use("gbprod/cutlass.nvim")
	use("gbprod/substitute.nvim")
	use({ "numToStr/Comment.nvim" })
	use("windwp/nvim-ts-autotag")
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use("smjonas/live-command.nvim")

	-- Colorschemes
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	})
	use("rcarriga/cmp-dap")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp-signature-help")

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })
	use("b0o/schemastore.nvim")

	-- Testing
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"vim-test/vim-test",
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-python",
		},
	})

	-- Text objects
	use("michaeljsmith/vim-indent-object")
	use("kana/vim-textobj-user")
	use("kana/vim-textobj-entire")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("RRethy/nvim-treesitter-textsubjects")

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-context")

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use("sindrets/diffview.nvim")

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	--[[ use({ "ravenxrz/DAPInstall.nvim" }) ]]
	use("mfussenegger/nvim-dap-python")
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
