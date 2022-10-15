local status, scrollview = pcall(require, "scrollview")
if not status then
  return
end

scrollview.setup({
  excluded_filetypes = { "nerdtree", "neo-tree" },
  current_only = true,
  winblend = 50,
  base = "buffer",
  column = 150,
})
