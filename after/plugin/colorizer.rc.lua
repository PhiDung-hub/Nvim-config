local status, colorizer = pcall(require, "colorizer")
if (not status) then
  print("colorizer is not found")
  return
end

colorizer.setup({
  '*';
})
