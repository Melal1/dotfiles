-- Protected call for color scheme --

local color = "darkplus"
-- local color = "gruvbox"
-- local color = "kanagawa-dragon"
local defcolor = "slate"

---@diagnostic disable-next-line: param-type-mismatch
local colorst, _ = pcall(vim.cmd, "colorscheme " .. color)
if not colorst then
	vim.notify("The color scheme " .. color .. " not found , used " .. defcolor .. " instead ~")
	return
end
