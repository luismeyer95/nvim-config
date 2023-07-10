return {
  'nvim-lualine/lualine.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  opts = {
    sections = {
      lualine_c = {
        "filename",
        {
          function()
            local key = require("grapple").key()
            return "  [" .. key .. "]"
          end,
          cond = require("grapple").exists,
        }
      }
    }
  },
}
