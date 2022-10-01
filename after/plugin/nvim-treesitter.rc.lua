local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "vim",
    "solidity",
    "rust",
    "json",
    "jsdoc",
    "graphql",
    "gitignore",
    "gitattributes",
    "c",
    "cpp",
    "dockerfile",
    "bash",
    "prisma",
    "python",
    "toml",
    "json",
    "yaml",
    "css",
    "scss",
    "html",
    "lua",
    "vue",
  },
  autotag = {
    enable = true,
  },
  -- nvim-ts-rainbow plugin: https://github.com/p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_line = nil,
    disable = {}, -- list of languages you want to disable the plugin for
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
