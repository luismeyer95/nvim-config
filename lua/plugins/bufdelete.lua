return {
  "famiu/bufdelete.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>xb", function() require('bufdelete').bufdelete(0) end, desc = "close buffer" },
  }
}
