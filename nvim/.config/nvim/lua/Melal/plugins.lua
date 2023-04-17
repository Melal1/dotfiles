
-- if u want to  automatically install packer if not uncommnet --

--[[ local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
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
  vim.cmd [[packadd packer.nvim]] 
 --end --]]







-- Autocommand that reloads neovim whenever you save the plugins.lua file


--[[vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> |
  augroup end
]]

--]]


-- Use a protected call so we don't error out on first use --


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local plugins = {

   "wbthomason/packer.nvim", -- Have packer manage itself
  -- important plugins 
   "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
   "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  --
-- Color Schemes 
 "lunarvim/darkplus.nvim",

  -- cmp plugins
   "hrsh7th/nvim-cmp", -- The completion plugin
   "hrsh7th/cmp-buffer", -- buffer completions
   "hrsh7th/cmp-path", -- path completions
   "hrsh7th/cmp-cmdline", -- cmdline completions
   "saadparwaiz1/cmp_luasnip", -- snippet completions

  -- snippets
   "L3MON4D3/LuaSnip", --snippet engine
   "rafamadriz/friendly-snippets", -- a bunch of snippets to use



  -- LSP
   "neovim/nvim-lspconfig", -- enable LSP
   "williamboman/mason.nvim", -- simple to use language server installer
   "williamboman/mason-lspconfig.nvim", -- simple to  language server installer
   'jose-elias-alvarez/null-ls.nvim', -- LSP diagnostics and code actions
   -- telescope
   {'nvim-telescope/telescope.nvim', tag = '0.1.1'},
   'nvim-telescope/telescope-media-files.nvim',
    "cljoly/telescope-repo.nvim" ,
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "dhruvmanila/telescope-bookmarks.nvim",
    "nvim-telescope/telescope-github.nvim",
    "LinArcX/telescope-command-palette.nvim" ,
    {
      "AckslD/nvim-neoclip.lua",
      config = function() require("neoclip").setup() end,
    },
    
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "jvgrootveld/telescope-zoxide",


    }

local opts = {}

--[[local status_ok, lazy = pcall(require, ("lazy").setup(plugins, opts))

if not status_ok then
  vim.nofity("pk erorr")
  return
end --]]
require("lazy").setup(plugins, opts)
-- require("lazy").setup(plugins, opts)
