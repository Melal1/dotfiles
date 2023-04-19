local St, toggleterm = pcall(require, "toggleterm")
if not St then
	print("toggleterm is not installed or error")
	return
end
toggleterm.setup({
	size = 13,
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1",
	start_in_insert = true,
	persist_size = true,
	direction = "horizontal",
})
