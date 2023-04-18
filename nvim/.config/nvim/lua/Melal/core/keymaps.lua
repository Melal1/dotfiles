vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- || var || -- 

local key = vim.keymap 

-- General 

key.set("i", "jk", "<ESC>") -- Press  jk fast in insert mode to enter normal mode 
key.set("n", "<leader>nh", ":noh<CR>") -- clear the search highlighte  
key.set("v", "d", '"_d') -- Delete the text without copying it 
key.set("v", "p", '"_dP')
key.set("n", "ew", "<END>")
key.set("n", "<leader>=", "<C-a>")
key.set("n", "<leader>-", "<C-x>")


-- Nvim-tree
key.set("n", "<leader>e", ":NvimTreeToggle<CR>")
key.set("n", "<leader>fn", ":NvimTreeFocus<CR>")


-- Telescope 
key.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
key.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")    --- Needs ripgrep 
key.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")  -- Needs ripfrep 

