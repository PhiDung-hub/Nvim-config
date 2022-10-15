local status, zenMode = pcall(require, "zen-mode")
if not status then
  return
end

zenMode.setup({
  window = {
    backdrop = 0.9,
    width = 153,
    height = 1,
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = true, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function() end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function() end,
})

vim.keymap.set("n", "<C-M-O>", "<cmd>ZenMode<cr>", { silent = true })
