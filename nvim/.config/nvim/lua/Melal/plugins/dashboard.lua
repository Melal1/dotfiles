local status, dash = pcall(require, "dashboard")
if not status then
	print("dashboard is not installed")
	return
end

-- vim.g.dashboard_default_executive = "telescope"
dash.setup({
	theme = "doom",
	config = {
		header = {

			"                                 ",
			"                                 ",
			"                                 ",
			"                                 ",
			"                                 ",
			"                                 ",
			"                                 ",
			"                                 ",
			"           ▄ ▄                   ",
			"       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
			"       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
			"    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
			"  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
			"  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
			"▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
			"█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
			"    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
			"                                 ",
			"                                 ",
		}, --your header
		center = {
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Find File           ",
				desc_hl = "String",
				key = "a",
				-- keymap = "SPC f f",
				-- key_hl = "Number",
				action = "Telescope find_files hidden=true",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Recent Files",
				desc_hl = "String",
				key = "b",
				-- keymap = "SPC f d",
				action = "Telescope oldfiles",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Find Text",
				desc_hl = "String",
				key = "c",
				-- keymap = "SPC f d",
				action = "Telescope live_grep",
			},
			{
				icon = " ",
				icon_hl = "title",
				desc = "MyProjects",
				desc_hl = "string",
				key = "d",
				-- keymap = "spc f d",
				action = ":Telescope projects",
			},
			{
				icon = " ",
				icon_hl = "title",
				desc = "hyprland",
				desc_hl = "string",
				key = "e",
				-- keymap = "spc f d",
				action = ":edit ~/.dotfiles/hypr/.config/hypr/",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Lazygit",
				desc_hl = "String",
				key = "f",
				-- keymap = "SPC f d",
				action = ":lua Allgit_toggle()",
			},
			{
				icon = "󰔎 ",
				icon_hl = "Title",
				desc = "Themes",
				desc_hl = "String",
				key = "g",
				action = ":luafile ~/.config/nvim/lua/Melal/plugins/MelalthemeSw.lua",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Dotfiles",
				desc_hl = "String",
				key = "h",
				-- keymap = "SPC f d",
				action = ":edit ~/.dotfiles/",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Configuration",
				desc_hl = "String",
				key = "i",
				action = ":edit $HOME/.dotfiles/nvim/.config/nvim/",
			},
			{
				icon = "󰚦 ",
				icon_hl = "Title",
				desc = "Power off !!",
				desc_hl = "String",
				key = "j",
				-- keymap = "SPC f d",
				action = ":! shutdown now",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Bye ~",
				desc_hl = "String",
				key = "q",
				-- keymap = "SPC f d",
				action = "qa",
			},
		},
		footer = { "Welcome Melal ~" }, --your footer
	},
})
--
-- vim.dashboard_custom_section = {
-- 	a = { description = { "  Find File          " }, command = "Telescope find_files" },
-- 	d = { description = { "  Search Text        " }, command = "Telescope live_grep" },
-- 	b = { description = { "  Recent Files       " }, command = "Telescope oldfiles" },
-- 	e = { description = { "  Config             " }, command = "edit ~/.config/nvim/init.lua" },
-- 	f = { description = { " Dotfiles            " }, command = "edit ~/.dotfiles" },
-- }
-- vim.g.dashboard_custom_footer = { "Welcome , Melal ~" }
