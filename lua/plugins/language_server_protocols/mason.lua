return {
  "williamboman/mason.nvim", -- LSP/DAP/Linters/Formatters installer
  cmd = "Mason",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          "stylua",
          "prettierd",
        },
      },
    },
  },
  config = function()
    require("mason").setup({})
    -- Install these LSP servers; setup is handled in nvim_lspconfig.lua
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- web
        "cssls",
        "html",
        "jsonls",
        "ts_ls",
        "tailwindcss",
        "svelte",
        "emmet_ls",

        -- python
        "ruff",

        -- sui move
        "move_analyzer",
      },
      automatic_enable = {
        exclude = { "ts_ls" },
      },
    })
  end,
}
