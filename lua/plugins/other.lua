return {
  "rgroli/other.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {
      "angular",
    }
  },
  keys = {
    { "<leader>ot", mode = "n", "<cmd>Other<cr>", desc = "open other" },
  },
  config = function(_, opts)
    require("other-nvim").setup(opts)
  end
}
