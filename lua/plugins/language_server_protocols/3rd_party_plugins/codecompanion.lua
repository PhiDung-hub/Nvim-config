return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat" },
    { "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI add selection to chat" },
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  -- Models via OpenRouter (needs OPENROUTER_API_KEY in the environment).
  -- Chat: Kimi K2.7 code (paid but ~$0.7/M input tokens — pennies).
  -- Inline: free Qwen3 Coder. Other free options: qwen/qwen3-next-80b-a3b-instruct:free,
  -- meta-llama/llama-3.3-70b-instruct:free, openai/gpt-oss-20b:free.
  opts = {
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openrouter", {
            env = { api_key = "OPENROUTER_API_KEY" },
            schema = { model = { default = "moonshotai/kimi-k2.7-code" } },
          })
        end,
      },
    },
    interactions = {
      chat = { adapter = "openrouter" },
      inline = { adapter = { name = "openrouter", model = "qwen/qwen3-coder:free" } },
    },
  },
}
