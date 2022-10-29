local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

-- Available server: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
-- With instruction for config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "cssls",
  "emmet_ls",
  "html",
  "jsonls",
  "solang",
  "solidity",
  "tsserver",
  "tailwindcss",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
  "marksman",
}

mason.setup({})
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

-- nvim_create_augroup({name}, {*opts}) nvim_create_augroup() Create or get an autocommand group autocmd-groups.
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end

local protocol = require("vim.lsp.protocol")
protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(protocol.make_client_capabilities())

-- markdown
-- nvim_lsp.marksman.setup({
--   on_attach = on_attach,
--   filetypes = { "markdown", "markdown.mdx" },
--   capabilities = capabilities,
-- })

-- javascript & react & html & css
nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
})
nvim_lsp.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
})
nvim_lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
nvim_lsp.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
})
nvim_lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- rust
nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- cpp
local clangd_cap = capabilities
clangd_cap.textDocument.semanticHighlighting = true
clangd_cap.offsetEncoding = "utf-16"
nvim_lsp.clangd.setup({
  on_attach = on_attach,
  capabilities = clangd_cap,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
  },
})

-- Python
nvim_lsp.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Solidity
nvim_lsp.solang.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp.solidity.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lua & neovim
nvim_lsp.sumneko_lua.setup({
  capabilities = capabilities,
  single_file_support = true,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print("File Loaded")
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },

      telemetry = { enable = false },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = true,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
