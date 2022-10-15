local status, hop = pcall(require, "hop")
if not status then
  return
end

hop.setup({
  keys = "etovxqpdygfblzhckisuran",
  jump_on_sole_occurrence = true,
  multi_windows = false,
})

local map = require("helpers.keymap")
local directions = require("hop.hint").HintDirection

-- replace default f/F/t/T, see https://github.com/phaazon/hop.nvim.
map.map("f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end)

map.map("F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end)

map.noremap("t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end)

map.noremap("T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end)

map.noremap("<leader>w", function()
  hop.hint_words({})
end)
map.noremap("<leader>l", function()
  hop.hint_lines_skip_whitespace({})
end)
map.noremap("<leader>g", "<cmd>:HopPattern<cr>")
