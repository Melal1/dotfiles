return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "savq/melange-nvim"
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {'akinsho/bufferline.nvim',tagd, requires = 'nvim-tree/nvim-web-devicons'}

end)
