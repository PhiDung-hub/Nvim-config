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
    "sql",
    "rust",
    "json",
    "jsdoc",
    "graphql",
    "gitignore",
    "gitattributes",
    "c",
    "cpp",
    "dockerfile",
    "c_sharp",
    "bash",
    "prisma",
    "python",
    "toml",
    "php",
    "json",
    "yaml",
    "swift",
    "css",
    "scss",
    "html",
    "lua",
    "vue",
    "svelte",
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
