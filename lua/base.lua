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
vim.cmd([[ set undofile]])

-- Editing settings
-- -------------
vim.cmd [[set tabstop=2]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.backspace = { 'start', 'eol', 'indent' }
