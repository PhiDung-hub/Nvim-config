local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- ** UNCOMMENT THIS & on_attach() IN SET UP FOR FORMMATING ON SAVE **
-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       return client.name == "null-ls"
--     end,
--     bufnr = bufnr,
--   })
-- end

-- WARNING: Make sure to install these tools using Mason.
null_ls.setup({
  debug = false,
  sources = {
    -- python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- diagnostics.pylint,

    -- JS, JSX, TSX
    diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    }),
    formatting.prettier,

    -- lua
    diagnostics.selene, -- take note of global 'vim': https://www.reddit.com/r/neovim/comments/wlkc7c/configuring_global_variablesvim_in_selene/?utm_source=share&utm_medium=web2x&context=3
    formatting.stylua,

    -- markdown
    -- diagnostics.markdownlint.with({
    --   line_length = 150,
    --   ignore_code_blocks = true,
    --   disabled_filetypes = {},
    -- ),

    -- shell
    -- diagnostics.shellcheck,

    -- snippets & utils
    completion.luasnip,
  },

  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         lsp_formatting(bufnr)
  --       end,
  --     })
  --   end
  -- end
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "rust" },
  generator = {
    fn = function(params)
      local diag = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find("unwrap()")
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diag, {
            row = i,
            col = col,
            end_col = end_col,
            source = "unwrap",
            message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diag
    end,
  },
}

null_ls.register(unwrap)
