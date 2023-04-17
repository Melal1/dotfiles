-- Protected call for color scheme -- 


--local color = "darkplus"
local color = "gruvbox"
local defcolor = "slate"

local colorst, _ = pcall(vim.cmd, "colorscheme " .. color)
if not colorst then
  vim.notify("The color scheme " .. color .. " not found , used " .. defcolor .. " instead ~")
  return
end
