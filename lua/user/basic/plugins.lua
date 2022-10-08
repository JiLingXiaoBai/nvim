local fn = vim.fn
local cmd = vim.cmd
local isWindows = (vim.g.isWindows == 1)

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
cmd [[
	augroup packer_user_config
	    autocmd!
	    autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

local function install_plugins(use)
    -- have packer manage itself
    use "wbthomason/packer.nvim"
    -- impatient
    use "lewis6991/impatient.nvim"
    -- notify
    use "rcarriga/nvim-notify" 
    -- icons
    use "kyazdani42/nvim-web-devicons" 
    -- github theme
    use "projekt0n/github-nvim-theme"
    -- useful lua functions used by lots of plugins
    use "nvim-lua/plenary.nvim"
    -- float terminal
    use "akinsho/toggleterm.nvim"
    -- bufferline
    use {"akinsho/bufferline.nvim", tag = "v2.*"}
    -- statusline
    use "nvim-lualine/lualine.nvim"
    -- telescope
    use {"nvim-telescope/telescope.nvim", tag = "0.1.0"}
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
    use {"nvim-telescope/telescope-file-browser.nvim"}
    use {"nvim-telescope/telescope-project.nvim"}
    -- nvim-tree
    use {"kyazdani42/nvim-tree.lua", tag = 'nightly'}
    -- indentLine
    use "lukas-reineke/indent-blankline.nvim"
    -- tree-sitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    -- dashboard, the start menu
    use {"glepnir/dashboard-nvim"}
    -- comment
    use {"numToStr/Comment.nvim"}
    -- surround
    use {"kylechui/nvim-surround", tag = "*"}
    -- autopairs
    use {"windwp/nvim-autopairs"}
    -- completion plugins
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"saadparwaiz1/cmp_luasnip"}
    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end

require("packer").startup({
	install_plugins,
	config = {
		display = {
			open_fn = require("packer.util").float
		}
	}
})
