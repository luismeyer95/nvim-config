return {
  "Bryley/neoai.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>as", desc = "summarize text" },
    { "<leader>ag", desc = "generate git message" },
  },
  config = function(_, opts)
    vim.treesitter.language.register('markdown', 'neoai-output')
    require("neoai").setup(opts)
  end,
  opts = {
    models = {
      {
        name = "openai",
        model = "gpt-4",
        params = nil,
      },
      {
        name = "openai",
        model = "gpt-3.5-turbo",
        params = nil,
      },
    },
  }
}
