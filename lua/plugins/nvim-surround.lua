return {
  "kylechui/nvim-surround",
  lazy = false,
  version = "*",   -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup {
      -- Configuration here, or leave empty to use defaults
    }
  end,
}
