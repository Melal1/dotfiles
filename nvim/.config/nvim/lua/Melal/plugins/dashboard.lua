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
				action = "Telescope find_files",
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
				icon = " ",
				icon_hl = "Title",
				desc = "Hyprland",
				desc_hl = "String",
				key = "d",
				-- keymap = "SPC f d",
				action = ":edit ~/.dotfiles/hypr/.config/hypr/",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Commits",
				desc_hl = "String",
				key = "e",
				-- keymap = "SPC f d",
				action = "Telescope git_commits",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Bye ~",
				desc_hl = "String",
				key = "f",
				-- keymap = "SPC f d",
				action = "qa",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Dotfiles",
				desc_hl = "String",
				key = "g",
				-- keymap = "SPC f d",
				action = ":edit ~/.dotfiles/",
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
