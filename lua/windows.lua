-- vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
local is_wsl = vim.fn.has("wsl")

-- https://github.com/microsoft/terminal/issues/11945#issuecomment-1173535628
if is_wsl then
  vim.g.clipboard = {
    name = "wslclipboard",
    copy = {
      ["+"] = "/usr/local/bin/win32yank.exe -i --crlf",
      ["*"] = "/usr/local/bin/win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "/usr/local/bin/win32yank.exe -o --lf",
      ["*"] = "/usr/local/bin/win32yank.exe -o --lf",
    },
    cache_enabled = 1,
  }
end
