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

  -- Color Schemes and icons 
  "lunarvim/darkplus.nvim",
  "morhetz/gruvbox",
  "nvim-tree/nvim-web-devicons", -- vs code icons 
  -- Nvim tree 
  "nvim-tree/nvim-tree.lua",


  -- "" Plgugins 
  "tpope/vim-surround",    -- add, delete, change surroundings (it's awesome)
  "numToStr/Comment.nvim", -- Comment with gc


    -- fuzzy finding w/ telescope
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder

}


local opts = {}

require("lazy").setup(plugins, opts)
