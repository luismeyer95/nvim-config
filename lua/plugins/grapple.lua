local prompt = require("utils.prompt").prompt

return {
  "cbochs/grapple.nvim",
  keys = {
    { "<leader>m",  function() require("grapple").toggle() end,        desc = "Toggle mark (Grapple)" },
    { "<leader>cm", function() require("grapple").cycle_forward() end, desc = "Cycle marks (Grapple)" },
    { "<leader>vm", "<cmd>GrapplePopup tags<cr>",                      desc = "View marks (Grapple)" },
    {
      "<leader>nm",
      function()
        prompt('Enter mark name: ', function(name) require("grapple").toggle({ key = name }) end)
      end,
      desc = "Create named mark (Grapple)"
    },
    {
      "<leader>gm",
      function()
        prompt('Go to mark: ', function(name) require("grapple").select({ key = name }) end)
      end,
      desc = "Go to named mark (Grapple)"
    },
  },
  lazy = false
}
