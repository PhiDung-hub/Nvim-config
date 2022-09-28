local nnoremap = require("helpers.keymap").nnoremap
local inoremap = require("helpers.keymap").inoremap
local vnoremap = require("helpers.keymap").vnoremap
local xnoremap = require("helpers.keymap").xnoremap

-- Exit terminal mode
vim.api.nvim_set_keymap('t', "<leader><Esc>", [[<C-\><C-n>]], {noremap=true})

-- window and file management
nnoremap('<C-a>', 'gg<S-v>G') -- select all
-- nnoremap("<leader>t", "<cmd>NvimTreeToggle<CR>") -- toggle nvim-tree
nnoremap("<leader>t", "<cmd>NeoTreeFocusToggle<CR>") -- toggle nvim-tree
nnoremap("<leader>r", "<cmd>NvimTreeRefresh<CR>") -- refresh nvim-tree
nnoremap("<F3>", "gg=G<C-o>") -- reformat entire file with F3

-- Split window
nnoremap('ss', ':split<CR><C-w>w')
nnoremap('sv', ':vsplit<CR><C-w>w')
-- Move window
nnoremap('zh', '<C-w>h')
nnoremap('zk', '<C-w>k')
nnoremap('zj', '<C-w>j')
nnoremap('zl', '<C-w>l')

-- Coppy and paste
nnoremap('<C-c>', '"*y')
inoremap('<C-c>', '"*y')
vnoremap('<C-c>', '"*y')
xnoremap('<C-c>', '"*y')

-- Do, undo.
inoremap('<C-Z>', '<C-O>u')
inoremap('<C-Y>', '<C-O><C-R>')

-- press Ctrl-S to save
inoremap('<C-S>', '<ESC>:up<CR>a')
vnoremap('<C-S>', '<ESC>:up<CR>gv')
nnoremap('<C-S>', ':up<CR>')

-- Move lines up and down
nnoremap('<A-j>', ':m .+1<CR>==')
nnoremap('<A-k>', ':m .-2<CR>==')
vnoremap('<A-j>', ":m '>+1<CR>gv=gv")
vnoremap('<A-k>', ":m '<-2<CR>gv=gv")
