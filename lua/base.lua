vim.cmd [[set mouse=a]]
vim.opt.hidden = true
vim.cmd [[set report=2]]
vim.g.mapleader = " "

vim.wo.relativenumber=true
vim.wo.number=true
vim.wo.colorcolumn= "150"

-- maintain undo history between sessions
vim.cmd([[ set undofile]])

-- Editing settings
-- -------------
vim.cmd [[set tabstop=2]]
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.smarttab=true
-- no case sensitive search
vim.opt.ignorecase=true
-- but case should be smart when upper case used
vim.opt.smartcase=true
vim.opt.clipboard="unnamedplus"
