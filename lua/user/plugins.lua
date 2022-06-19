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
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- colorschemes
	use({
		"dracula/vim",
		as = "dracula",
	})

	-- Colorschemes
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	use({ "lunarvim/darkplus.nvim", as = "darkplus" })
	-- common deps
	use("nvim-lua/plenary.nvim") -- lua functions required by many packages
	use("nvim-lua/popup.nvim") -- popup api, also used by many packages

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-git")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- lsp
	use({
		"williamboman/nvim-lsp-installer",
		config = function()
			require("nvim-lsp-installer").setup({})
		end,
	})
	require("nvim-lsp-installer").setup({
		automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- commenting
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "lewis6991/gitsigns.nvim" })

	-- nvim tree
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })

	-- buffer line
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- utility
	use("tpope/vim-surround")
	use("mattn/emmet-vim")
	use("lewis6991/impatient.nvim")
	use("dstein64/vim-startuptime")

	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
end)
