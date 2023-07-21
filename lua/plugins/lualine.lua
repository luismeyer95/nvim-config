return {
  'nvim-lualine/lualine.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  opts = {
    sections = {
      lualine_c = {
        {
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
          end,
          color = "Directory",
          icon = '',
        },
        {
          'filetype',
          separator = '',
          icon_only = true,
        },
        {
          "filename",
          path = 1,
        },
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
