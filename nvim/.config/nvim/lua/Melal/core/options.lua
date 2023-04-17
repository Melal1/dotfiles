--\\ Variable //-- 

local o = vim.opt


--\\ Tab //--

o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true

--\\ Line Wrap//--

o.wrap = true

--\\ Search settings//--

o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

--\\ appearance //--

-- Down
cmdheight = 1
pumheight = 10
o.showmode = false 
-- Up
showtablines = false
-- Split
splitbelow = true
splitright = true
-- Num
o.number = true 
o.relativenumber = false
o.numberwidth = 5
-- Others
o.termguicolors = true
o.signcolumn = "no"

--\\ Backspace //--

o.backspace = "indent,eol,start"

--\\ Clipboard //--

o.clipboard = "unnamedplus"

--\\ Cursor //--

o.cursorline = true
o.mouse = "a"

--\\ Backup and Other stuff //--

o.writebackup = false
o.backup = false
o.swapfile = false
o.undofile = true

--\\ Words format //--

o.iskeyword:append({"-","+","="})
