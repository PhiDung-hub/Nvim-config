return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat" },
    { "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI add selection to chat" },
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  -- Free models only via OpenRouter (needs OPENROUTER_API_KEY in the environment).
  -- Other free options: qwen/qwen3-coder:free (code-specialist, often congested),
  -- tencent/hy3:free, poolside/laguna-xs-2.1:free.
  -- With credits, swap chat default to "moonshotai/kimi-k2.7-code" (~$0.7/M input).
  opts = {
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openrouter", {
            env = { api_key = "OPENROUTER_API_KEY" },
            schema = { model = { default = "nvidia/nemotron-3-ultra-550b-a55b:free" } },
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
