return {
  "famiu/bufdelete.nvim",
  lazy = false,
  keys = {
    { "<leader>x", function() require('bufdelete').bufdelete(0) end },
  }
}
