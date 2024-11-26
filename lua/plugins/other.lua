return {
  "rgroli/other.nvim",
  lazy = false,
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
