return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat" },
    { "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI add selection to chat" },
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  -- Free models via OpenRouter (needs OPENROUTER_API_KEY in the environment).
  -- Swap the default for e.g. "deepseek/deepseek-chat-v3.1:free" or
  -- "meta-llama/llama-4-maverick:free".
  opts = {
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openrouter", {
            env = { api_key = "OPENROUTER_API_KEY" },
            schema = { model = { default = "qwen/qwen3-coder:free" } },
          })
        end,
      },
    },
    interactions = {
      chat = { adapter = "openrouter" },
      inline = { adapter = "openrouter" },
    },
  },
}
