return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
    }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end
}
