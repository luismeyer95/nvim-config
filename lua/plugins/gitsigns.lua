return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    vim.cmd "highlight GitSignsAdd guifg=#00ff00 guibg=NONE gui=NONE"    -- green foreground
    vim.cmd "highlight GitSignsDelete guifg=#ff0000 guibg=NONE gui=NONE" -- red foreground
  end,
}
