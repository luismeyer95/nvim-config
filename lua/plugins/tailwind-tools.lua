return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  -- disabled due to https://github.com/neovim/nvim-lspconfig/issues/4095
  enabled = false,
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig",         -- optional
  },
  opts = {},                         -- your configuration
}
