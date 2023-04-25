local St, toggleterm = pcall(require, "toggleterm")
if not St then
	print("toggleterm is not installed or error")
	return
end
-- Melal: require with a protected call the variables file
local Vst, MyVar = pcall(require, "Melal.core.var")
if not Vst then
	print("M")
else
	require("Melal.core.var")
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local Alllazygit = Terminal:new({ cmd = MyVar.GITapp, hidden = true })

function Allgit_toggle()
	Alllazygit:toggle()
end

local DTgit = Terminal:new({
	cmd = MyVar.GITapp,
	direction = "float",
	dir = MyVar.DTdir,
	size = 20,
	float_opts = {
		border = "none",
	},
})

function Dtgit_toggle()
	DTgit:toggle()
end
local SystemMonitoring = Terminal:new({
	cmd = MyVar.Sysmon,
	direction = "float",
	size = 20,
})

function Sysmon_toggle()
	SystemMonitoring:toggle()
end
