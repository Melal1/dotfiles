-- This file made for not getting an erorr if the colorescheme is not exist just a notify !!
local color = "darkplus"
local altcolor = "slate"
local ok, _ = pcall(vim.cmd, "colorscheme " .. color)

if not ok then
  vim.cmd("colorscheme " .. altcolor)
  vim.notify("The Colorshceme " .. color .. " not found , Used " .. altcolor .. " instead")
  return
end

---- Melal end -----
