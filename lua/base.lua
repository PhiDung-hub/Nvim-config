vim.cmd [[set mouse=a]]
vim.opt.hidden = true
vim.cmd [[set report=2]]
vim.g.mapleader = " "

-- Encodings
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.colorcolumn = "150"

-- maintain undo history between sessions
vim.cmd([[set undofile]])

-- Editing settings
-- -------------
vim.opt.tabstop = 2 -- using spaces
vim.opt.softtabstop = 2 -- treat tab in editting as single character
vim.opt.shiftwidth = 2 --
vim.opt.smarttab = true -- insert Tab in a blank line will be determined by other places. Backspasce delete shiftwidth
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.autoindent = true -- New line inherit indentation of previous lines
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.backspace = { 'start', 'eol', 'indent' }

-- Search
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- switch between case-sensitive whenever uppercase letter present
vim.opt.incsearch = true -- incremental search (Default = ON)
vim.opt.hlsearch = true -- Enable search highlighting (Default = ON)

-- Current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.cmd [[hi CursorLineNR guifg=#fff ]]
