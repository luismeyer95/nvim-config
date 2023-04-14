return {
  "famiu/bufdelete.nvim",
  lazy = false,
  keys = {
    { "<leader>xb", function() require('bufdelete').bufdelete(0) end, desc = "close buffer" },
  }
}
