local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {}

local nnoremap = require("helpers.keymap").nnoremap
local inoremap = require("helpers.keymap").inoremap

-- See Lspsaga plugin.
nnoremap('<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
nnoremap('K', '<cmd>Lspsaga hover_doc<cr>')
nnoremap('gd', '<cmd>Lspsaga lsp_finder<cr>')
inoremap('<c-k>', '<cmd>Lspsaga signature_help<cr>')
nnoremap('gp', '<cmd>Lspsaga peek_definition<cr>')
nnoremap('gr', '<Cmd>Lspsaga rename<CR>')
