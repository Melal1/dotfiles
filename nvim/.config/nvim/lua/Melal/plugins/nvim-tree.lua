local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  vim.notify("nvim tree plugin erorr/not installed")
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
nvimtree.setup()
