local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {}

local options = { noremap = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', options)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', options)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', options)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', options)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', options)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', options)
