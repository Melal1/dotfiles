vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- || var || -- 

local keym = vim.keymap 

-- General 

keym.set("i", "jk", "<ESC>") -- Press  jk fast in insert mode to enter normal mode 
keym.set("n", "<leader>nh", ":noh<CR>") -- clear the search highlighte  
keym.set("v", "d", '"_d') -- Delete the text without copying it 
keym.set("v", "p", '"_dP')
keym.set("n", "ew", "<END>")
keym.set("n", "<leader>=", "<C-a>")
keym.set("n", "<leader>-", "<C-x>")


-- Nvim-tree
keym.set("n", "<leader>e", ":NvimTreeToggle<CR>")
-- keym.set("n", "<leader>ne", ":NvimTreeFocus<CR>")


-- Telescope 
keym.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keym.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")    --- Needs ripgrep 
keym.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")  -- Needs ripfrep 
