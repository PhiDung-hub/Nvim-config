local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local icons = require("icons")

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  actions = {
    change_dir = {
      enable = false,
    },
    open_file = {
      quit_on_open = false,
    },
  },

  focus_empty_on_setup = true,
  hijack_cursor = true,
  hijack_netrw = true,
  update_cwd = true,

  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },

  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },

  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Information,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },

  update_focused_file = {
    enable = true,
    update_cwd = true,
  },

  filters = {
    custom = { "^.git$", "^.sqlite$", "cache/" },
  },

  view = {
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "v", cb = tree_cb("vsplit") },
      },
    },
    number = true,
    relativenumber = false,
  },
})

local nnoremap = require("helpers.keymap").nnoremap
nnoremap("<leader>t", "<cmd>NvimTreeToggle<CR>") -- toggle nvim-treekj
