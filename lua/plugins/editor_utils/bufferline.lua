return {
  "akinsho/nvim-bufferline.lua", -- buffer navigation on top
  event = { "BufReadPost" },
  config = function()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
      print("WARNING: nvim-bufferline is unavailable")
      return
    end

    bufferline.setup({
      options = {
        separator_style = "thin",
        numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = "Bdelete! %d", -- Delete current buffer
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon",
          -- style = "underline",
        },
        diagnostics_indicator = function(count, _, _, _)
          if count > 9 then
            return "9+"
          end
          return tostring(count)
        end,
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 25,
        max_prefix_length = 25, -- prefix used when a buffer is de-duplicated.
        tab_size = 18,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "📁 File System",
            text_align = "center",
          },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
      highlights = {
        buffer_selected = {
          fg = "#fdf6e3",
          bold = true,
          italic = false,
        },
        fill = {
          bg = "#073642",
        },
      },
    })

    local nnoremap = require("helpers.keymap").nnoremap
    nnoremap("<Tab>", "<Cmd>BufferLineCycleNext<CR>")
    nnoremap("<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")
    nnoremap("<m-p>", "<Cmd>BufferLineTogglePin<CR>")

    nnoremap("db", "<Cmd>BufferLinePickClose<CR>")
    nnoremap("dlb", "<Cmd>BufferLineCloseLeft<CR>")
    nnoremap("drb", "<Cmd>BufferLineCloseRight<CR>")

    -- jump to buffer number
    nnoremap("<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
    nnoremap("<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
    nnoremap("<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
    nnoremap("<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
    nnoremap("<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
    nnoremap("<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
    nnoremap("<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
    nnoremap("<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
    nnoremap("<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
    nnoremap("<leader>0", "<Cmd>BufferLineGoToBuffer -1<CR>")
  end,
}
