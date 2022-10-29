vim.cmd([[set mouse=a]]) -- enable mouse support
vim.opt.hidden = true -- hide abandoned buffer
vim.g.mapleader = " " -- leader key is ' ' in stead of '\'.

-- Encodings
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.bo.fileencoding = "utf-8"

vim.wo.relativenumber = false -- set relative number
vim.wo.number = true -- set line number
-- vim.wo.colorcolumn = "150"

-- maintain undo history between sessions
vim.cmd([[set undofile]])

-- Editing settings
vim.opt.tabstop = 2 -- using space`s
vim.opt.softtabstop = 2 -- treat tab in editting as single character
vim.opt.shiftwidth = 2 -- width of A LEVEL OF INDENTATION
vim.opt.smarttab = true -- insert Tab in a blank line will be determined by other places. Backspasce delete shiftwidth
vim.opt.autoindent = true -- New line inherit indentation of previous lines
vim.opt.smartindent = true -- Smart indentation when start a new line (for C-like programs).
vim.opt.expandtab = true -- Use space to insert a tab
vim.opt.wrap = false -- Wrap line when go beyond certain number of characters
vim.opt.backspace = { "start", "eol", "indent" } -- Allow backspacing over everything in insert mode
vim.opt.scrolloff = 15 -- scroll editor when there is x lines left

-- Search
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- switch between case-sensitive whenever uppercase letter present
vim.opt.incsearch = true -- incremental search (Default = ON)
vim.opt.hlsearch = true -- Enable search highlighting (Default = ON)

-- Current line
vim.opt.cursorline = true -- Enable highlight cursor line
vim.opt.cursorlineopt = "number,line" -- Include number & whole line
--
--

vim.cmd([[set report=3]]) -- report numbers of lines changed if greater than number
