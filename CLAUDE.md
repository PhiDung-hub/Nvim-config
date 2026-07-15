# Neovim Configuration

Performance-focused Neovim config on **Lazy.nvim**, optimized for fast startup. Aggressive lazy-loading, minimal startup plugins, comprehensive LSP/completion.

## Architecture

Entry: `init.lua` → `vim.loader.enable()`, then `require("config.lazy")` and `require("config.keymaps")`.

```
~/.config/nvim/
├── init.lua                                   # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua                           # Lazy bootstrap + all vim.opt settings + spec imports
│   │   └── keymaps.lua                        # Global keybindings (local map = vim.keymap.set)
│   ├── plugins/
│   │   ├── init.lua                           # plenary.nvim (lazy, on require)
│   │   ├── aesthetics/                        # kanagawa (+color_schemes/), indent-blankline,
│   │   │                                      #   web-devicons, colorizer, todo-comments
│   │   ├── editor_utils/                      # neo-tree, telescope, toggleterm, which-key, lualine,
│   │   │                                      #   autopairs, bigfile, bufferline, persistence
│   │   ├── language_server_protocols/         # LSP, blink.cmp, conform, lspsaga, mason,
│   │   │   └── 3rd_party_plugins/             #   nvim-lint, treesitter, render-markdown / supermaven, codecompanion
│   │   └── gits/                              # gitsigns
└── lazy-lock.json
```

Spec imports (in `lua/config/lazy.lua`): `plugins`, `plugins.editor_utils`, `plugins.language_server_protocols`, `plugins.language_server_protocols.3rd_party_plugins`, `plugins.gits`, `plugins.aesthetics`, `plugins.aesthetics.color_schemes`.

## Core Settings (`lua/config/lazy.lua`)

- **Leader / localleader**: `<Space>`
- **Performance**: `updatetime=200`, `timeoutlen=300`, `pumheight=10`, `undolevels=5000`
- **Indent**: 2 spaces, `expandtab`, `smartindent`, `autoindent`
- **Search**: `ignorecase` + `smartcase`, `incsearch`, `hlsearch`
- **Folding**: native treesitter — `foldmethod=expr`, `foldexpr=v:lua.vim.treesitter.foldexpr()`, `foldlevel=99` (all open)
- **UI**: `number`+`relativenumber`, `signcolumn=yes`, `termguicolors`, `laststatus=0`, `conceallevel=3`, `scrolloff=10`
- **Clipboard**: Linux `xsel` integration
- `vim.loader.enable()` for faster module loading

## Plugins

Everything is lazy-loaded — zero startup plugins (plenary is `lazy = true`, pulled in on `require`).

### Lazy-load triggers
```
InsertEnter         → blink.cmp, supermaven, autopairs
InsertEnter/Cmdline → blink.cmp
BufReadPre          → bigfile.nvim (large-file guard), persistence
BufReadPost/NewFile → gitsigns, treesitter, bufferline
VeryLazy            → lualine, indent-blankline, which-key, mason, nvim-lint, colorizer, todo-comments
LspAttach           → lspsaga
ft=markdown         → render-markdown.nvim
keys/cmd            → neo-tree, telescope, toggleterm, conform, codecompanion
```

### Notable plugins
- **blink.cmp** — completion engine (replaces nvim-cmp). Sources: lsp, path, snippets, buffer.
- **supermaven-nvim** — inline ghost-text AI. Accept handled by blink (see Completion).
- **codecompanion.nvim** — AI chat/inline over OpenRouter free models (needs `OPENROUTER_API_KEY`). `<leader>aa` toggle chat, `<leader>ae` add selection.
- **conform.nvim** — formatting (replaces none-ls), format-on-save via `BufWritePre`.
- **nvim-lspconfig + mason** — LSP. **lspsaga** — LSP UI (hover/finder/rename/outline).
- **nvim-treesitter** (master branch, pinned) — highlight/indent/folding; rainbow-delimiters, ts-context-commentstring, ts-autotag deps.
- **neo-tree** — file explorer (async scan tuned for large trees). **telescope** — fuzzy finder.
- **bigfile.nvim** — disables heavy features on files >1.5 MB.
- **render-markdown.nvim** — inline in-buffer markdown rendering (replaces browser preview).
- **kanagawa** colorscheme (priority 1000), **lualine**, **gitsigns**, **which-key**, **toggleterm**, **autopairs**, **indent-blankline**, **web-devicons**.
- **bufferline** (buffer tabs, normal-mode `<Tab>`/`<S-Tab>` cycle), **persistence** (sessions, `<leader>qs`/`<leader>ql`), **todo-comments**, **colorizer** (catgoose fork).

## LSP / Mason

Servers configured **and** enabled in `nvim_lspconfig.lua` (native `vim.lsp.config`/`vim.lsp.enable`, nvim 0.11+ API):
`ts_ls`, `emmet_ls`, `tailwindcss`, `svelte`, `jsonls`, `html`, `cssls`, `ruff` (Python), `solidity_ls_nomicfoundation`, `move_analyzer` (Sui Move).

- `ts_ls` document formatting is disabled (conform/prettier handles it).
- `solidity_ls_nomicfoundation` and `move_analyzer` use custom `cmd`s and are **not** installed by Mason (system/manual install).
- Mason `ensure_installed` (servers): cssls, html, jsonls, ts_ls, tailwindcss, svelte, emmet_ls, ruff, move_analyzer. Mason tools: `stylua`, `prettierd`.
- `on_attach` enables semantic tokens + native document highlights (CursorHold) when supported.

## Formatters & Linters

- **conform.nvim** (`formatters_by_ft`): `lua→stylua`; `js/jsx/ts/tsx/json/html/css/scss/markdown/yaml/svelte → prettierd` (falls back to prettier, `stop_after_first`); `solidity → forge_fmt`. Format-on-save + `<leader>f`.
- **nvim-lint**: `solidity → solhint` only, on `BufEnter`/`TextChanged`/`InsertLeave` for `*.sol`.

## Treesitter

`ensure_installed` (16, `auto_install=true`): lua, python, javascript, typescript, tsx, json, html, css, scss, markdown, markdown_inline, gitignore, svelte, solidity, move.
- **Sui Move** parser registered from `tzakian/tree-sitter-move` (not in registry).
- **Big-file backstop**: `highlight.disable` skips TS highlighting on files **>512 KB** (distinct from bigfile.nvim's 1.5 MB feature cutoff).

## Completion & AI

**blink.cmp** keymaps (`blink_cmp.lua`):
- `<Right>` — accept selected (or first) menu item with LSP auto-import; if no menu, accept the supermaven inline suggestion; else literal right (normal-mode `<Tab>` belongs to bufferline)
- `<Up>`/`<Down>` and `<C-n>`/`<C-p>` — navigate menu
- `<CR>` accept · `<C-e>` cancel · `<C-b>`/`<C-f>` scroll docs

**supermaven** (`disable_keymaps=true`, accept owned by blink's `<Right>`): `<C-j>` accept word · `<C-]>` clear suggestion.

## Key Mappings (`lua/config/keymaps.lua`)

```
" Navigation / windows
q                  → visual block mode (<C-v>)
zh/zk/zj/zl        → window left/up/down/right
sv                 → vertical split

" Editing
<C-a>              → select all
<F3>               → reformat file (gg=G)
<C-c>              → copy to system clipboard (n/v)
<C-s>              → save (n/i/v)
<C-z> / <C-y>      → undo / redo
<C-m-k>/<C-m-j>    → move line up/down
<Esc><leader>      → exit terminal mode
```
Plugin keys: `<M-t>` neo-tree, `<S-M-G/B/T>` neo-tree floats · telescope `;f` files `;r` grep `\\` buffers `;t` help `;;` resume `;e` diagnostics (preview shows line numbers) · lspsaga `K gf gp gr gd <leader>o` · `<leader>f` format · `<leader>p` markdown render (markdown buffers) · `<m-->` toggleterm.

## Maintenance

```bash
nvim +Lazy sync +qa      # update plugins
nvim +Lazy clean +qa     # remove plugins no longer in spec
nvim +Mason +qa          # manage language servers
nvim --startuptime startup.log   # profile startup
```
`:Lazy profile` · `:LspInfo` · `:ConformInfo`.

## Gotchas

- **Treesitter pinned to `master`** — the `main` branch is a full rewrite needing nvim 0.12+ nightly and breaks the `nvim-treesitter.configs` API used here.
- **Folding is native** (treesitter foldexpr), no folding plugin. `za`/`zR`/`zM` are native commands.
- **Accept key is shared**: blink.cmp owns insert-mode `<Right>` and delegates to supermaven when no completion menu is open. Don't re-bind accept in supermaven. Normal-mode `<Tab>`/`<S-Tab>` cycle bufferline buffers.
- **Stale parsers shadow the plugin**: never leave compiled parsers in `~/.local/share/nvim/site/parser/` — that dir precedes nvim-treesitter on the runtimepath and outdated `.so` files break its queries (e.g. `Invalid node type "except*"`).
- Solidity/Move language servers are not Mason-managed — ensure `nomicfoundation-solidity-language-server` and `move-analyzer` are on `PATH`.
