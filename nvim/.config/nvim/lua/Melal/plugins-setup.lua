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





local plugins = {
  -- Dependencies
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim", 

  -- Color Schemes
  "lunarvim/darkplus.nvim",
  "morhetz/gruvbox",



}


local opts = {}

require("lazy").setup(plugins, opts)
