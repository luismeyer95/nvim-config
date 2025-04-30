local prompt = require("utils.prompt").prompt

return {
  "cbochs/grapple.nvim",
  keys = {
    { "<leader>m",  function() require("grapple").toggle() end,           desc = "Toggle mark (Grapple)" },
    { "<leader>cm", function() require("grapple").cycle_tags("next") end, desc = "Cycle marks (Grapple)" },
    { "<leader>vm", function() require("grapple").open_tags() end,        desc = "View marks (Grapple)" },
  },
  opts = {
    ---How a tag's path should be rendered in Grapple windows
    ---  "relative": show tag path relative to the scope's resolved path
    ---  "basename": show tag path basename and directory hint
    ---@type "basename" | "relative"
    style = "basename",

    ---A string of characters used for quick selecting in Grapple windows
    ---An empty string or false will disable quick select
    ---@type string | boolean
    quick_select = "1234567890",
  },
  lazy = false
}
