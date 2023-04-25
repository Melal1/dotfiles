vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- || var || --

local key = vim.keymap
local opts = { noremap = true, silent = true }

-- General
key.set("n", "<m-h>", "<C-w>h", opts)
key.set("n", "<m-j>", "<C-w>j", opts)
key.set("n", "<m-k>", "<C-w>k", opts)
key.set("n", "<m-l>", "<C-w>l", opts)
key.set("i", "jk", "<ESC>") -- Press  jk fast in insert mode to enter normal mode
key.set("n", "<leader>nh", ":noh<CR>", opts) -- clear the search highlighte
key.set("v", "d", '"_d', opts) -- Delete the text without copying it
key.set("v", "p", '"_dp', opts)
key.set("n", "ew", "<END>", opts)
key.set("n", "<leader>=", "<C-a>", opts)
key.set("n", "<leader>-", "<C-x>", opts)

-- Tabs --
key.set("n", "<m-t>", ":tabnew %<cr>", opts)
key.set("n", "<m-y>", ":tabclose<cr>", opts)
-- key.set("n", "<m-\\>", ":tabonly<cr>", opts)

-- Visual --
-- Stay in indent mode
key.set("v", "<", "<gv", opts)
key.set("v", ">", ">gv", opts)

-- comment
-- key.set("n", "<m-/>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)

-- Resize with arrows
key.set("n", "<C-Up>", ":resize -2<CR>", opts)
key.set("n", "<C-Down>", ":resize +2<CR>", opts)
key.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)
key.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
-- Nvim-tree
key.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
key.set("n", "<leader>fn", ":NvimTreeFocus<CR>", opts)

-- Telescope
key.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", opts)
key.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", opts) --- Needs ripgrep
key.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", opts) -- Needs ripfrep

-- Naviagate buffers
key.set("n", "<S-l>", ":bnext<CR>", opts)
key.set("n", "<S-h>", ":bprevious<CR>", opts)
key.set("n", "Q", "<cmd>bdelete!<CR>", opts)
-- Move text up & down
key.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
key.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Functions
key.set("n", "<F2>", "<cmd>lua Allgit_toggle()<CR>", opts)
key.set("n", "<F3>", "<cmd>lua Sysmon_toggle()<CR>", opts)
key.set("n", "<F4>", "<cmd>lua Dtgit_toggle()<CR>", opts)
-- Dashboard
key.set("n", "<F13>", "<cmd>Dashboard<CR>", opts)

-- insert mode
key.set("i", "<C-f>", "<ESC>wa")
key.set("i", "<C-b>", "<ESC>bi")
-- key.set("i", "<C-j>", "<ESC>ji")
-- key.set("i", "<C-k>", "<ESC>ki")

-- Theme switcher
key.set("n", "<leader>th", "<cmd>luafile ~/.config/nvim/lua/Melal/plugins/MelalthemeSw.lua<CR>")
