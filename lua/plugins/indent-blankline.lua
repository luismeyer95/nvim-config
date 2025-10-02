return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  -- enabled = false,
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
  },
}
