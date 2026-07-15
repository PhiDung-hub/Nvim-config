return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "kanagawa",
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "|" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { { "filename", file_status = true, path = 1 } },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = "\u{f057} ", warn = "\u{f071} ", info = "\u{f05a} ", hint = "\u{f0eb} " },
        },
        "encoding",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", file_status = true, path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
