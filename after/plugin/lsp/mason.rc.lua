local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

-- Available server: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  "cssls",
  "emmet_ls",
  "html",
  "jsonls",
  "solang",
  "terraformls",
  "tsserver",
  "tailwindcss",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
}

mason.setup({})
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}
