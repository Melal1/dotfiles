-- Shorten function name
local SilentWnr = { noremap = true, silent = true }

local Silent = { silent = true }

local km = vim.api.nvim_set_keymap

--Remap space as leader key
km("", "<Space>", "<Nop>", SilentWnr)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
km("n", "<C-h>", "<C-w>h", SilentWnr)
km("n", "<C-j>", "<C-w>j", SilentWnr)
km("n", "<C-k>", "<C-w>k", SilentWnr)
km("n", "<C-l>", "<C-w>l", SilentWnr)

km("n", "<leader>e", ":Lex 30<cr>", SilentWnr)

-- Quit Neovim/Window
km("n", "<S-q>", ":q!<CR>", SilentWnr)

-- Resize with arrows
km("n", "<C-Up>", ":resize +2<CR>", SilentWnr)
km("n", "<C-Down>", ":resize -2<CR>", SilentWnr)
km("n", "<C-Left>", ":vertical resize -2<CR>", SilentWnr)
km("n", "<C-Right>", ":vertical resize +2<CR>", SilentWnr)

-- Navigate buffers
--km("n", "<S-l>", ":bnext<CR>", SilentWnr)
--km("n", "<S-h>", ":bprevious<CR>", SilentWnr)

-- Insert --
-- Press jk fast to enter
-- km("i", "jk", "<ESC>", SilentWnr)

-- Visual --
-- Stay in indent mode / move text right and left
km("v", "<", "<gv", SilentWnr)
km("v", ">", ">gv", SilentWnr)

-- Move text up and down
km("v", "<A-j>", ":m .+1<CR>==", SilentWnr)
km("v", "<A-k>", ":m .-2<CR>==", SilentWnr)
-- Better y
km("v", "p", '"_dP', SilentWnr)

-- Visual Block --
-- Move text up and down
km("x", "J", ":move '>+1<CR>gv-gv", SilentWnr)
km("x", "K", ":move '<-2<CR>gv-gv", SilentWnr)
km("x", "<A-j>", ":move '>+1<CR>gv-gv", SilentWnr)
km("x", "<A-k>", ":move '<-2<CR>gv-gv", SilentWnr)

-- Terminal --
-- Better terminal navigation
km("t", "<C-h>", "<C-\\><C-N><C-w>h", Silent)
km("t", "<C-j>", "<C-\\><C-N><C-w>j", Silent)
km("t", "<C-k>", "<C-\\><C-N><C-w>k", Silent)
km("t", "<C-l>", "<C-\\><C-N><C-w>l", Silent)

