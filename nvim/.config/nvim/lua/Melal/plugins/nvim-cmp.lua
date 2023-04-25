-- Import nvim-cmp plugin safely
local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

-- Import luasnip plugin safely
local luaok, luasnip = pcall(require, "luasnip")
if not ok then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	print(" lspkind is not working or not installed")
	return
end

-- i don't know what is this but i added cuz it's needed for tab and s-tab
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end
-- custom icons

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- Load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

--
--
--
-- CMD setup
--
--
--

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			{
				border = "double",
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Pmenusel,Search:None",
			},
		}),
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	formatting = {
		-- arrangement --
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				-- you can chanege the name that will show up on the menu here
				nvim_lsp = " ",
				luasnip = " ",
				buffer = "󰈔",
				path = " ",
			})[entry.source.name]
			return vim_item
		end,
	},

	-- arrangement --
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},

	--  configure lspkind for vs-code like icons
	-- formatting = {
	--   format = lspkind.cmp_format({
	--     maxwidth = 50,
	--     ellipsis_char = "...",
	--   }),
	-- },
})
