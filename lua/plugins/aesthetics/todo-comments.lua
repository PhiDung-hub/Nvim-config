return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  -- Only deltas from plugin defaults: custom icons and colors.
  opts = {
    keywords = {
      FIX = { icon = " " },
      TODO = { icon = "★ " },
      WARN = { icon = " " },
      PERF = { icon = "🗲" },
      NOTE = { icon = " " },
    },
    colors = {
      info = { "DiagnosticInfo", "#61AFEF" },
      warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
    },
  },
}
