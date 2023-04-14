-- This file made for not getting an erorr if the colorescheme is not exist just a notify !!
local color = "darkplus"

local ok, _ = pcall(vim.cmd, "colorscheme " .. color)

if not ok then
  vim.notify("The Colorshceme " .. color .. "  not found")
  return
end
