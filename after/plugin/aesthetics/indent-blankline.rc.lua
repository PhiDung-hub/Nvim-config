local status, blankline = pcall(require, "indent_blankline")
if not status then
  return
end

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

-- Config: https://github.com/lukas-reineke/indent-blankline.nvim
blankline.setup({
  -- for example, context is off by default, use this to turn it on
  space_char_blankline = " ",
  show_current_context = true,
  -- show_current_context_start = true,
})
