return {
  "nvim-neo-tree/neo-tree.nvim",
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
      bind_to_cwd = false,
    },
    window = {
      position = "float",
    }
  },
}
