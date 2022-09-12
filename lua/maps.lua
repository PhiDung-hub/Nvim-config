local nnoremap = require("keymap").nnoremap

nnoremap('<C-a>', 'gg<S-v>G')
nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<C-s>", "<cmd>NvimTreeToggle<CR>")
nnoremap("<leader>r", "<cmd>NvimTreeRefresh<CR>")
