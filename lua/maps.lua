local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap
local vnoremap = require("keymap").vnoremap
local xnoremap = require("keymap").xnoremap

-- window and file management
nnoremap('<C-a>', 'gg<S-v>G') -- select all
nnoremap("<leader>t", "<cmd>NvimTreeToggle<CR>") -- toggle nvim-tree
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




