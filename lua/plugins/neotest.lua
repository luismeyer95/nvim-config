return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust"
  },
  opts = function()
    return {
      adapters = {
        require("neotest-rust")
      }
    }
  end
}
