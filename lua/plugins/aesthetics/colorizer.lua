return {
  "catgoose/nvim-colorizer.lua", -- maintained fork of NvChad/nvim-colorizer.lua
  event = "VeryLazy",
  -- Only deltas from plugin defaults.
  opts = {
    user_default_options = {
      names = false,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      tailwind = "both",
      sass = { enable = "both", parsers = { "css" } },
    },
  },
}
